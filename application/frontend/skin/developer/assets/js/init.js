/**
 * Инициализации модулей
 *
 * @license   GNU General Public License, version 2
 * @copyright 2013 OOO "ЛС-СОФТ" {@link http://livestreetcms.com}
 * @author    Denis Shakhov <denis.shakhov@gmail.com>
 */

jQuery(document).ready(function ($) {
    // Хук начала инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_start', [], window);

    /**
     * Иниц-ия модулей ядра
     */
    ls.init({
        production: false
    });

    ls.dev.init();

    /**
     * Notification
     */
    ls.notification.init();

    /**
     * Form validate
     */
    $('.js-form-validate').parsley();

    /**
     * Modals
     */
    $('.js-modal-default').lsModal();

    /**
     * Каптча
     */
    $('[data-type=captcha]').livequery(function () {
        $(this).lsCaptcha();
    });

    $('[data-type=recaptcha]').livequery(function () {
        $(this).lsReCaptcha({
            key: ls.registry.get('recaptcha.site_key')
        });
    });

    /**
     * Авторизация/регистрация
     */
    ls.auth.init();

    // Хук конца инициализации javascript-составляющих шаблона
    ls.hook.run('ls_template_init_end', [], window);
});