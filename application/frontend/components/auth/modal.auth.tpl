{**
 * Модальное окно с формами входа, регистрации и напоминанием пароля
 *}

{component 'auth' template='registration' assign=auth_tab_reg modal=true}

{component 'modal'
    title      = {lang 'auth.authorization'}
    options    = [ 'center' => 'false' ]
    showFooter = false
    classes    = 'js-modal-default'
    mods       = 'auth'
    id         = 'modal-login'
    tabs       = [ 'tabs' => [
        [ 'text' => {lang 'auth.login.title'},        'content' => {component 'auth' template='login' modal=true}, 'classes' => 'js-auth-tab-login' ],
        [ 'text' => {lang 'auth.registration.title'}, 'content' => $auth_tab_reg,   'classes' => 'js-auth-tab-reg' ],
        [ 'text' => {lang 'auth.reset.title'},        'content' => {component 'auth' template='reset' modal=true} ]
    ]]}