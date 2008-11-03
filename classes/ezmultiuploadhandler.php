<?php

class eZMultiuploadHandler
{
    static function instance( $type )
    {
        $obj = false;
        $params = array(
            'ini-name' => 'ezmultiupload.ini',
            'repository-group' => 'MultiUploadSettings',
            'repository-variable' => 'MultiuploadHandlerRepositories',
            'extension-group' => 'MultiUploadSettings',
            'extension-variable' => 'MultiuploadExtensions',
            'extension-subdir' => 'classes/multiuploadhandlers',
            'suffix-name' => 'multiuploadhandler.php',
            'type-directory' => false,
            'type' => strtolower( $type )
        );

        $result = eZExtension::findExtensionType( $params, $out );

        if ( $out['found-type'] == false )
        {
            eZDebug::writeError( 'Unable to find multiupload handler of type ' . $type );
            return $obj;
        }

        include_once( $out['found-file-path'] );

        $className = $out['type'] . 'MultiuploadHandler';
        $obj = new $className();
        return $obj;
    }

    static function exec( $method, &$result )
    {
        $ini = eZINI::instance( 'ezmultiupload.ini' );

        $handlers = $ini->variable( 'MultiUploadSettings', 'MultiuploadHandlers' );

        foreach ( $handlers as $hanlder )
        {
            $obj = eZMultiuploadHandler::instance( $hanlder );
            if ( $obj )
                $obj->$method( $result );
            else
                eZDebug::writeWarning( 'Multiupload handler implementation not found' );
        }

        return $result;
    }
}

?>