  {if and( 
            or( ezini( 'MultiUploadSettings', 'AvailableSubtreeNode', 'ezmultiupload.ini' )|contains( $current_node.node_id ),
                ezini( 'MultiUploadSettings', 'AvailableClasses', 'ezmultiupload.ini' )|contains( $current_node.class_identifier ) ) ,
            and( $content_object.can_create, $is_container) 
         )}
    <a href={concat("/ezmultiupload/upload/",$current_node.node_id)|ezurl} title="{'Multiupload'|i18n('extension/ezmultiupload')}"><img class="ezwt-input-image" src={"ezwt-icon-upload.png"|ezimage} alt="{'Multiupload'|i18n('extension/ezmultiupload')}" /></a>
  {/if}
