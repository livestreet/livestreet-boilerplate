/**
 * Media
 *
 * @module ls/uploader
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsMediaField", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Ссылки
            urls: {
                         
            },

            // Селекторы
            selectors: {
                body:  '[data-type="field-body"]',
                field: '[data-type="media-field"]',
                cropModal: '@[data-type="crop-modal"]',
                btn:'[data-toggle="modal"]',
                count: '[data-count]'
            },
            

            // Классы
            classes: {
                file:'[data-type="lib-file"]',
                submitCrop: '.js-crop-submit',
                img: '[data-img]',
                displayNone:'d-none'
            },

            i18n: {
            },

            // Доп-ые параметры передаваемые в аякс запросах
            params: {},
            
            onAdd:null,
            
            name:'files[]',
            
            multiple: true,
            
            

        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super(); 
            
            if(this.element.data('name') !== null){
                this.option('name', this.element.data('name'));
            }
            
            if(this.element.data('multiple') !== null){
                this.option('multiple', this.element.data('multiple'));
            }

            if(this.element.data('cropped') !== undefined){
                this.initCropper();
            }
            
            this.elements.body.find(this.option('classes.file'))
                .popover('disable')
                .find('.close')
                .removeClass(this.option('classes.displayNone'))
                .on('click', function(e){
                    this.remove($(e.currentTarget).closest(this.option('classes.file')));
                }.bind(this));
           
        },
        
        initCropper:function(){
            let data = {};
            data.aspectRatio = this.element.data('cropAspectRatio');
            this.elements.cropModal.bsCropModal("option", 'cropOptions' , data);

            this.elements.cropModal.bsCropModal("option", "onCropped", function(e,params){
                console.log(params, this.element)
                let file = this.elements.body.find('[data-id="'+params.data.id+'"]');
                
                if(params.canvas !== undefined){ 
                    let img = file.find(this.option('classes.img'));
                    img.attr('src', params.canvas.toDataURL())
                }

                $.each(params.size, function(key, val){
                    file.append('<input type="hidden" name="sizes['+params.data.id+']['+key+']" value="'+val+'">');
                })
                file.append('<input type="hidden" name="canvasWidth['+params.data.id+']" value="'+params.canvas_width+'">');
                
                this.elements.cropModal.modal('hide');

            }.bind(this));

            this.option('onAdd' , function(e,file){ 
                this.elements.cropModal.bsCropModal('show', file.data());

            }.bind(this))
        },
        
        add: function(file){
            let inputs = this.elements.body.find('input');
            let files = this.getFiles();
            
            if(inputs.length && !this.option('multiple')){
                files.remove();
                inputs.remove();
            }
            
            this.elements.body.prepend(file);
            
            this.elements.count.val( parseInt(this.elements.count.val()) + 1);
            
            file.append('<input type="hidden" data-file-id="'+file.data('id')
                    +'" name="'+this.option('name')+'" value="'+file.data('id')+'">');
            
            file.find('.close').removeClass(this.option('classes.displayNone')).on('click', this.remove.bind(this, file));
            
            if(!this.option('multiple')){
                this.elements.btn.addClass(this.option('classes.displayNone'));
            }

            this._trigger('onAdd',null, file);
        },
        
        getFiles: function(){
            return this.elements.body.find(this.option('classes.file'));
        },
        
        remove:function(file){
            this.elements.count.val(parseInt(this.elements.count.val()) - 1);
            file.remove();
            this.elements.btn.removeClass(this.option('classes.displayNone'));
        }
    });
})(jQuery);