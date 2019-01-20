

<form data-url="{router page='auth/ajax-register'}" method="post" name="register_user"  
      autocomplete="off" 
      action="{router page='auth/register'}" data-form-ajax data-form-validate novalidate>
    
    <input type="password" style="display:none;">
    
    {$oUserProfile = Engine::GetEntity('User_User')}
    {$oUserProfile->_setValidateScenario('registration')}
    
    {hook run='form_registration_begin'}
    {* E-mail *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "mail"
        placeholder = $aLang.auth.registration.form.fields.email.placeholder
        type        = "email"
        validate    = [ 
            entity  => $oUserProfile,
            remote  => true
        ]}

    {* Имя Фамилия *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "name"
        placeholder = $aLang.auth.registration.form.fields.name.placeholder
        type        = "text"
        validate    = [ 
            entity  => $oUserProfile
        ]
    }

    {* Логин *}
    {component 'bs-form' 
        template    = 'text' 
        name        = "login"
        placeholder = $aLang.auth.registration.form.fields.login.placeholder
        type        = "text"
        desc        = $aLang.auth.registration.form.fields.login.desc  
        validate    = [ 
            entity  => $oUserProfile,
            remote  => true
        ]
    }

    {* Пароль *}
    {component 'bs-form' template='text' 
        type        = "password"
        name        = "password"
        attributes  = [autocomplete => "off"]
        placeholder = $aLang.auth.registration.form.fields.password.placeholder
        validate    = [ 
            entity  => $oUserProfile
        ]
    }

    {if Config::Get('module.user.captcha_use_registration')}
        {component "bs-form.recaptcha" 
            validate    = [ 
                entity  => $oUserProfile
            ]
            name        = "recaptcha"}
    {/if}
        
    {hook run='form_registration_end'}

    {if $redirectUrl}
        <input type="hidden"  class="ls-field-input is-valid" value="{$redirectUrl}" name="return-path" >        
    {/if}

    <input type="hidden"  class="ls-field-input is-valid" value="user" name="role" >

    <div class="d-flex justify-content-center">
        {component 'bs-button' 
            classes = ""
            name='submit_register' 
            type="submit" 
            bmods='primary' 
            text=$aLang.auth.registration.form.fields.submit.text}
    </div>
</form>
