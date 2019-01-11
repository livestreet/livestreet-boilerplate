/**
 * Подгрузка
 *
 * @module ls/dropdown
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

$.widget( "livestreet.bsAjaxSearch", $.livestreet.lsComponent, {
    /**
     * Дефолтные опции
     */
    options: {
        popover: {
            content:"...",
            placement:"bottom",
            trigger:"manual",
            html:true,
            boundary:"viewport"
        },
        urls: {
            search: null
        },
        selectors: {
            
        },
        params:{
          
        },
        classes: {
           
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
        
        if(this.element.data('url')){
            this.option('urls.search', this.element.data('url'));
        }
        
        this.element.popover(this.option('popover')); 
        
        this.element.on('keyup', function(){
            this._load('search', {query:this.element.val()}, 'onLoad')
        }.bind(this));
        
        $('body').click(function(){
            this.element.popover('hide');
        }.bind(this));
        
    },
    onLoad: function(response){
        if(response.count>0){
            //this.element.data('content', response.html);
            this.element.data('bs.popover').config.content = response.html;
            this.element.popover('show');
        }else{
            this.element.popover('hide');
        }
    }
});