/**
 * Модерация
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsModeration", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Ссылки
            urls: {
                publish: aRouter.moderation + 'ajax-publish',
                remove: aRouter.moderation + 'ajax-delete',
            },

            // Селекторы
            selectors: {
                btn_publish:"[data-btn-publish]",
                btn_remove:"[data-btn-remove]"
            },
            


            i18n: {
            },

            // Доп-ые параметры передаваемые в аякс запросах
            params: {},
            
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            
           this._super();
           
           this.elements.btn_publish.on('click', function(){
               this._load('publish', {}, 'afterPublish');
               return false;
           }.bind(this));
           
           this.elements.btn_remove.on('click', function(){
               this._load('remove', {}, 'afterRemove');
               return false;
           }.bind(this));
        },
        
        afterPublish: function(response){
            if(response.publish){
                this.element.remove();
            }
            
            if(this.element.data('counterSelector')){
                $(this.element.data('counterSelector')).text(response.countAll)
            }
        },
        
        afterRemove: function(response){
            if(response.remove){
                this.element.remove();
            }
            
            if(this.element.data('counterSelector')){
                $(this.element.data('counterSelector')).text(response.countAll)
            }
        },
        
    });
})(jQuery);