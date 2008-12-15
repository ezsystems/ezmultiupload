<?php

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
            if ( !call_user_func( array( $hanlder, $method ), &$result ) )
                eZDebug::writeWarning( 'Multiupload handler implementation not found' );
        }

        return true;
    }
}

?>