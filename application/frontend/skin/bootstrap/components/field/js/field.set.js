/**
 * Набор полей
 *
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Oleg Demidov <boxmilo@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.lsFieldSet", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            max:10,
            min:2,
            // Селекторы
            selectors: {
                add:         '.js-fieldset-item-add',
                list:        '.js-fieldset-list',
                template:    '.js-fieldset-item[data-is-template]',
                item:       {
                    item: '.js-fieldset-item',
                    item_id:     '.js-fieldset-item-id',
                    item_text:   '.js-fieldset-item-text',
                    item_remove: '.js-fieldset-item-remove'
                }
            },
            params: {},
            i18n: {
                error_items_max:"@poll.notices.error_answers_max"
            }
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();
            
            let form = this.element.closest('form').after(this.elements.template);
            
            this._on( this.elements.add, {click: "itemAdd"})
            this._on( $(this.option( 'selectors.item.item_remove' )), {click:"itemRemove"}  );
           
        },
        
        itemAdd: function( ) {
            let items = this.elements.list.find( this.option( 'selectors.item.item' ) );
            // Ограничиваем кол-во добавляемых ответов
            if ( items.length == this.option( 'max' ) ) {
                ls.msg.error( null, this._i18n( 'error_items_max', { count: this.option( 'max' ) } ) );
                return;
            }            

            var item = this.elements.template.clone().removeAttr( 'data-is-template' ).show();
            
            this._on( item.find( this.option( 'selectors.item.item_remove' ) ), {click:"itemRemove"}  );

            this.elements.list.append( item );
            
            this.controlRemove();
            
            item.find( this.option( 'selectors.item.item_text' ) ).focus();
        },
        itemRemove: function( e ) { 
            let itemToRemove = $(e.currentTarget).closest( this.option( 'selectors.item.item' ) );
            itemToRemove.fadeOut(200, function (el) {
                itemToRemove.remove();
                this.controlRemove();
            }.bind(this));
            
        },
        controlRemove: function(){
            let items = this.elements.list.find( this.option( 'selectors.item.item' ) );console.log(items)
            
            if ( items.length > this.option( 'min' ) ) {
                items.find( this.option( 'selectors.item.item_remove' ) ).show();
            }else{
                items.find( this.option( 'selectors.item.item_remove' ) ).hide();
            }
        }
    });
})(jQuery);