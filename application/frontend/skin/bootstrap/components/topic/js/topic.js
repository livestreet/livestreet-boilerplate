/**
 * comment
 *
 * @module ls/topic
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

(function($) {
    "use strict";

    $.widget( "livestreet.lsTopic", $.livestreet.lsComponent, {
        /**
         * Дефолтные опции
         */
        options: {
            // Ссылки
            urls: {
                vote: aRouter.ajax + 'vote/topic/',
                voteInfo: aRouter.ajax + 'vote/get/info/topic'
            },

            // Селекторы
            selectors: {
                vote: '.js-vote-topic',
                favourite: '.js-favourite-topic',
                tags: '.js-tags-favourite'
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

            // Избранное
            this.elements.favourite.lsTopicFavourite({
                tags: this.elements.tags
            });

            // Голосование за топик
            this.elements.vote.lsVote({
                urls: {
                    vote: this.option( 'urls.vote' ),
                    info: this.option( 'urls.voteInfo' )
                }
            });

            // Теги
            this.elements.tags.lsTagsFavourite({
                urls: {
                    save: aRouter['ajax'] + 'favourite/save-tags/'
                },
                params: {
                    target_type: 'topic'
                }
            });
        }
    });
})(jQuery);