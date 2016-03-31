var ls = ls || {};

ls.auth = (function ($) {

    /**
     * Подписка/отписка
     */
    this.init = function() {
        /* Авторизация */
        $('.js-auth-login-form, .js-auth-login-form-modal').on('submit', function (e) {
            ls.ajax.submit(aRouter.auth + 'ajax-login', $(this), function ( response ) {
                response.sUrlRedirect && (window.location = response.sUrlRedirect);
            });

            e.preventDefault();
        });

        /* Регистрация */
        $('.js-auth-registration-form, .js-auth-registration-form-modal').on('submit', function (e) {
            ls.ajax.submit(aRouter.auth + 'ajax-register', $(this), function ( response ) {
                response.sUrlRedirect && (window.location = response.sUrlRedirect);
            });

            e.preventDefault();
        });

        /* Восстановление пароля */
        $('.js-auth-reset-form, .js-auth-reset-form-modal').on('submit', function (e) {
            ls.ajax.submit(aRouter.auth + 'ajax-password-reset', $(this), function ( response ) {
                response.sUrlRedirect && (window.location = response.sUrlRedirect);
            });

            e.preventDefault();
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