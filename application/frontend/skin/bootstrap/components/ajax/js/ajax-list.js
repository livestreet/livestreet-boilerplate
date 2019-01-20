/**
 * Подгрузка
 *
 * @module ls/dropdown
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

$.widget( "livestreet.bsAjaxList", $.livestreet.lsComponent, {
    /**
     * Дефолтные опции
     */
    options: {
        urls: {
            load: null
        },
        selectors: {
            container:"[data-ajax-container]",
            btn_load:"[data-load-btn]",
        },
        params:{
          limit: 5,
          start: 0
        },
        classes: {
            display_none:"d-none"
        },
        onloadStart:false,
        
        onAfterLoad:null
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
            this.option('urls.load', this.element.data('url'));
        }

        if(this.element.data('onloadStart') || this.option('onloadStart')){
            this.load();
        }
        
        this._on(this.elements.btn_load, {click:'load'});
    },
    
    load: function(){
        this._load('load', {}, 'afterLoad');
    },
    
    afterLoad: function(respose){
        this.option('params.start', this.option('params.start') + respose.count );
        
        this.elements.container.append(respose.html);
        
        this.elements.container.find('[data-form-validate]').bsFormAjax();
        this.elements.container.find('[data-form-ajax]').bsFormAjax();
        this.elements.container.find('[data-toggle="popover"]').popover();
        this.elements.container.find('[data-toggle="tooltip"]').tooltip();
        
        let fields = this.elements.container.find('[data-type="media-field"]')
        fields.bsMediaField();
        $('.js-modal-media').bsMedia('attachFields',fields );
        
        this.elements.container.find('[data-ajax-btn]').bsAjaxButton();
        
        this.elements.container.find('[data-modal-submit]').on('click', function(e){
            $(this).closest('.modal-content').find('form').submit();
        });
        
        if(this.element.data('counterSelector')){
            $(this.element.data('counterSelector')).text(respose.countAll)
        }
        
        if(!respose.count){
            this.elements.btn_load.addClass(this.option('classes.display_none'));
        }
        
        this._trigger('onAfterLoad', null, {respose:respose, context:this});
    }
});