{**
 * Информация о производительности движка
 *}

{component_define_params params=[ 'oUser', 'url', 'classes', 'textWrap' ]}

{if $oUser->isAnoname()}
    {$url = '#'}
{/if}


<div class="media {$classes}">
  <img class="mr-3 rounded-circle" src="{$oUser->getProfileAvatar()}" alt="{$oUser->getLogin()}">
  <div class="media-body {if !$textWrap}text-truncate{/if}">
      <h5 class="mt-0">
          <u>
              <a href="{$url|default:$oUser->getProfileUrl()}" 
                {if $oUser->isAnoname()}
                    {component "bs-popover" content=$aLang.user.is_anoname.text}
                {/if}
                      class="link">{$oUser->getLogin()}</a>
          </u>
      </h5>
        {$oUser->getName()}  
  </div>
</div>