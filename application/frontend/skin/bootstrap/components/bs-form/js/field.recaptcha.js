/**
 * ReCaptcha
 *
 * @module ls/recaptcha
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function ($) {
    "use strict";

    var notReadyItems = [];

    $.widget("livestreet.bsReCaptcha", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            captchaName: null,
            name: null,
            site_key: null,
            urls: {
                register:   aRouter.auth + "ajax-register",
                verify:     aRouter.ajax + "verify-recaptcha"
            },
            verifyRecaptcha:null
        },
        
        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();
            
            this.element.data('recaptcha', true);
        },

        execute: function( call ){
            grecaptcha.execute(this.option('site_key'), {action: 'login' }).then(function(token) {
                this._load('verify', {token:token}, function(response){
                    call(response);
                    this._trigger( "verifyRecaptcha", null, { context: this, response: response } );
                }.bind(this), {showProgress:false})
            }.bind(this));
        },
        
        reset: function () {
            grecaptcha.reset(this.grecaptcha);
        }
    });
})(jQuery);