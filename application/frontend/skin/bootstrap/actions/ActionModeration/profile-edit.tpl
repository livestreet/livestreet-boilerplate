{**
 * Отзывы
 *}
{extends 'layouts/layout.base.tpl'}


{block 'layout_page_title'}
    {if !$oProfile}
        <h2 class="page-header">{$aLang.moderation.profiles.edit.title_add}</h2>
        {$oProfile = Engine::GetEntity('User_User')}
    {else}
        <h2 class="page-header">{$aLang.moderation.profiles.edit.title_edit}</h2>
    {/if}
    
{/block}
                    
{block 'layout_content'}
    
    <form action="" data-form-ajax data-form-validate data-url="{router page='moderation/ajax-edit-profile'}" novalidate>
        
        
        {$oProfile->_setValidateScenario('add')}

        {* Роль *}
        {component 'bs-form' 
            template    = 'select' 
            name        = "role"
            selected       = $oProfile->getRole()
            label       = $aLang.moderation.profiles.form.role.label
            items       = [
                [text => $aLang.moderation.profiles.form.role.value.user, value => 'user'],
                [text => $aLang.moderation.profiles.form.role.value.company, value => 'company']
            ]
            validate    = [ 
                entity  => $oProfile
            ]

        }

        {* Имя Фамилия *}
        {component 'bs-form' 
            template    = 'text' 
            name        = "name"
            placeholder = $aLang.moderation.profiles.form.name.placeholder
            type        = "text"
            value       = $oProfile->getName()
            validate    = [ 
                entity  => $oProfile
            ]
        }

        {* Логин *}
        {component 'bs-form' 
            template    = 'text' 
            name        = "login"
            placeholder = $aLang.auth.registration.form.fields.login.placeholder
            type        = "text"
            desc        = $aLang.auth.registration.form.fields.login.desc 
            value       = $oProfile->getLogin()
            validate    = [ 
                entity  => $oProfile,
                remote  => true,
                only_change => (!$oProfile->_isNew())
            ]
        }

        {* О себе *}
        {component 'bs-form' 
            template    = 'textarea' 
            name        = "about"
            value       = $oProfile->getAbout()
            placeholder = $aLang.moderation.profiles.form.about.placeholder
            validate    = [ 
                entity  => $oProfile
            ]
        }

        {* Site *}
        {component 'bs-form' 
            template    = 'text' 
            name        = "site"
            placeholder = $aLang.moderation.profiles.form.site.placeholder
            desc        = $aLang.moderation.profiles.form.site.desc 
            type        = "text"
            value       = $oProfile->getSite()
            validate    = [ 
                entity  => $oProfile
            ]
        }

        {* Адресс *}
        {component 'bs-form' 
            template    = 'text' 
            name        = "address"
            placeholder = $aLang.moderation.profiles.form.adrress.placeholder
            type        = "text"
            value       = $oProfile->getAddress()
            validate    = [ 
                entity  => $oProfile
            ]
        }

        {* Телефон *}
        {component 'bs-form' 
            template    = 'text' 
            name        = "phone"
            placeholder = $aLang.moderation.profiles.form.phone.placeholder
            type        = "text"
            value       = $oProfile->getPhone()
            validate    = [ 
                entity  => $oProfile
            ]
        }

        {* Фото*}

        {$medias = []}
        {$aMedias = $oProfile->getMedia('user_photo')}
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
                entity => $oProfile,
                field => 'photo_count'
            ]
            name    = 'photo'
            label   = $aLang.user.settings.profile.form.photo.label 
            text    = $aLang.user.settings.profile.form.photo.text         }
            
        {* Активация *}
        {component 'bs-form' 
            template    = 'checkbox' 
            name        = "activate"
            label       = $aLang.moderation.profiles.form.activate.label
            checked       = $oProfile->getActivate()
        }

        {if $redirectUrl}
            <input type="hidden"  class="ls-field-input is-valid" value="{$redirectUrl}" name="return-path" >        
        {/if}
        
        {if !$oProfile->_isNew()}
            <input type="hidden"  class="ls-field-input is-valid" value="{$oProfile->getId()}" name="id" >
        {/if}

        

        <div class="d-flex justify-content-center">
            {component 'bs-button' 
                classes = ""
                name='submit_edit' 
                type="submit" 
                bmods='primary' 
                text=$aLang.common.save}
        </div>
    </form>
{/block}

{block "layout_modals" append}
    {component "bs-crop.modal"}
    
{/block}