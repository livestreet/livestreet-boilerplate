{* E-mail *}
{component 'bs-form' 
    template    = 'text' 
    name        = "mail"
    placeholder = $aLang.auth.registration.form.fields.email.placeholder
    type        = "email"
    validate       = [ 
        require => true,
        triggers => 'change keyup',
        remote => "{router page='auth'}ajax-validate-email" 
    ]}

{* Имя Фамилия *}
{component 'bs-form' 
    template    = 'text' 
    name        = "name"
    placeholder = $aLang.auth.registration.form.fields.name.placeholder
    type        = "text"
    entity      = Engine::GetEntity('User_User')
    validate    = [ 
        triggers => 'change keyup'
    ]
    }
    
{* Логин *}
{component 'bs-form' 
    template    = 'text' 
    name        = "login"
    placeholder = $aLang.auth.registration.form.fields.login.placeholder
    type        = "text"
    desc        = $aLang.auth.registration.form.fields.login.desc  
    entity      = Engine::GetEntity('User_User')  
    validate       = [ 
        remote => "{router page='auth'}ajax-validate-login",
        triggers => 'change keyup'
    ]}
{component 'bs-form' template='text' placeholder = "Логин" }

{* Пароль *}
{component 'bs-form' template='text' placeholder = "Пароль"}