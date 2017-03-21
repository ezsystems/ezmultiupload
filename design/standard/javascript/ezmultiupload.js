YUI.add('ezmultiupload', function (Y) {
    Y.namespace('ez');

    Y.ez.MultiUpload = (function () {
        // Private

        var onFileSelect = function (e) {
            Y.ez.MultiUpload.originalFileList = e.fileList;

            Y.one('#multiuploadProgress').setStyle('display', 'block');

            if (!Y.one('#multiuploadProgress').getStyle('opacity')) {
                fadeAnimate('#multiuploadProgress', 0, 1);
            }
            Y.one('#multiuploadProgressBar').setStyle('width', 0);
            Y.one('#multiuploadProgressMessage').setHTML('');

            Y.ez.MultiUpload.uploader.uploadAll(Y.ez.MultiUpload.cfg.uploadURL, Y.ez.MultiUpload.cfg.uploadVars);

            var cancelUploadButton = Y.one('#cancelUploadButton');
            cancelUploadButton.setStyle('visibility', 'visible');
            cancelUploadButton.on('click', cancelUpload, this, true);

            Y.ez.MultiUpload.uploader.disable();
        };

        var onUploadStart = function (e) {
            Y.one('#multiuploadProgressBar').setStyle('width', 0);
            Y.one('#multiuploadProgressMessage').setHTML('');
            Y.one('#multiuploadProgressFile').setHTML('0/' + Y.ez.MultiUpload.originalFileList.length);
        };

        var onUploadProgress = function (e) {
            var i;
            for (i = 0; i < Y.ez.MultiUpload.originalFileList.length; i++) {
                if (Y.ez.MultiUpload.originalFileList[i].get('name') == e.file.get('name')) {
                    break;
                }
            }

            Y.one('#multiuploadProgressFile').setHTML((i + 1) + '/' + Y.ez.MultiUpload.originalFileList.length);
            Y.one('#multiuploadProgressFileName').setHTML(e.file.get('name'));
        };

        var onTotalUploadProgress = function (e) {
            widthAnimate('#multiuploadProgressBar', e.percentLoaded + '%');
        };

        var onUploadComplete = function (e) {
            Y.one('#multiuploadProgressMessage').setHTML(Y.ez.MultiUpload.cfg.thumbnailCreated);
            Y.one('#multiuploadProgressBar').setStyle('width', '100%');

            Y.one('#multiuploadProgressMessage').setHTML(Y.ez.MultiUpload.cfg.allFilesRecived);

            var fileCount = Y.ez.MultiUpload.originalFileList.length;
            Y.one('#multiuploadProgressFile').setHTML(fileCount + '/' + fileCount);
            Y.one('#multiuploadProgressFileName').setHTML('');

            Y.one('#cancelUploadButton').setStyle('visibility', 'hidden');

            Y.ez.MultiUpload.uploader.enable();
            Y.ez.MultiUpload.uploader.set('fileList', []);

            try {
                var response = Y.JSON.parse(e.data);
            }
            catch (e) {
                alert("Invalid JSON data");
            }
            var id = response.id;
            var data = unescapeHTML(response.data);

            var thumbnail = Y.Node.create('<div>' + data + '</div>');
            thumbnail.addClass("thumbnail-block");
            thumbnail.setAttribute("id", "thumbnail_" + id);
            thumbnail.setStyle("opacity", 0);

            Y.one('#thumbnails').appendChild(thumbnail);

            fadeAnimate('#thumbnail_' + id, 0, 1);
        };

        var onUploadError = function (e) {
            alert(e.status + ': ' + e.statusText);
            console.log(e.status + ': ' + e.statusText);
        };

        var cancelUpload = function () {
            Y.ez.MultiUpload.uploader.queue.cancelUpload();
            Y.ez.MultiUpload.uploader.enable();
            Y.ez.MultiUpload.uploader.set('fileList', []);

            Y.one('#multiuploadProgressMessage').setHTML(Y.ez.MultiUpload.cfg.uploadCanceled);
        };

        var fadeAnimate = function (elementID, fromValue, toValue) {
            var anim = new Y.Anim({
                node: elementID,
                from: {
                    opacity: fromValue
                },
                to: {
                    opacity: toValue
                },
                duration: 0.2
            });
            anim.run();
        };

        var widthAnimate = function (elementID, toValue) {
            var anim = new Y.Anim({
                node: elementID,
                to: {
                    width: toValue
                },
                duration: 0.5
            });
            anim.run();
        };

        var stripTags = function (s) {
            return s.replace(/<\/?[^>]+>/gi, '');
        };

        var unescapeHTML = function (s) {
            var div = document.createElement('div');
            div.innerHTML = stripTags(s);
            return div.childNodes[0] ? div.childNodes[0].nodeValue : s;
        };

        // Public

        return {

            uploader: null,

            originalFileList: null,

            init: function () {
                Y.on('domready', function () {
                    Y.Uploader = Y.UploaderHTML5;
                    Y.ez.MultiUpload.uploader = new Y.Uploader({selectButtonLabel: Y.ez.MultiUpload.cfg.selectButtonLabel});

                    if (Y.Uploader.TYPE == "html5") {
                        Y.ez.MultiUpload.uploader.set("uploadURL", Y.ez.MultiUpload.cfg.uploadURL);
                        Y.ez.MultiUpload.uploader.set("multipleFiles", Y.ez.MultiUpload.cfg.multipleFiles);
                        Y.ez.MultiUpload.uploader.set("dragAndDropArea", "#divContainer");
                        Y.ez.MultiUpload.uploader.render("#uploadButtonOverlay");

                        Y.ez.MultiUpload.uploader.on('fileselect', onFileSelect);
                        Y.ez.MultiUpload.uploader.on('uploadstart', onUploadStart);
                        Y.ez.MultiUpload.uploader.on('uploadprogress', onUploadProgress);
                        Y.ez.MultiUpload.uploader.on('totaluploadprogress', onTotalUploadProgress);
                        Y.ez.MultiUpload.uploader.on('uploadcomplete', onUploadComplete);
                        Y.ez.MultiUpload.uploader.on('uploaderror', onUploadError);
                    }
                    else {
                        Y.log("No HTML5 capabilities detected.");
                    }
                });
            },

            cfg: {
                uploadURL: false,
                uploadVars: false,
                allFilesRecived: '',
                uploadCanceled: '',
                thumbnailCreated: '',
                multipleFiles: true
            }
        }
    })();
});
