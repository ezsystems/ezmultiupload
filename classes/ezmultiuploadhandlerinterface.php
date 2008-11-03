<?php

interface eZMultiuploadHandlerInterface
{
    static public function preUpload( &$result );
    static public function postUpload( &$result );
}

?>