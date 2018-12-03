{**
 * Модальное окно с формами входа, регистрации и напоминанием пароля
 *}

{if ! Config::Get('general.reg.invite')}
    {component 'auth' template='registration' assign=auth_tab_reg}
{else}
    {component 'auth' template='invite' assign=auth_tab_reg}
{/if}

{capture name="modal_content"}
    {component "bs-tabs" bmods="tabs" id="auth" items = [
        [ 'text' => {lang 'auth.login.title'},        'content' => {component 'auth' template='login'}, 'name' => 'login' ],
        [ 'text' => {lang 'auth.registration.title'}, 'content' => $auth_tab_reg,   'name' => 'register' ],
        [ 'text' => {lang 'auth.reset.title'},        'content' => {component 'auth' template='reset'},   'name' => 'reset' ]
    ]}

{/capture}


{component 'bs-modal'
    header      = {lang 'auth.authorization'}
    showFooter  = false
    classes     = 'js-modal-default'
    mods        = 'auth'
    id          = 'modalAuth'
    content     = $smarty.capture.modal_content}