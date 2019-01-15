/**
 * Media
 *
 * @module ls/uploader
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsUploader", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Ссылки
            urls: {
                // Загрузка файла
                upload: aRouter['ajax'] + 'media/upload/'                
            },

            // Селекторы
            selectors: {
                // Drag & drop зона
                upload_zone:  '[data-type="upload-area"]',
                // Инпут
                upload_input: '[data-type="file-input"]',
                
                file_upl:".file-uploded-tmpl"
            },

            // Классы
            classes: {
                empty: 'is-empty'
            },

            // Настройки загрузчика
            fileupload : {
                url: null,
                sequentialUploads: false,
                singleFileUploads: true,
                limitConcurrentUploads: 3
            },
            
            i18n: {
                errorDublicate:"A file with this name has already been added"
            },

            // Доп-ые параметры передаваемые в аякс запросах
            params: {},
            
            onFileUpload:null,
            onFileError:null

        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();

            this._initFileUploader();

            this._activeFilter = 'uploaded';

        },

        /**
         * Иниц-ия загрузчика
         */
        _initFileUploader: function() {
            // Настройки загрузчика
            $.extend( this.option( 'fileupload' ), {
                url:      this.option( 'urls.upload' ),
                dropZone: this.elements.upload_zone,
                formData:     this.option('params')
            });

            // Иниц-ия плагина
            this.elements.upload_input.fileupload( this.option( 'fileupload' ) );

            // Коллбэки
            this.element.on({
                fileuploadadd: this.onUploadAdd.bind( this ),
                fileuploaddone: function( event, data ) {
                    this[ data.result.bStateError ? 'onUploadError' : 'onUploadDone' ]( data.files[0], data.result );
                }.bind( this ),
                fileuploadprogress: function( event, data ) {
                    this.onUploadProgress( data.files[0], parseInt( data.loaded / data.total * 100, 10 ) );
                }.bind( this ),
                fileuploaddrop:this.onFileAdd.bind( this ),
                fileuploadchange:this.onFileAdd.bind( this )
            });
        },

        

        /**
         * 
         */
        onUploadProgress: function( fileObj, percent ) {
            let file = this.elements.upload_zone.find('#'+fileObj.name.replace(/[^a-zA-Z0-9 ]/g, ""));
            file.find('.progress-bar')
                .html(percent+"%")
                .attr('style', "width: "+percent+"%")
                .attr('aria-valuenow', percent);
        },

        /**
         * 
         */
        onUploadAdd: function( event, data ) {
            let fileObj = data.files[0]; 
            let file = $(this.elements.file_upl.clone());
            file.removeClass('d-none').attr('id', fileObj.name.replace(/[^a-zA-Z0-9 ]/g, ""));
            this.elements.upload_zone.append(file);
            file.find('.name-file').html(fileObj.name);
            file.find('.close').on('click', data.abort);
        },

        /**
         * 
         */
        onUploadDone: function( fileObj, response ) {
            let file = this.elements.upload_zone.find('#'+fileObj.name.replace(/[^a-zA-Z0-9 ]/g, ""));
            setTimeout(function(){file.hide(500);}, 3000);
            file.find('.close').on('click', function(){
                file.hide();
            });
            this._trigger('onFileUpload', null, { file: file, response: response });
        },

        /**
         * 
         */
        onUploadError: function( fileObj, response ) {
            ls.msg.error( response.sMsgTitle, response.sMsg);
            
            let file = this.elements.upload_zone.find('#'+fileObj.name.replace(/[^a-zA-Z0-9 ]/g, ""));
            setTimeout(function(){file.hide(500);}, 3000);
            file.find('.close').on('click', function(){
                file.hide();
            });
            
            this._trigger('onFileError', null, { file: fileObj, response: response });
        },

        onFileAdd: function(event, data){
            let fileObj = data.files[0];
            let file = this.elements.upload_zone.find('#'+fileObj.name.replace(/[^a-zA-Z0-9 ]/g, ""));
            if(file.length){
                ls.msg.error( this._i18n('errorDublicate'));
                return false;
            }
        }
    });
})(jQuery);