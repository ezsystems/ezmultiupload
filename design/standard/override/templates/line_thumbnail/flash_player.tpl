<div class="content-view-line-thumbnail">
    <div class="class-{$node.object.class_identifier}">
        {if is_set( $node.url_alias )}
        <h2><a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash}">{$node.name|wash|shorten(17)}</a></h2>
        {else}
        <h2>{$node.name|wash|shorten(17)}</h2>
        {/if}
        <div class="thumbnail-movie-icon">
            <img src={"ezmultiupload-movie.png"|ezimage} />
        <div>
        <div class="thumbnail-class-name"><p>{$node.class_name|wash}</p></div>
    </div>
</div>