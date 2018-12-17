/**
 * Пагинация
 *
 * @module ls/pagination
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.bsPagination", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            keys: {
                // Комбинация клавиш для перехода на следующую страницу
                next: 'ctrl+right',

                // Комбинация клавиш для перехода на предыдущую страницу
                prev: 'ctrl+left'
            },

            // Хэш добавляемый к url при переходе на страницу
            hash: {
                next: '',
                prev: ''
            },
            
            selectors:{
                items:'[data-type="page-item"]',
                prev:'[data-type="page-prev"]',
                next:'[data-type="page-next"]'
            },

            i18n: {
                last: '@pagination.notices.last',
                first: '@pagination.notices.first'
            },
            goPage:null
        },

        /**
         * Конструктор
         *
         * @constructor
         * @private
         */
        _create: function () {
            this._super();
            
            this._on(this.elements.items, {click:"go"})
            
            this.document.bind( 'keydown' + this.eventNamespace, this.options.keys.next, this.next.bind(this, false) );
            this.document.bind( 'keydown' + this.eventNamespace, this.options.keys.prev, this.prev.bind(this, false) );
        },
        
        go: function(e){
            this.elements.items.removeClass('active');
            $(e.currentTarget).addClass('active');
            
            this._trigger('goPage',  null,  $(e.currentTarget).data('page'));
            
            return false;
        },

        /**
         * Переход на страницу
         *
         * @param {String} name Название функции
         */
        _go: function ( name ) {
            return function( useHash ) {
                var url = this.element.data( 'pagination-' + name );

                if ( url ) {
                    //window.location = url + ( this.options.hash[ name ] && useHash ? '#' + this.options.hash[ name ] : '' );
                } else {
                    ls.msg.error( null, this._i18n( name == 'next' ? 'last' : 'first' ) );
                }
            }
        },

        /**
         * Переход на следующую страницу
         *
         * @param {Boolean} useHash Добавлять параметр gotopic в хэш или нет
         */
        next: function ( useHash ) {
            return this._go( 'next' ).apply(this, arguments);
        },

        /**
         * Переход на предыдущую страницу
         *
         * @param {Boolean} useHash Добавлять параметр gotopic в хэш или нет
         */
        prev: function ( useHash ) {
            return this._go( 'prev' ).apply(this, arguments);
        }
    });
})(jQuery);