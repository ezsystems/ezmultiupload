<?php

class eZMultiuploadHandler
{
    static function exec( $method, &$result )
    {
        $ini = eZINI::instance( 'ezmultiupload.ini' );

        $handlers = $ini->variable( 'MultiUploadSettings', 'MultiuploadHandlers' );

        foreach ( $handlers as $hanlder )
        {
            $obj = new $hanlder();
            if ( $obj )
                $obj->$method( $result );
            else
                eZDebug::writeWarning( 'Multiupload handler implementation not found' );
        }
    }
}

?>