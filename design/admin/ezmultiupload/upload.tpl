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
                                'UploadButton': 'Upload'
                            {rdelim},
                // Filter is passed on to uploader.setFileFilter() in ez.MultiUpload
                fileType: [{ldelim} description:"{'Allowed Files'|i18n('extension/ezmultiupload')|wash('javascript')}", extensions:'{$file_types}' {rdelim}],
                progressBarWidth: "300",
                allFilesRecived:  "{'All files received.'|i18n('extension/ezmultiupload')|wash(javascript)}",
                uploadCanceled:   "{'Upload canceled.'|i18n('extension/ezmultiupload')|wash(javascript)}",
                thumbnailCreated: "{'Thumbnail created.'|i18n('extension/ezmultiupload')|wash(javascript)}"
            {rdelim};
            YAHOO.ez.MultiUpload.init();
        {rdelim},
        timeout: 10000,
        combine: true
    {rdelim}, "js");
{rdelim})();
</script>

<div class="content-navigation">
<div class="context-block">
<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h2 class="context-title">{'Multiupload'|i18n('extension/ezmultiupload')}</h2>

<div class="header-subline"></div>

</div></div></div></div></div></div>
    <div class="box-ml"><div class="box-mr"><div class="box-content"><div class="context-attributes">


<div class="content-view-ezmultiupload">
    <div class="class-frontpage">

        <div class="attribute-description">
            <p>{'The files are uploaded to'|i18n('extension/ezmultiupload')} <a href={$parent_node.url_alias|ezurl}>{$parent_node.name|wash}</a></p>
            <div id="uploadButtonOverlay" style="position: absolute; z-index: 2"></div>
            <button id="uploadButton" type="button" style="z-index: 1">{'Select files'|i18n('extension/ezmultiupload')}</button>
            <button id="cancelUploadButton" type="button">{'Cancel'|i18n('extension/ezmultiupload')}</button>
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

     <div class="break"></div>

    </div></div></div></div>
    <div class="controlbar">
        <div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
        <div class="break"></div>
        </div></div></div></div></div></div>
    </div>

</div>
</div>
