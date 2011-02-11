{ezscript_require( 'ezjsc::yui2' )}
{ezcss_require( 'ezmultiupload.css' )}
<script type="text/javascript">
(function(){ldelim}
    YUILoader.addModule({ldelim}
        name: 'ezmultiupload',
        type: 'js',
        fullpath: '{"javascript/ezmultiupload.js"|ezdesign( 'no' )}',
        requires: ["utilities", "json", "uploader"],
        after: ["uploader"],
        skinnable: false
    {rdelim});

    // Load the files using the insert() method and set it up and init it on success.
    YUILoader.insert({ldelim}
        require: ["ezmultiupload"],
        onSuccess: function()
        {ldelim}
            YAHOO.ez.MultiUpload.cfg = {ldelim}
                swfURL:"{concat( ezini('eZJSCore', 'LocalScriptBasePath', 'ezjscore.ini').yui2, 'uploader/assets/uploader.swf' )|ezdesign( 'no' )}",
                uploadURL: "{concat( 'ezmultiupload/upload/', $parent_node.node_id )|ezurl( 'no' )}",
                uploadVars: {ldelim}
                                '{$session_name}': '{$session_id}',
                                'UserSessionHash': '{$user_session_hash}',
                                //'XDEBUG_SESSION_START': 'XDEBUG_ECLIPSE',
                                'UploadButton': 'Upload'
                            {rdelim},
                // Filter is passed on to uploader.setFileFilter() in ez.MultiUpload
                fileType: [{ldelim} description:"{'Allowed Files'|i18n('extension/ezmultiupload')|wash('javascript')}", extensions:'{$file_types}' {rdelim}],
                progressBarWidth: "300",
                allFilesRecived:  "{'All files received.'|i18n('extension/ezmultiupload')|wash(javascript)}",
                uploadCanceled:   "{'Upload canceled.'|i18n('extension/ezmultiupload')|wash(javascript)}",
                thumbnailCreated: "{'Thumbnail created.'|i18n('extension/ezmultiupload')|wash(javascript)}",
                flashError: "{'Could not load flash(or not loaded yet), this is needed for multiupload!'|i18n('extension/ezmultiupload')}"
            {rdelim};
            YAHOO.ez.MultiUpload.init();
        {rdelim},
        timeout: 10000,
        combine: true
    {rdelim}, "js");
{rdelim})();
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
            <div id="uploadButtonOverlay" style="position: absolute; z-index: 2"></div>
            <button id="uploadButton" type="button" style="z-index: 1">{'Select files'|i18n('extension/ezmultiupload')}</button>
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

