<div class="content-view-line-thumbnail">
    <div class="class-{$node.object.class_identifier}">
        {if is_set( $node.url_alias )}
        <h2><a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash}">{$node.name|wash|shorten(17)}</a></h2>
        {else}
        <h2>{$node.name|wash|shorten(17)}</h2>
        {/if}
        {if $node.data_map.image.has_content}
        <div class="attribute-image">
            {attribute_view_gui image_class=articlethumbnail href=$node.url_alias|ezurl attribute=$node.data_map.image}
        </div>
        {/if}
        {if $node.data_map.intro.has_content}
        <div class="attribute-short"> 
            <p>{$node.data_map.intro.content.output.output_text|strip_tags()|wash|shorten(45)}</p>
        </div>
        {/if}
        <div class="thumbnail-class-name"><p>{$node.class_name|wash}</p></div>
    </div>
</div>