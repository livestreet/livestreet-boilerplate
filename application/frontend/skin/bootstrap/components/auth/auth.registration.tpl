{**
 * Форма регистрации
 *
 * @param string $redirectUrl
 *}

{$redirectUrl = $smarty.local.redirectUrl|default:$PATH_WEB_CURRENT}

<div class=" justify-content-center mx-1">
    {component "bs-tabs" bmods = 'pills primary' classes="mt-3 mb-3 d-flex justify-content-center" items = [
        [ text => 'Личность', content => {component 'auth.fields-user'}, active => true ],
        [ text => 'Компания', content => {component 'auth.fields-company'}]
    ]}
</div>
