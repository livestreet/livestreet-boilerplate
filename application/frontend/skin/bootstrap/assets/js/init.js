/**
 * Инициализации модулей
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

jQuery(document).ready(function($){
    // Хук начала инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_start',[],window);
    
    /*
     *  Код для реализации dropdown-submenu
     */
    $('.dropdown-menu a.dropdown-toggle').on('mouseover click', function(e) {
        if (!$(this).next().hasClass('show')) {
            $(this).parents('.dropdown-menu').first().find('.show').removeClass("show");
        }
        var $subMenu = $(this).next(".dropdown-menu");
        $subMenu.toggleClass('show');


        $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function(e) {
            $('.dropdown-submenu .show').removeClass("show");
        });
        return false;
    });
    
    /*
     * Бутстрап
     */
    $('[data-toggle="popover"]').popover();
    $('[data-toggle="tooltip"]').tooltip();
    
     
    /*
     * Modals
     */
    $('[data-type="crop-modal"]').bsCropModal();
    
    $('.js-modal-media').bsMedia();
    
     // Отправка формы в модальном окне
    $('[data-modal-submit]').on('click', function(e){
        $(this).closest('.modal-content').find('form').submit();
    });
    
    /*
     * Пересчет модальных окон при закрытии вложенных
     */
//    $('.modal').on('hidden.bs.modal', function (e) {
//        console.log($('.modal.show'))
//        $($('.modal.show').get(0)).modal('handleUpdate')
//    })
    
    /*
     * Дополнительная обработка табов в модальных окнах
     */
    $('[data-toggle="modal-tab"]').on('click', function(event){
        $($(this).data('target')).tab('show');
    });
    
    $('[data-toggle="modal"]').on('click', function(event){
        $($(this).data('target')).modal('toggle');
        return false;
    });

    
    $('html').removeClass('no-js');

    /**
     * Иниц-ия модулей ядра
     */
    ls.init({
        production: false
    });

    ls.dev.init();

    /*
     * Lightbox
     */
    $('[data-lightbox]').lsLightbox({ width:"100%", height:"100%" });

    /**
     * Подтверждение удаления
     */
    $('.js-confirm-remove-default').livequery(function () {
        $(this).lsConfirm({
            message: ls.lang.get('common.remove_confirm'),
        });
    });
    
    $('[data-confirm-remove]').livequery(function () {
        $(this).lsConfirm({
            message: ls.lang.get('common.remove_confirm'),
            onconfirm: function(e){
                $(e.target).submit();
            }
        });
    });


    /**
     * Notification
     */
    ls.notification.init();

    
    
    /*
     * Validate  должно быть перед ajax формой
     */
    $('[data-form-validate]').bsFormValidate();
    /*
     * Ajax форма
     */
    $('[data-form-ajax]').bsFormAjax();
    /**
     * Auth and AJAX
     */
    
    $('.js-auth-login-form').bsFormAjax({
        urls:{
            submit: aRouter.auth + 'ajax-login'
        }
    });
    $('.js-auth-reset-form').bsFormAjax({
        urls:{
            submit: aRouter.auth + 'ajax-password-reset'
        }
    });
    
    // Подгрузка ajax
    $('[data-ajax-list]').bsAjaxList();
    
    $('[data-ajax-btn]').bsAjaxButton();
    
    // Ajax поиск
    $('[data-ajax-search]').bsAjaxSearch();
    
    
    
   
    /*
     * Автозавершение
     */
    $('[data-autocomplete]').bsAutocomplete();
    /**
     * Editor
     */
    $( '.js-editor-default' ).lsEditor();
    
    /*
     * Пагинация
     */
    $('[data-type="pagination"]').bsPagination();
   
    $('.js-field-star').bsFieldStar();

    // Хук конца инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_end',[],window);
});

