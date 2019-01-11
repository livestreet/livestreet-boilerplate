{**
 * Информация о производительности движка
 *}

{component_define_params params=[ 'oUser', 'url' , 'classes']}

<div class="media mt-3 {$classes}">
    <img class="mr-3 rounded-circle" src="{$oUser->getProfileAvatar()}" alt="{$oUser->getLogin()}">
    <div class="media-body">
        <div class="row">
            <div class="col-sm-6 col-md-4">
                <u><a href="{$url|default:$oUser->getProfileUrl()}" >{$oUser->getLogin()}</a></u><br>
                {$oUser->getName()}
            </div>
            <div class="col-sm-6 mt-sm-0 mt-2 col-md-8">
                {component "rating.stars" value=$oUser->getRating()}
                <a href="#collapse{$oUser->getId()}" data-toggle="collapse">{$aLang.user.item.more}</a>
            </div>
        </div>
        <div class="collapse" id="collapse{$oUser->getId()}">
            {$oUser->getAbout()}
        </div>
    </div>
</div><hr>