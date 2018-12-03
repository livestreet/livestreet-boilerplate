# Компонент navbar

Основная навигация

{component 'navbar' 
    classes = "bg-light" 
    bmods = "expand-lg light" 
    brand = Config::Get('view.name')
    items = [
        {component "bs-nav" bmods="pills" classes="navbar-nav mr-auto" activeItem=$sMenuHeadItemSelect items = [
            [ 'text' => "Читать ПДД",   'url' => {router page='wiki/wikipdd'},      'name' => 'wikipdd' ],
            [ 'text' => $aLang.topic.topics,   'url' => {router page='/'},      'name' => 'blog' ],
            [ 'text' => $aLang.blog.blogs,     'url' => {router page='blogs'},  'name' => 'blogs' ],
            [ 'text' => $aLang.user.users,     'url' => {router page='people'}, 'name' => 'people' ],
            [ 'text' => $aLang.activity.title, 'url' => {router page='stream'}, 'name' => 'stream' ]
        ]},
        {component 'search' template='navbar'}
]}