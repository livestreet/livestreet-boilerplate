{component "bs-nav" activeItem=$sActiveItemSettings bmods="pills" items = [
    [
        text => $aLang.user.settings.profile.title, 
        name => 'profile', 
        url => "{$oUserProfile->getProfileUrl()}/settings/profile"
    ],
    [
        text => $aLang.user.settings.security.title, 
        name => 'security', 
        url => "{$oUserProfile->getProfileUrl()}/settings/security"
    ],
    [
        text => $aLang.user.settings.change_mail.title, 
        name => 'change_mail', 
        url => "{$oUserProfile->getProfileUrl()}/settings/change_mail"
    ]

]}