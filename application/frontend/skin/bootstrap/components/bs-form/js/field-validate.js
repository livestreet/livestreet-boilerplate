
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
                load: null
            },
            
            // Параметры запроса
            params: {},
            
            isValid:false
            
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
            
            let triggers, url;
            
            if((triggers = this.option('triggers')) === null){
                if((triggers = this.element.attr('triggers')) === undefined){
                    triggers = this.option('triggersDefault');
                }
            }
            
            if((url = this.element.attr('remote')) === undefined){
                this.element.on(triggers, this.validate.bind(this));
            }else{
                this.element.on(triggers, function(e){
                    this.remoteValidate(url);
                }.bind(this));
            } 
            
        },
        
        feedbackElements:function(){
            this.elements.invalidFeedback = this.element.parent().find(this.option('classes.invalidFeedback'));
            this.elements.validFeedback = this.element.parent().find(this.option('classes.validFeedback'));
        },
        
        validate:function(){
            let element = this.element.get( 0 ); 
            if(element.checkValidity()){
                this.setValid();
            }else{
                this.setInvalid();
            }
        },
        
        setValid:function(){
            this.option('isValid', true);
            this.element.removeClass('is-invalid').addClass('is-valid');
        },
        
        setInvalid:function(){
            this.option('isValid', false);
            this.element.removeClass('is-valid').addClass('is-invalid');
        },
        
        remoteValidate:function(url){
            ls.ajax.load(url, {mail:this.element.val()}, function(response){
                if(response.errors !== undefined){
                    this.setErrorMessage(Object.values(response.errors).shift()[0])
                    this.setInvalid();
                }else{
                    this.setValid();
                }
            }.bind(this));
        },        
        
        isValid:function(){
            return this.option('isValid');
        },
        
        setErrorMessage:function(mess){
            this.elements.invalidFeedback.html(mess);
        }
    });
})(jQuery);