
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
            onAfterSubmit:null
            
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function() {
            this._super();

            if(this.element.data('url')){
                this.option('urls.submit', this.element.data('url'));
            }
            
            this.element.submit(function(e){
                
                if(this.element.bsFormValidate( "instance" ) !== undefined ){
                    this.element.bsFormValidate('validate', this.afterValidate.bind(this));
                    return false;
                }
                if(this.option('urls.submit') === null){
                    return false;
                }
                
                this.loading();
                
                this._submit('submit', this.element, 'afterSubmit', 
                    {showProgress:false, onError:this.afterError.bind(this)});
                return false;
            }.bind(this));
            
        },
        
        afterValidate:function(response){
            if(response.success){
                this._submit('submit', this.element, 'afterSubmit', 
                    {showProgress:false, onError:this.afterError.bind(this)});
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
            
            this.element.closest('.modal').modal('hide');
            
            this._trigger('onAfterSubmit', null, {context:this, response:response});
        },
        
        afterError: function(){
            
            this.loaded();
        },
        
        loading:function(){
            this.elements.submit.addClass('ls-loading text-hide px-5 py-3');
        },
        loaded:function(){
            this.elements.submit.removeClass('ls-loading text-hide px-5 py-3');
        }
    });
})(jQuery);