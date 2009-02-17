<?php
/**
 * File containing the ezmultiuploadInfo class.
 *
 * @copyright Copyright (C) 2005-2008 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU GPL v2
 * @version //autogentag//
 * @package ezmultiupload
 */

class ezmultiuploadInfo
{
    static function info()
    {
        return array( 'Name' => 'eZ Multiupload',
                      'Version' => '1.0.0alpha3',
                      'Copyright' => 'Copyright (C) 1999-' . date( 'Y' ) . ' eZ Systems AS',
                      'License' => 'GNU General Public License v2.0',
                      'Includes the following third-party software' => array( 'Name' => 'YUI',
                                                                              'Version' => '2.6.0',
                                                                              'Copyright' => 'Copyright (c) ' . date( 'Y' ) . ', Yahoo! Inc. All rights reserved.',
                                                                              'License' => 'BSD license' ) );
    }
}
?>