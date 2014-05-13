<?php
/**
 * File containing the eZMultiuploadHandler class.
 *
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 * @version 1.0.0
 * @package ezmultiupload
 */

/**
 * eZMultiuploadHandler class
 *
 */
class eZMultiuploadHandler
{
    /**
     * Call preUpload or postUpload user definied functions.
     *
     * @static
     * @param string $method
     * @param array $result
     * @return bool
     */
    static function exec( $method, &$result )
    {
        $ini = eZINI::instance( 'ezmultiupload.ini' );
        $handlers = $ini->variable( 'MultiUploadSettings', 'MultiuploadHandlers' );

        if ( !$handlers )
            return false;

        foreach ( $handlers as $hanlder )
        {
            if ( !call_user_func( array( $hanlder, $method ), $result ) )
                eZDebug::writeWarning( 'Multiupload handler implementation not found' );
        }

        return true;
    }
}

?>