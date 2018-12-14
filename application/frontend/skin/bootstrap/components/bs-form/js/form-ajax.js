
(function($) {
    "use strict";

    $.widget( "livestreet.bsFormAjax", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Классы
            selectors: {
                submit: '[type="submit"]'
            },
            needValidate:false,
            // Ссылка
            urls: {
                submit: null
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
            
            this.element.submit(function(e){
                this.loading();
                if(this.element.bsFormValidate !== "undefined" ){
                    this.element.bsFormValidate('validate', this.afterValidate.bind(this));
                    return false;
                }
                this._submit('submit', this.element, 'afterSubmit', {showProgress:false});
                return false;
            }.bind(this));
            
        },
        
        afterValidate:function(response){
            if(response.success){
                this._submit('submit', this.element, 'afterSubmit', {showProgress:false});
                return;
            }
            this.loaded();
        },
        
        afterSubmit:function(response){
            this.loaded();
            
            if(response.bStateError){
                if(this.option('needValidate') ){
                    this.element.bsFormValidate('showErrors', response.errors)
                }
                return;
            }
        },
        
        loading:function(){
            this.elements.submit.addClass('ls-loading text-hide px-5 py-3');
        },
        loaded:function(){
            this.elements.submit.removeClass('ls-loading text-hide px-5 py-3');
        }
    });
})(jQuery);