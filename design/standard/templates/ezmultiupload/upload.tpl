{ezscript_require( array( 'ezjsc::yui3', 'ezjsc::yui3io') )}
{ezcss_require( 'ezmultiupload.css' )}
<script type="text/javascript">
(function(config){ldelim}
    config['modules']['ezmultiupload'] = {ldelim}
        type: 'js',
        fullpath: '{"javascript/ezmultiupload.js"|ezdesign( 'no' )}',
        requires: ["uploader", "node", "event-base", "json-parse", "anim"],
        after: ["uploader"],
        skinnable: false
    {rdelim};

    YUI(config).use('ezmultiupload', function (Y) {ldelim}
        Y.ez.MultiUpload.cfg = {ldelim}
            uploadURL: "{concat( 'ezmultiupload/upload/', $parent_node.node_id )|ezurl( 'no' )}",
            uploadVars: {ldelim}
                '{$session_name}': '{$session_id}',
                //'XDEBUG_SESSION_START': 'XDEBUG_ECLIPSE',
                'UploadButton': 'Upload',
                'ezxform_token': '@$ezxFormToken@'
            {rdelim},
            allFilesRecived:  "{'All files received.'|i18n('extension/ezmultiupload')|wash(javascript)}",
            uploadCanceled:   "{'Upload canceled.'|i18n('extension/ezmultiupload')|wash(javascript)}",
            thumbnailCreated: "{'Thumbnail created.'|i18n('extension/ezmultiupload')|wash(javascript)}",
            selectButtonLabel: "{'Select files'|i18n('extension/ezmultiupload')|wash(javascript)}",
            multipleFiles: true
        {rdelim};
        Y.ez.MultiUpload.init();
    {rdelim});
{rdelim})(YUI3_config);
</script>

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-ezmultiupload">
    <div class="class-frontpage">
    
    <div class="attribute-header">
        <h1 class="long">{'Multiupload'|i18n('extension/ezmultiupload')}</h1>
    </div>
        <div class="attribute-description">
            <p>{'The files are uploaded to'|i18n('extension/ezmultiupload')} <a href={$parent_node.url_alias|ezurl}>{$parent_node.name|wash}</a></p>
            <div id="uploadButtonOverlay"></div>
            <button id="cancelUploadButton" type="button">{'Cancel'|i18n('extension/ezmultiupload')}</button>
            <p><noscript><em style="color: red;">{'Javascript has been disabled, this is needed for multiupload!'|i18n('extension/ezmultiupload')}</em></noscript></p>
        </div>
        <div id="multiuploadProgress">
            <p><span id="multiuploadProgressFile">&nbsp;</span>&nbsp;
               <span id="multiuploadProgressFileName">&nbsp;</span></p>
            <p id="multiuploadProgressMessage">&nbsp;</p>
            <div id="multiuploadProgressBarOutline"><div id="multiuploadProgressBar"></div></div>
        </div>
        <div id="thumbnails"></div>
    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

