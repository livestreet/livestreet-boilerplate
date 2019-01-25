{**
 * Тестовая страница
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    {capture name="form"}
        <form  data-form-validate data-form-ajax data-url="{$oUserProfile->getProfileUrl()}/settings/profile-ajax" novalidate>
            {$oUserProfile->_setValidateScenario('profile_settings')}
            
            {* Фото*}

            {$medias = []}
            {$aMedias = $oUserProfile->getMedia('user_photo')}
            {foreach $aMedias as $oMedia}
                {$medias[] = [obj => $oMedia, size => 'photo']}
            {/foreach}

            {component "bs-media.field" 
                medias  = $medias
                crop    = true
                dataCrop  = [
                    'aspect-ratio' => '1'
                ]
                validate = [
                    entity => $oUserProfile,
                    field => 'photo_count'
                ]
                name    = 'photo'
                label   = $aLang.user.settings.profile.form.photo.label 
                text    = $aLang.user.settings.profile.form.photo.text         }
                
            {* Имя Фамилия *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "name"
                label       = $aLang.user.settings.profile.form.name.label
                placeholder = $aLang.user.settings.profile.form.name.placeholder
                type        = "text"
                value       = $oUserProfile->getName()
                validate       = [ 
                    entity  => $oUserProfile
                ]
                }
                
            {* Логин *}
            {component 'bs-form' 
                template    = 'text' 
                name        = "login"
                label       = $aLang.auth.registration.form.fields.login.placeholder
                placeholder = $aLang.auth.registration.form.fields.login.placeholder
                type        = "text"
                desc        = $aLang.auth.registration.form.fields.login.desc  
                value       = $oUserProfile->getLogin()
                validate       = [ 
                    entity  => $oUserProfile,
                    remote  => true,
                    only_change => true
                ]}
                
            {if $oUserProfile->isRole('company')}

                {* Телефон *}
                {component 'bs-form' 
                    template    = 'text' 
                    name        = "phone"
                    label       = $aLang.user.settings.profile.form.phone.label
                    placeholder = $aLang.user.settings.profile.form.phone.placeholder
                    type        = "text"
                    value       = $oUserProfile->getPhone()
                    validate       = [ 
                        entity  => $oUserProfile
                    ]
                    }

                {* Сайт *}
                {component 'bs-form' 
                    template    = 'text' 
                    name        = "site"
                    label       = $aLang.user.settings.profile.form.site.label
                    placeholder = $aLang.user.settings.profile.form.site.placeholder
                    type        = "text"
                    value       = $oUserProfile->getSite()
                    validate       = [ 
                        entity  => $oUserProfile
                    ]
                    }

                {* Адресс *}
                {component 'bs-form' 
                    template    = 'text' 
                    name        = "address"
                    label       = $aLang.user.settings.profile.form.address.label
                    placeholder = $aLang.user.settings.profile.form.address.placeholder
                    type        = "text"
                    value       = $oUserProfile->getAddress()
                    validate    = [ 
                        entity  => $oUserProfile
                    ]
                    }                               
            {/if}
            
            {* О себе *}
            {component 'bs-form' 
                template    = 'textarea' 
                name        = "about"
                label       = $aLang.user.settings.profile.form.about.label
                placeholder = $aLang.user.settings.profile.form.about.placeholder
                value       = $oUserProfile->getAbout()
                validate       = [ 
                    entity  => $oUserProfile
                ]
                }

            <div class="d-flex justify-content-center">
                {component 'bs-button' 
                    classes = ""
                    name='submit_settings' 
                    type="submit" 
                    bmods='primary' 
                    text=$aLang.common.save}
            </div>
        </form>
    {/capture}
    
    {component 'bs-card' bg="light" content=[
        
        [   
            type => 'body',
            content => $smarty.capture.form
        ]
    ]}
    
{/block}

{block "layout_modals" append}
    {component "bs-crop.modal"}
    
{/block}