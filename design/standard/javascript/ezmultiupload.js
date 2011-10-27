YAHOO.namespace('ez');

YAHOO.ez.MultiUpload = (function()
{
    // Private

    var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event,
        Connect = YAHOO.util.Connect,
        JSON = YAHOO.lang.JSON;

    var onContentReady = function(o)
    {
        this.setAllowMultipleFiles(true);
        if ( YAHOO.ez.MultiUpload.cfg.fileType[0].extensions )
            this.setFileFilters(YAHOO.ez.MultiUpload.cfg.fileType);

        Event.removeListener( Dom.get('uploadButtonOverlay'), 'click', missingFlashClick );
    };

    var missingFlashClick = function(o)
    {
        if ( YAHOO.ez.MultiUpload.cfg.flashError )
            alert( YAHOO.ez.MultiUpload.cfg.flashError );
        else
            alert( "Could not load flash(or not yet loaded), this is needed for multiupload!" );
    };

    var onFileSelect = function(e)
    {
        Dom.setStyle('multiuploadProgress' , 'display', 'block');
        if ( !Dom.getStyle('multiuploadProgress', 'opacity') )
        {
           fadeAnimate('multiuploadProgress' , 0, 1);
        }
        Dom.setStyle('multiuploadProgressBar' , 'width', 0);
        Dom.get('multiuploadProgressMessage').innerHTML = "";

        for(var i in e.fileList)
        {
            this.queue.push(e.fileList[i]);
        }

        var fileID = this.queue[this.uploadCounter]['id'];
        this.upload(fileID, YAHOO.ez.MultiUpload.cfg.uploadURL, 'POST', YAHOO.ez.MultiUpload.cfg.uploadVars);

        Dom.get('uploadButton').disabled = true;

        var cancelUploadButton = Dom.get('cancelUploadButton');
        Dom.setStyle(cancelUploadButton, 'visibility', 'visible');

        Event.on(cancelUploadButton, 'click', cancelUpload, this, true);

        this.disable();
    };

    var onUploadStart = function(e)
    {
        Dom.setStyle('multiuploadProgressBar' , 'width', 0);
        Dom.get('multiuploadProgressMessage').innerHTML = '';
        Dom.get('multiuploadProgressFile').innerHTML = (this.uploadCounter + 1) + '/' + this.queue.length;
        Dom.get('multiuploadProgressFileName').innerHTML = this.queue[this.uploadCounter]['name'];
    };

    var onUploadProgress = function(e)
    {
        var width = Math.floor((YAHOO.ez.MultiUpload.cfg.progressBarWidth * e['bytesLoaded']) / e['bytesTotal']);

        widthAnimate('multiuploadProgressBar', width);
    };

    var onUploadComplete = function(e)
    {
        Dom.get('multiuploadProgressMessage').innerHTML = YAHOO.ez.MultiUpload.cfg.thumbnailCreated;
        Dom.setStyle('multiuploadProgressBar' , 'width', '100%');

        if (this.uploadCounter < this.queue.length - 1) {
            this.uploadCounter++;

            var fileID = this.queue[this.uploadCounter]['id'];
            this.upload(fileID, YAHOO.ez.MultiUpload.cfg.uploadURL, 'POST', YAHOO.ez.MultiUpload.cfg.uploadVars);
        } else {
            this.uploadCounter = 0;
            this.queue = [];

            Dom.get('uploadButton').disabled = false;
            Dom.get('multiuploadProgressMessage').innerHTML = YAHOO.ez.MultiUpload.cfg.allFilesRecived;

            Dom.setStyle('cancelUploadButton', 'visibility', 'hidden');

            this.enable();
            this.clearFileList();
        }
    };

    var onUploadCompleteData = function(e)
    {
        var response = JSON.parse(e.data);
        var id = response.id;
        var data = unescapeHTML(response.data);

        var thumbnail = document.createElement('div');
        thumbnail.innerHTML = data;
        Dom.addClass(thumbnail, "thumbnail-block");
        Dom.setAttribute(thumbnail, "id", "thumbnail_" + id);
        Dom.setStyle(thumbnail, "opacity", 0);
        var thumbnails = Dom.get('thumbnails');
        thumbnails.appendChild(thumbnail);

        fadeAnimate('thumbnail_'+ id, 0, 1);
    };

    var onUploadError = function(e)
    {
        alert(event.status);
    };

    var cancelUpload = function()
    {
        this.cancel();
        this.enable();
        this.clearFileList();

        this.uploadCounter = 0;
        this.queue = [];

        Dom.get('multiuploadProgressMessage').innerHTML = YAHOO.ez.MultiUpload.cfg.uploadCanceled;
        Dom.get('uploadButton').disabled = false;
    };

    var fadeAnimate = function(elementID, fromValue, toValue)
    {
        var anim = new YAHOO.util.Anim(elementID , { opacity: { from: fromValue, to: toValue } }, 0.2);
        anim.animate();
    };

    var widthAnimate = function(elementID, toValue)
    {
        var anim = new YAHOO.util.Anim(elementID , { width: { to: toValue } } , 0.5);
        anim.animate();
    };

    var stripTags = function(s)
    {
        return s.replace(/<\/?[^>]+>/gi, '');
    };

    var unescapeHTML = function(s)
    {
        var div = document.createElement('div');
        div.innerHTML = stripTags(s);
        return div.childNodes[0] ? div.childNodes[0].nodeValue : s;
    };

    // Public

    return {

        init: function() {
            Event.onDOMReady(function()
            {
                var uploadButton = Dom.getRegion('uploadButton');
                var overlay = Dom.get('uploadButtonOverlay');

                Event.addListener( overlay, 'click', missingFlashClick );

                Dom.setStyle(overlay, 'width', uploadButton.right - uploadButton.left + "px");
                Dom.setStyle(overlay, 'height', uploadButton.bottom - uploadButton.top + "px");

                YAHOO.widget.Uploader.SWFURL = YAHOO.ez.MultiUpload.cfg.swfURL;
                var uploader = new YAHOO.widget.Uploader('uploadButtonOverlay');

                uploader.on('contentReady', onContentReady);
                uploader.on('fileSelect', onFileSelect);
                uploader.on('uploadStart', onUploadStart);
                uploader.on('uploadProgress', onUploadProgress);
                uploader.on('uploadComplete', onUploadComplete);
                uploader.on('uploadCompleteData', onUploadCompleteData);
                uploader.on('uploadError', onUploadError);

                uploader.uploadCounter = 0;
                uploader.queue = [];
            }, this, true );
        },

        cfg: { swfURL: false,
               uploadURL: false,
               uploadVars: false,
               fileType: false,
               progressBarWidth: 300,
               allFilesRecived: '',
               uploadCanceled: '',
               thumbnailCreated: '' }
    }
})();
