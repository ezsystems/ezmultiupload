<?php
/**
 * File containing the eZMultiuploadHandlerInterface interface.
 *
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 * @version 1.0.0
 * @package ezmultiupload
 */

interface eZMultiuploadHandlerInterface
{
    static public function preUpload( &$result );
    static public function postUpload( &$result );
}

?>