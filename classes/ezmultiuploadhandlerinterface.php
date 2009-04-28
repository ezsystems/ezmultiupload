<?php
/**
 * File containing the eZMultiuploadHandlerInterface interface.
 *
 * @copyright Copyright (C) 2005-2009 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU GPL v2
 * @version 1.0.1
 * @package ezmultiupload
 */

interface eZMultiuploadHandlerInterface
{
    static public function preUpload( &$result );
    static public function postUpload( &$result );
}

?>