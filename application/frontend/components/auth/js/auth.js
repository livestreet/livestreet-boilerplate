var ls = ls || {};

ls.auth = (function ($) {

    /**
     * Подписка/отписка
     */
    this.init = function() {
        /* Авторизация */
        ls.ajax.form(aRouter.auth + 'ajax-login', '.js-auth-login-form', function (result) {
            result.sUrlRedirect && (window.location = result.sUrlRedirect);
        });

        /* Регистрация */
        ls.ajax.form(aRouter.auth + 'ajax-register', '.js-auth-registration-form', function (result) {
            result.sUrlRedirect && (window.location = result.sUrlRedirect);
        });

        /* Восстановление пароля */
        ls.ajax.form(aRouter.auth + 'ajax-password-reset', '.js-auth-reset-form', function (result, status, xhr, form) {
            form.find('input').val('');
            result.sUrlRedirect && (window.location = result.sUrlRedirect);
        });

        /* Повторный запрос на ссылку активации */
        ls.ajax.form(aRouter.auth + 'ajax-reactivation', '.js-form-reactivation', function (result, status, xhr, form) {
            form.find('input').val('');
            ls.hook.run('ls_user_reactivation_after', [form, result]);
        });

        /* Модальное окно авторизации */
        $('.js-modal-toggle-registration').on('click', function (e) {
            $('.js-auth-tab-reg').lsTab('activate');
            $('#modal-login').lsModal('show');
            e.preventDefault();
        });

        $('.js-modal-toggle-login').on('click', function (e) {
            $('.js-auth-tab-login').lsTab('activate');
            $('#modal-login').lsModal('show');
            e.preventDefault();
        });
    };

    return this;
}).call(ls.auth || {}, jQuery);