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

    $.widget( "livestreet.bsLibrary", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Ссылки
            urls: {
                // Подгрузка файлов
                load: aRouter['ajax'] + 'media/load-gallery/', 
                remove: aRouter['ajax'] + 'media/remove-file/',               
            },

            // Селекторы
            selectors: {
                files:  '[data-type="lib-files"]',
                libInfo: '[data-type="lib-info"]',
                fileInfoEmpty: '[data-type="info-empty"]',
                info: '[data-type="file-info"]',
                btnRemove:'[data-type="file-remove"]'
            },
            // Классы
            infoList: {
                id:'[data-type="id"]',
                img:'[data-type="img"]',
                name:'[data-type="name"]',
                date:'[data-type="date"]',
                dimensions:'[data-type="dimensions"]',
                countTargets:'[data-type="count-targets"]',
                size:'[data-type="size"]',
                sizes: '[data-type="sizes"]'
            },

            // Классы
            classes: {
                item:'[data-type="lib-file"]'                
            },

            i18n: {
            },

            // Доп-ые параметры передаваемые в аякс запросах
            params: {}

        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();

            this.elements.btnRemove.lsConfirm({
                message: ls.lang.get('media.notices.confirm_remove_file'),
                onconfirm: this.onClickRemove.bind(this)
            });
            
        },
        
        loadFiles:function(){
            this.reset();
            this._load('load', {}, 'append');
        },
        
        append: function(response){
            this.elements.files.html(response.html);
            
            this.elements.items= this.elements.files.find(this.option('classes.item'))
            this.elements.items.on('click', function(e){
                this.selectItem( $(e.currentTarget) );
            }.bind(this));
            
            this.elements.files.find('[data-type="pagination"]').bsPagination({
                goPage:function(e,page){
                    this.reset();
                    this._load('load', {page:page}, 'append');
                }.bind(this)
            });
            
            this.elements.files.find('[data-toggle="popover"]').popover();
        },
        
        selectItem: function(file){
            this.elements.fileInfoEmpty.addClass('d-none');
            this.elements.info.removeClass('d-none');
            
            this.elements.items.removeClass('border-1  p-1').addClass('p-2');
            file.addClass('border-1 p-1').removeClass('p-2');
            
            $.each(this.option('infoList'), function(name, selector){
                this.elements.info.find(selector).html(file.data(name))
            }.bind(this));
            
            //let sel = this.addSizesSelect(file.data('mediaSizes'));
            
            this.option('selectedItem', file);
            
        },
        
        getSelectSize: function(){
            if(this.option('select') !== null){
                return this.option('select').val();
            }
        },
        
        addSizesSelect: function(sizes){
            let sel = $(document.createElement('select')).attr('name', 'sizes');
            
            $.each(sizes, function(i, size){
                let opt = $(document.createElement('option'));
                let sSize = size.w + "x" + (size.h !== null?size.h:"") + (size.crop?"crop":"");
                opt.val(sSize).text(sSize);
                sel.append(opt);
            })
            
            this.elements.info.find(this.option('infoList.sizes')).html(sel);
            
            this.option('select', sel);
            
            return sel;
        },
        
        getSelectItem: function(){
            if(!this.option('selectedItem')){
                return null;
            }
            return this.option('selectedItem').clone();
        },
        
        reset: function(){
            this.elements.fileInfoEmpty.removeClass('d-none');
            this.elements.info.addClass('d-none');
        },
        
        onClickRemove: function(){
            this._load('remove', {id:$(this.option('infoList.id')).text()}, "loadFiles");
        }

        
    });
})(jQuery);