{**
 * Модальное окно с формами входа, регистрации и напоминанием пароля
 *}

{if ! Config::Get('general.reg.invite')}
    {component 'auth' template='registration' assign=auth_tab_reg}
{else}
    {component 'auth' template='invite' assign=auth_tab_reg}
{/if}

{capture name="modal_content"}
    {component "bs-tabs" bmods="tabs" items = [
        [ 'text' => {lang 'auth.login.title'},        'content' => {component 'auth' template='login'}, 'classes' => 'js-auth-tab-login' ],
        [ 'text' => {lang 'auth.registration.title'}, 'content' => $auth_tab_reg,   'classes' => 'js-auth-tab-reg' ],
        [ 'text' => {lang 'auth.reset.title'},        'content' => {component 'auth' template='reset'} ]
    ]}

{/capture}


{component 'bs-modal'
    header      = {lang 'auth.authorization'}
    showFooter  = false
    classes     = 'js-modal-default'
    mods        = 'auth'
    id          = 'modalLogin'
    content     = $smarty.capture.modal_content}