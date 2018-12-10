{* E-mail *}
{component 'bs-form' 
    template    = 'text' 
    name        = "mail"
    placeholder = "Email" 
    type        = "email"
    validate       = [ 
        triggers => 'change keyup',
        messageError => $aLang.auth.registration.form.fields.email.error,
        remote => "{router page='auth'}ajax-validate-email" 
    ]}

{* Имя Фамилия *}
{component 'bs-form' template='text' placeholder = "Имя Фамилия"}

{* Логин *}
{component 'bs-form' template='text' placeholder = "Логин" desc=$aLang.auth.registration.form.fields.login.desc}

{* Пароль *}
{component 'bs-form' template='text' placeholder = "Пароль"}