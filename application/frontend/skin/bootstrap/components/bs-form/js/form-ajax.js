
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

            this._on(this.element, {submit:"onSubmit"});
            
        },
        
        onSubmit: function(event){

            
            event.preventDefault();
            
            if(this.option('urls.submit') === null){
                return false;
            }

            this.loading();
            
            this._submit('submit', this.element, 'afterSubmit', 
                    {showProgress:false, onError:this.afterError.bind(this)});
                    
            return false;
        },
        
        
        afterSubmit:function(response){
            
            this.loaded();
            
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