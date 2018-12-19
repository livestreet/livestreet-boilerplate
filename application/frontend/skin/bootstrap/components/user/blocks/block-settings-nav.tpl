{component "bs-nav" activeItem=$sActiveItemSettings bmods="pills" items = [
    [
        text => $aLang.user.settings.profile.title, 
        name => 'profile', 
        url => "{$oUserProfile->getProfileUrl()}/settings/profile"
    ],
    [
        text => $aLang.user.settings.notices.title, 
        name => 'notices', 
        url => "{$oUserProfile->getProfileUrl()}/settings/notices"
    ],
    [
        text => $aLang.user.settings.security.title, 
        name => 'security', 
        url => "{$oUserProfile->getProfileUrl()}/settings/security"
    ]
]}