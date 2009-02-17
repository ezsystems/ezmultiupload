YAHOO.namespace('ez');

YAHOO.ez.MultiUpload = (function() {
    
    // Private
    
    var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event,
        Connect = YAHOO.util.Connect,
        JSON = YAHOO.lang.JSON

    var onContentReady = function(o, cfg) {
        this.setAllowMultipleFiles(true);
        this.setFileFilters(cfg.fileType);
    };

    var onFileSelect = function(e, cfg) {
        Dom.setStyle('multiuploadProgress' , 'display', 'block');
        if( Dom.getStyle('multiuploadProgress' , 'opacity' ) == 0) {
           fadeAnimate('multiuploadProgress' , 0, 1);
        }
        Dom.setStyle('multiuploadProgressBar' , 'width', 0);
        Dom.get('multiuploadProgressMessage').innerHTML = "";
        
        for(var i in e.fileList) {
            this.queue.push(e.fileList[i]);
        }

        var fileID = this.queue[this.uploadCounter]['id'];
        this.upload(fileID, cfg.uploadURL, 'POST', cfg.uploadVars);
        
        Dom.get('uploadButton').disabled = true;
        
        var cancelUploadButton = Dom.get('cancelUploadButton');
        Dom.setStyle(cancelUploadButton, 'visibility', 'visible');
        
        Event.on(cancelUploadButton, 'click', cancelUpload, {
            uploader: this,
            cfg: cfg
        }, true );
        
        this.disable();
    };

    var onUploadStart = function(e) {
        Dom.setStyle('multiuploadProgressBar' , 'width', 0);
        Dom.get('multiuploadProgressMessage').innerHTML = '';
        Dom.get('multiuploadProgressFile').innerHTML = (this.uploadCounter + 1) + '/' + this.queue.length;
        Dom.get('multiuploadProgressFileName').innerHTML = this.queue[this.uploadCounter]['name'];
    };

    var onUploadProgress = function(e, cfg) {
        var width = Math.floor((cfg.progressBarWidth * e['bytesLoaded']) / e['bytesTotal']);

        widthAnimate('multiuploadProgressBar', width);
    };

    var onUploadComplete = function(e, cfg) {
        Dom.get('multiuploadProgressMessage').innerHTML = cfg.thumbnailCreated;
        Dom.setStyle('multiuploadProgressBar' , 'width', '100%');
        
        if (this.uploadCounter < this.queue.length - 1) {
            this.uploadCounter++;

            var fileID = this.queue[this.uploadCounter]['id'];
            this.upload(fileID, cfg.uploadURL, 'POST', cfg.uploadVars);
        } else {
            this.uploadCounter = 0;
            this.queue = [];

            Dom.get('uploadButton').disabled = false;
            Dom.get('multiuploadProgressMessage').innerHTML = cfg.allFilesRecived;

            Dom.setStyle('cancelUploadButton', 'visibility', 'hidden');
            
            this.enable();
            this.clearFileList();
        }
    };

    var onUploadCompleteData = function(e, cfg) {
        var response = JSON.parse(e.data);
        var id = response.id;
        var data = unescapeHTML(response.data);

        var thumbnail = '<div id="thumbnail_' + id + '" class="thumbnail-block" style="opacity:0;" >' + data + '</div>';
        var thumbnails = Dom.get('thumbnails');
        thumbnails.innerHTML = thumbnails.innerHTML + thumbnail;
        
        fadeAnimate('thumbnail_'+ id, 0, 1);
    };

    var onUploadError = function(e) {
        alert(event.status);
    };

    var cancelUpload = function(){
        this.uploader.cancel();
        this.uploader.enable();
        this.uploader.clearFileList();
        
        this.uploader.uploadCounter = 0;
        this.uploader.queue = [];
        
        Dom.get('multiuploadProgressMessage').innerHTML = this.cfg.uploadCanceled;
        Dom.get('uploadButton').disabled = false;
    };

    var fadeAnimate = function(elementID, fromValue, toValue) {
        var anim = new YAHOO.util.Anim(elementID , { opacity: { from: fromValue, to: toValue } }, 0.2);
        anim.animate();
    };

    var widthAnimate = function(elementID, toValue) {
        var anim = new YAHOO.util.Anim(elementID , { width: { to: toValue } } , 0.5);
        anim.animate();
    };

    var stripTags = function(s) {
        return s.replace(/<\/?[^>]+>/gi, '');
    };
    
    var unescapeHTML = function(s) {
        var div = document.createElement('div');
        div.innerHTML = stripTags(s);
        return div.childNodes[0] ? div.childNodes[0].nodeValue : '';
    };

    // Public
    
    return {
        
        init: function() {
            Event.onDOMReady(function() {
                var uploadButton = Dom.getRegion('uploadButton');
                var overlay = Dom.get('uploadButtonOverlay');
                
                Dom.setStyle(overlay, 'width', uploadButton.right - uploadButton.left + "px");
                Dom.setStyle(overlay, 'height', uploadButton.bottom - uploadButton.top + "px");
                
                YAHOO.widget.Uploader.SWFURL = this.cfg.swfURL;
                var uploader = new YAHOO.widget.Uploader('uploadButtonOverlay');
            
                uploader.on('contentReady', onContentReady, this.cfg, false);
                uploader.on('fileSelect', onFileSelect, this.cfg, false);
                uploader.on('uploadStart', onUploadStart);
                uploader.on('uploadProgress', onUploadProgress, this.cfg, false);
                uploader.on('uploadComplete', onUploadComplete, this.cfg, false);
                uploader.on('uploadCompleteData', onUploadCompleteData, this.cfg, false);
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
               allFilesRecived: false,
               uploadCanceled: false,
               thumbnailCreated: false }
    }
})();
