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
    
    $('[data-toggle="popover"]').popover();
    $('[data-toggle="tooltip"]').tooltip();
    
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


    

    /**
     * Подтверждение удаления
     */
    $('.js-confirm-remove-default').livequery(function () {
        $(this).lsConfirm({
            message: ls.lang.get('common.remove_confirm')
        });
    });


    /**
     * Notification
     */
    ls.notification.init();

    
    /**
     * Auth
     */
    $('.js-auth-registration-form').bsFormAjax({
        urls:{
            submit: aRouter.auth + 'ajax-register'
        },
        needValidate:true
    });
    
    $('.js-auth-login-form').bsFormAjax({
        urls:{
            submit: aRouter.auth + 'ajax-login'
        }
    });
    
    $('[data-type="form-ajax"]').bsFormAjax();
    

    $('.js-form-validate').bsFormValidate();
    
    if(window.grecaptcha !== undefined ){
        grecaptcha.ready(function() {
            $('.js-recaptcha-form').bsReCaptcha({
                site_key: ls.registry.get('recaptcha.site_key')
            });

        });
    }
    
    $('.js-media').bsMedia();
    
    $('.js-auth-reset-form').bsFormAjax({
        urls:{
            submit: aRouter.auth + 'ajax-password-reset'
        }
    });
    /**
     * Editor
     */
    $( '.js-editor-default' ).lsEditor();
    
    $('[data-type="pagination"]').bsPagination();

    // Хук конца инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_end',[],window);
});

