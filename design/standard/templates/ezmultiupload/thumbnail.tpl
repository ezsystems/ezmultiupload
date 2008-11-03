{if $result.errors|count()|gt(0)}
    <div class="error-block">
    <img src={"ezmultiupload-error.gif"|ezimage} alt="{'Error'|i18n('extension/ezmultiupload')}" />
    <p>
        <ul>
        {foreach $result.errors as $error}
            <li>{$error.description}</li>
        {/foreach}
        </ul>
    </p>
    </div>
{elseif is_set( $result.contentobject )}
    {node_view_gui view='line_thumbnail' content_node=$result.contentobject.main_node}
{/if}