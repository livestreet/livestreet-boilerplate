{component "bs-nav" activeItem=$sActiveItemSettings bmods="pills" items = [
    [
        text => $aLang.user.settings.nav.profile, 
        name => 'profile', 
        url => "{$oUserCurrent->getProfileUrl()}/settings/profile"
    ],
    ['text' => $aLang.user.settings.nav.profile, 'url' => "{$oUserCurrent->getProfileUrl()}/settings"]
]}