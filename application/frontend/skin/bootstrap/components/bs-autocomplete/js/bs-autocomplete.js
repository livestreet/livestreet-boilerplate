/**
 * Автозавершение
 *
 * @module ls/crop/modal
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsAutocomplete", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            
            // Селекторы
            selectors: {
                
            },
            
            urls:{
                load: aRouter.ajax + "autocomplete/user"
            },

            cropOptions: {},
            
            data:null,

            submitted: null
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();
            
            if(this.element.data('url')){
                this.option('urls.load', this.element.data('url'));
            }
            
            this.element.typeahead({
                source: this.autocomplete.bind(this)
            });
        },
        
        autocomplete: function(text, call){
            this._load('load', {text:text}, function(response){
                call(response.source)
            }, {showProgress:false})
        }
    });
})(jQuery);