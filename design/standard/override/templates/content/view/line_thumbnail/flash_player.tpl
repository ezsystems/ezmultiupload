<div class="content-view-line-thumbnail">
    <div class="class-{$object.class_identifier}">
        {def $href=cond( is_set( $object.main_node ), $object.main_node.url_alias|ezurl, true(), false() )}
        {if $href}
            <h2><a href={$href} title="{$object.name|wash}">{$object.name|shorten(17)|wash}</a></h2>
        {else}
            <h2>{$object.name|wash|shorten(17)}</h2>
        {/if}
        <div class="thumbnail-movie-icon">
            <img src={"ezmultiupload-movie.png"|ezimage} />
        <div>
        <div class="thumbnail-class-name"><p>{$object.class_name|wash}</p></div>
    </div>
</div>
