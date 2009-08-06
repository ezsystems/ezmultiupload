<script type="text/javascript" src={"javascript/yui/2.7.0/build/utilities/utilities.js"|ezdesign}></script>
<script type="text/javascript" src={"javascript/yui/2.7.0/build/json/json-min.js"|ezdesign}></script>
<script type="text/javascript" src={"javascript/yui/2.7.0/build/uploader/uploader-min.js"|ezdesign}></script>
<script type="text/javascript" src={"javascript/ezmultiupload.js"|ezdesign}></script>

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

<script type="text/javascript">
    YAHOO.ez.MultiUpload.cfg = {ldelim}
                                   swfURL:'{'javascript/yui/2.7.0/build/uploader/assets/uploader.swf'|ezdesign( 'no' )}',
                                   uploadURL: '{concat( 'ezmultiupload/upload/', $parent_node. node_id )|ezurl( 'no' )}',
                                   uploadVars: {ldelim}
                                                   '{$session_name}': '{$session_id}',
                                                   'UserSessionHash': '{$user_session_hash}',
                                                   'UploadButton': 'Upload'
                                               {rdelim},
                                   fileType: '{$file_types}',
                                   progressBarWidth: '300',
                                   allFilesRecived: '{'All files received.'|i18n('extension/ezmultiupload')}',
                                   uploadCanceled: '{'Upload canceled.'|i18n('extension/ezmultiupload')}',
                                   thumbnailCreated: '{'Thumbnail created.'|i18n('extension/ezmultiupload')}'
                                {rdelim};

    YAHOO.ez.MultiUpload.init();
</script>

        <div class="break"></div>

    </div></div></div></div>

    <div class="controlbar">

        <div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
        <div class="break"></div>


        </div></div></div></div></div></div>

    </div>


</div>
</div>
