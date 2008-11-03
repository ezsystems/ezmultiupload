  {if and( 
            or( ezini( 'MultiUploadSettings', 'AvailableSubtreeNode', 'ezmultiupload.ini' )|contains( $current_node.node_id ),
                ezini( 'MultiUploadSettings', 'AvailableClasses', 'ezmultiupload.ini' )|contains( $current_node.class_identifier ) ) ,
            and( $content_object.can_create, $is_container) 
         )}
    <a href={concat("/ezmultiupload/upload/",$current_node.node_id)|ezurl} title="{'Multiupload'|i18n('extension/ezmultiupload')}"><img src={"ezwt-icon-upload.gif"|ezimage} alt="{'Multiupload'|i18n('extension/ezmultiupload')}" /></a>
  {/if}
