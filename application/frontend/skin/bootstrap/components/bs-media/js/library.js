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
            },

            // Селекторы
            selectors: {
                files:  '[data-type="lib-files"]',
                libInfo: '[data-type="lib-info"]',
                fileInfoEmpty: '[data-type="info-empty"]',
                info: '[data-type="file-info"]'
            },
            // Классы
            infoList: {
                id:'[data-type="id"]',
                img:'[data-type="img"]',
                name:'[data-type="name"]',
                date:'[data-type="date"]',
                dimensions:'[data-type="dimensions"]',
                sizes:'[data-type="sizes"]',
                size:'[data-type="size"]'
                
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

            this.loadFiles();
            
           
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
            
            this.option('selectedItem', file);
            
            this.elements.items.removeClass('border-1  p-1').addClass('p-2');
            file.addClass('border-1 p-1').removeClass('p-2');
            
            $.each(this.option('infoList'), function(name, selector){
                this.elements.info.find(selector).html(file.data(name))
            }.bind(this))
            
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
        }

        
    });
})(jQuery);