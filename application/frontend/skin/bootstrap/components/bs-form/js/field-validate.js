
(function($) {
    "use strict";

    $.widget( "livestreet.bsFieldValidate", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Классы
            classes: {
                invalidFeedback:".invalid-feedback",
                validFeedback:".valid-feedback"
            },
            
            triggers:null,
            
            triggersDefault:"change",

            // Ссылка
            urls: {
                load: null,
                remote: aRouter.ajax + "validate"
            },
            
            // Параметры запроса
            params: {}
            
            
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function() {
            this._super();
            
            this.feedbackElements();
            
            let triggers;
            
            if((triggers = this.option('triggers')) === null){
                if((triggers = this.element.attr('triggers')) === undefined){
                    triggers = this.option('triggersDefault');
                }
            }
            
            this.element.on(triggers, this.validate.bind(this));
            
            this.option('value', this.element.val());
            
        },
        
        feedbackElements:function(){
            this.elements.invalidFeedback = this.element.parent().find(this.option('classes.invalidFeedback'));
            this.elements.validFeedback = this.element.parent().find(this.option('classes.validFeedback'));
        },
        
        is_change: function(){
            if(!this.element.data('onlyChange')){
                return true;
            }
            return (this.element.val() != this.option('value'));
        },
        
        validate:function(){
            let url;
            
            if(this.element.data('remote') && this.is_change()){ 
                
                if(this.element.data('url')){
                    this.option('urls.remote', this.element.data('url'));
                }
                
                this.remoteValidate(url);
                return;
            } 
            
            let element = this.element.get( 0 );
            if(element !== undefined && element.checkValidity()){
                this.setValid();
            }else{
                this.setInvalid();
            }
        },
        
        setValid:function(){
            this.element.removeClass('is-invalid').addClass('is-valid');
        },
        
        setInvalid:function(){
            this.element.removeClass('is-valid').addClass('is-invalid');
        },
        
        remoteValidate:function(){
            this._load('remote', {value:this.element.val()}, function(response){
                if(response.error !== undefined){
                    this.setErrorMessage(response.error)
                    this.setInvalid();
                }else{
                    this.setValid();
                }
            }.bind(this), {showProgress :false});
        },        
        
        isValid:function(){
            return this.element.hasClass('is-valid');
        },
        
        setErrorMessage:function(mess){
            this.elements.invalidFeedback.html(mess);
        },
        
        setErrorMessageNotice:function(error){
            this.element.attr('msg', error)
        },
        
        showErrorMessageNotice:function(){
            if ( this.element.attr('type') == 'hidden' && this.element.hasClass('is-invalid')) {
                ls.msg.error( this.element.attr('name'), this.element.attr('msg') );
            }
        }
    });
})(jQuery);