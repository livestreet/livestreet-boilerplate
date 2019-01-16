{component "bs-nav" activeItem=$sActiveItemSettings bmods="pills" items = [
    [
        text => $aLang.user.settings.profile.title, 
        name => 'profile', 
        url => "{$oUserProfile->getProfileUrl()}/settings/profile"
    ]
]}