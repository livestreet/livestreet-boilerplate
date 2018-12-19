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
                modal:'@#mediaModal'
            },

            uploader_options: {},

            params: {}
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();

            this.elements.library.bsLibrary();
            
            this.elements.modal.on('show.bs.modal', function(){
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

            
            
        }
    });
})(jQuery);