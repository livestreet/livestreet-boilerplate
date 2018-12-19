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

    $.widget( "livestreet.bsMediaField", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Ссылки
            urls: {
                         
            },

            // Селекторы
            selectors: {
                body:  '[data-type="field-body"]',
                field: '[data-type="media-field"]'

            },
            

            // Классы
            classes: {
            },

            i18n: {
            },

            // Доп-ые параметры передаваемые в аякс запросах
            params: {},
            
            onAdd:null

        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();            
           
        },
        
        add: function(file){
            this.elements.body.prepend(file);
            
            this.elements.body.append('<input type="hidden" name="files[]" value="'+file.data('id')+'">')
            
            this._trigger('onAdd', file);
        },
        
        remove:function(id){
            this.elements.body.find('[data-id="'+id+'"]').remove();
            this.elements.body.find('[value="'+id+'"]').remove();
        }
    });
})(jQuery);