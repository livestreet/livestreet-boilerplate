# Компонент button

Кнопка

{component 'bs-button' bmods="outline-warning lg" text="warning" badge="text"}

{component 'bs-button.toggle' items=[
    [text=>"1", url => '#1', bmods=>"success"], 
    [text=>"2", url => '#2', bmods=>"secondary"]] 
}

{component 'bs-button.group' bmods="lg" classes="m-1" items=[
    [text=>"1", url => '#1', bmods=>"success"], 
    [text=>"2", url => '#2', bmods=>"secondary"],
    [text=>"3", url => '#3', bmods=>"primary"]] 
}


{component 'bs-button.toolbar' groups=[
    [
        classes=>"mr-1",
        items => [
            [text=>"1", url => '#1', bmods=>"success"], 
            [text=>"2", url => '#2', bmods=>"secondary"],
            [text=>"3", url => '#3', bmods=>"primary"]
        ]
    ],
    [
        classes=>"mr-2",
        items => [
            [text=>"4", url => '#1', bmods=>"success"], 
            [text=>"5", url => '#2', bmods=>"secondary"],
            [text=>"6", url => '#3', bmods=>"primary"]
        ]
    ],
    {component 'bs-button.group' classes="mr-1" items= [
        [text=>"6", url => '#1',   bmods=>"success"], 
        [text=>"7", url => '#2', bmods=>"secondary"],
        [text=>"8", url => '#3', bmods=>"primary"]
    ]}
]
}

{component 'bs-button.group'
    items=[
        [text=>"1", url => '#1', bmods=>"success"], 
        [text=>"2", url => '#2', bmods=>"secondary"],
        {component 'bs-button.group'  items=[
                [text=>"bgroup", url => '#1', bmods=>"success"]
            ]
        }
    ] 
}