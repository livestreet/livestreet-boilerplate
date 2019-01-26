
(function($) {
    "use strict";

    $.widget( "livestreet.bsFormValidate", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Классы
            selectors: {
                fields: 'input, .form-control, textarea',
                recaptcha: ".g-recaptcha",
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

            this._on(this.element, {submit:"onSubmit"});
        },
        
        onSubmit: function(event){
            
            this.validate(function(result){
                if(!result){
                    event.stopImmediatePropagation();
                    event.preventDefault();
                }
                
            }.bind(this));
                        
        },
        
        validate: function(resultValidate){
            
            this.elements.fields = this.element.find(this.option('selectors.fields'));
            this.elements.fields.bsFieldValidate();
            
            if(!this.isValidFields()){
                resultValidate(false);
                return false;
            }
            
            resultValidate(true);            
        },
                
        isValidFields:function(){
            let valid = true;
            $.each(this.elements.fields, function(i,field){
                $(field).bsFieldValidate('validate');
                if($(field).bsFieldValidate('isValid') === false){
                    valid = false;
                }
            }.bind(this));
            return valid;
        }
    });
})(jQuery);