
(function($) {
    "use strict";

    $.widget( "livestreet.bsFormValidate", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Классы
            selectors: {
                fields: 'input',
                submit: '[type="submit"]'
            },

            // Ссылка
            urls: {
                load: null
            },
            
            // Параметры запроса
            params: {},

            
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function() {
            this._super();
            
            this.elements.fields.bsFieldValidate();
            
        }
    });
})(jQuery);