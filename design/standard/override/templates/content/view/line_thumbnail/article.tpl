<div class="content-view-line-thumbnail">
    <div class="class-{$object.class_identifier}">
        {def $href=cond( is_set( $object.main_node ), $object.main_node.url_alias|ezurl, true(), false() )}
        {if $href}
            <h2><a href={$href} title="{$object.name|wash}">{$object.name|shorten(17)|wash}</a></h2>
        {else}
            <h2>{$object.name|shorten(17)|wash}</h2>
        {/if}
        {if $object.data_map.image.has_content}
        <div class="attribute-image">
            {attribute_view_gui image_class=articlethumbnail href=$href attribute=$object.data_map.image}
        </div>
        {/if}
        {if $object.data_map.intro.has_content}
        <div class="attribute-short"> 
            <p>{$object.data_map.intro.content.output.output_text|strip_tags()|shorten(45)|wash}</p>
        </div>
        {/if}
        <div class="thumbnail-class-name"><p>{$object.class_name|wash}</p></div>
    </div>
</div>
