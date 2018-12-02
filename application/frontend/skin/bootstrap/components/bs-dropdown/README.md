# Компонент dropdown

Выпадаеющее меню

{component 'bs-dropdown'
    text="Drop"
    items=[
        [text=>"1", url => '#1'], 
        [text=>"2", url => '#2'],
        [
            text => "submenu",
            menu => [
                items => [
                    [text=>"1", url => '#1'], 
                    [text=>"2", url => '#2']
                ]
            ]
        ]
    ]

}

{component 'bs-dropdown'
    direction="up"
    text="Dropup"
    items=[
        '<h4 class="dropdown-header">Header</h4>',
        [text=>"Span"],
        [text=>"1", url => '#1'],
        [text=>"-"],  
        [text=>"2", url => '#2']
    ] 
}