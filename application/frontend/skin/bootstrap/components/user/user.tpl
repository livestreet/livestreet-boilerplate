{**
 * Информация о производительности движка
 *}

{component_define_params params=[ 'oUser', 'url' ]}

<div class="media">
  <img class="mr-3 rounded-circle" src="{$oUser->getProfileAvatar()}" alt="{$oUser->getLogin()}">
  <div class="media-body">
      <h5 class="mt-0">
          <u>
              <a href="{$url|default:$oUser->getProfileUrl()}" class="link">{$oUser->getLogin()}</a>
          </u>
      </h5>
        {$oUser->getName()}  
  </div>
</div>