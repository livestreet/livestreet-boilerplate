
(function($) {
    "use strict";

    $.widget( "livestreet.bsFieldStar", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Классы
            selectors: {
                inputs:'input[type="radio"]',
                field:'.js-field-input'
            }
            
            
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function() {
            this._super();
            
            this._on(this.elements.inputs, {change:"onChange"});
        },
        
        onChange: function(){
            let val = this.element.find('input[type="radio"]:checked').val();
            this.elements.field.val(val).change();
        }
        
    });
})(jQuery);