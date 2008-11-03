<?php
// SOFTWARE NAME: eZ publish
// SOFTWARE RELEASE: 1.0.0
// COPYRIGHT NOTICE: Copyright (C) 1999-2008 eZ Systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//
include_once( 'kernel/common/template.php' );

$http = eZHTTPTool::instance();
$tpl = templateInit();
$module = $Params['Module'];
$parentNodeID = $Params['ParentNodeID'];

// Check if current action is an real upload action
if( $module->isCurrentAction( 'Upload' ) )
{
    $result = array( 'errors' => array() );

    // Exec multiupload handlers preUpload method
    eZMultiuploadHandler::exec( 'preUpload', $result );

    // Handle file upload only if there was no errors
    if( count( $result['errors'] ) == 0 )
    {
        // Handle file upload. All checkes are performed by eZContentUpload::handleUpload()
        // and available in $result array
        $upload = new eZContentUpload();
        $upload->handleUpload( $result, 'Filedata', $parentNodeID, false );
    }

    // Exec multiupload handlers postUpload method
    eZMultiuploadHandler::exec( 'postUpload', $result );

    // Pass result to template and process it
    $tpl->setVariable( 'result', $result );
    $templateOutput = $tpl->fetch( 'design:ezmultiupload/thumbnail.tpl' );

    // Strip all new lines from processed template and convert all applicable characters to 
    // HTML entities output. Create upload ID
    $data = htmlentities( str_replace( array( "\n", "\r\n" ), array(""), $templateOutput ) , ENT_QUOTES );
    $id = md5( (string)mt_rand() . (string)microtime() );
 
    $response = array( 'data' => $data, 'id' => $id );

    // Return server response in JSON format
    echo eZAjaxContent::jsonEncode( $response );

    // Stop execution
    eZExecution::cleanExit();
}
else
{
    // Check if parent node ID provided in URL exists and is an integer
    if ( !$parentNodeID || !is_numeric( $parentNodeID ) )
        return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

    // Fetch parent node
    $parentNode = eZContentObjectTreeNode::fetch( $parentNodeID );
    
    // Check if parent node object exists
    if( !$parentNode )
        return $module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );

    // Check if current user has access to parent node and can create content inside
    if( !$parentNode->attribute( 'can_read' ) || !$parentNode->attribute( 'can_create' ) )
        return $module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel' );

    // Get configuration INI settings for ezmultiupload extension
    $uploadINI = eZINI::instance( 'ezmultiupload.ini' );
    $availableClasses = $uploadINI->variable( 'MultiUploadSettings', 'AvailableClasses' );
    $availableSubtreeList = $uploadINI->variable( 'MultiUploadSettings', 'AvailableSubtreeNode' );
    $parentNodeClassIdentifier = $parentNode->attribute( 'class_identifier' );

    // Check if current parent node class identifier and node ID match configuration settings
    if( !in_array( $parentNodeClassIdentifier, $availableClasses )
            && !in_array( $parentNodeID, $availableSubtreeList ) )
        return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );

    $availableFileTypes = array();
    $availableFileTypesStr = '';

    // Check if file types setting is available for current subtree
    if( $uploadINI->hasGroup( 'FileTypeSettings_' . $parentNodeID ) )
        $availableFileTypes = $uploadINI->variable( 'FileTypeSettings_' . $parentNodeID, 'FileType' );

    // Check if file types setting is available for current class identifier
    // and merge it with previusly loaded settings
    if( $uploadINI->hasGroup( 'FileTypeSettings_' . $parentNodeClassIdentifier ) )
        $availableFileTypes = array_merge( $availableFileTypes, $uploadINI->variable( 'FileTypeSettings_' . $parentNodeClassIdentifier, 'FileType' ) );

    // Create string with available file types for GUI uploader
    if ( count( $availableFileTypes ) > 0 )
        $availableFileTypesStr = implode( ';', $availableFileTypes );

    // Pass variables to upload.tpl template
    $tpl->setVariable( 'file_types', $availableFileTypesStr );
    $tpl->setVariable( 'session_id', $http->getSessionKey() );
    $tpl->setVariable( 'parent_node', $parentNode );
    $tpl->setVariable( 'siteaccess', $GLOBALS['eZCurrentAccess'] );

    // Process template and set path data
    $Result = array();
    $Result['content'] = $tpl->fetch( 'design:ezmultiupload/upload.tpl' );
    $Result['path'] = array( array( 'url' => false,
                                    'text' => ezi18n( 'extension/ezmultiupload', 'Multiupload' ) ) );
}

?>
