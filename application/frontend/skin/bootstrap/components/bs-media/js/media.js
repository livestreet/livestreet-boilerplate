/**
 * Media
 *
 * @module ls/media
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 *
 * TODO: Фильтрация файлов по типу при переключении табов
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsMedia", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            
            // Ссылки
            urls: {
                
            },

            // Селекторы
            selectors: {
                uploader: '[data-type="uploader"]',
                library: '[data-type="library"]',
                fields: '@[data-type="media-field"]',
                btn: '[data-type="btn-modal"]',
                modal:'@#mediaModal'
            },

            uploader_options: {},

            params: {},
            
            onSelectFile:null,
            
            field:null
        },
        
        

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();
            
            this.elements.fields.bsMediaField();
            
            this.elements.fields.mousedown( function(e){
                this.option('field', e.currentTarget);
            }.bind(this));

            this.elements.library.bsLibrary();
            
            this.elements.modal.on('show.bs.modal', function(e){
                this.elements.library.bsLibrary('loadFiles');
            }.bind(this));
            
            // Иниц-ия загрузчика 
            this.elements.uploader.bsUploader({
                i18n:{
                    errorDublicate:ls.lang.get('media.uploader.notices.errorDublicate')
                },
                onFileUpload:function(){
                    this.elements.library.bsLibrary('loadFiles')
                }.bind(this)
            });   
            
            this.elements.btn.attr('disable',true);
            this._on(this.elements.btn, {click: "select"});
            
        },
        
        attachFields: function(fields){
            fields.mousedown( function(e){
                this.option('field', e.currentTarget);
            }.bind(this));
        },
        
        select: function(e){
            this.elements.modal.modal('hide')
            let file = this.elements.library.bsLibrary('getSelectItem');
            let size = this.elements.library.bsLibrary('getSelectSize');
            if(file === null){
                return;
            }
            this._trigger('onSelectFile', file);
            $(this.option('field')).bsMediaField('add', file, size);
        }
    });
})(jQuery);