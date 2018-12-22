/**
 * Модальное окно с кропом изображения
 *
 * @module ls/crop/modal
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsCropModal", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            
            // Селекторы
            selectors: {
                crop: '[data-type="crop"]',
                submit: '[data-type="btn-modal"]',
                body: ".modal-body"
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

            

            this._on(this.elements.submit, { click: 'onSubmit' });
        },
        
        show: function(data){
            this.element.modal('show');
            this.element.on('shown.bs.modal', function(){
                
                this.elements.crop.attr('src', data.src);
                this.option('data', data);
                
                this.elements.crop.bsCrop($.extend(this.option('cropOptions'), {
                    minContainerWidth:this.elements.body.width()
                }));
                
            }.bind(this));
            
            
        },
        
        getCropper: function(){
            return this.elements.crop;
        },

        /**
         * Сабмит
         */
        onSubmit: function() {
            var params = {
                size: this.elements.crop.bsCrop( 'getSelection' ),
                canvas_width: this.elements.crop.bsCrop( 'getImageData' ).naturalWidth,
                canvas: this.elements.crop.bsCrop('getCanvas'),
                data: this.option('data')
            };
            
            this._trigger('onCropped',null, params);
        }
    });
})(jQuery);