# Компонент form

Форма

{component 'bs-form'  items=[
    [   
        type => "email",
        label => 'Email',
        placeholder => "email@email",
        desc => "lkdjnkljndlskjn",
        value => "eerer",
        required => true,
        validateError => "Ошибка email",
        validateSuccess => "Правильный email"
    ],
    [   
        type => "text",
        label => 'Text',
        placeholder => "текст",
        desc => "Описание текста",
        readonly => true,
        size => "lg"
    ],
    [   
        type => "range",
        label => 'Диапазон',
        desc => "Описание Диапазон",
        custom => true
    ],
    [   
        type => "checkbox",
        label => 'Флажок',
        custom => true,
        size => "lg"
    ],
    [   
        type => "checkbox",
        label => '1',
        radio => true,
        checked => true,
        name => "radio1",
        custom => true
    ],
    [   
        type => "checkbox",
        label => '2',
        radio => true,
        name => "radio1",
        custom => true
    ],
    {component "bs-form.group" content=[
        {component "bs-form.checkbox" params=[   
            type => "checkbox",
            label => '1',
            inline => true,
            radio => true,
            checked => true,
            name => "radio2"
        ]},
        {component "bs-form.checkbox" params=[   
            type => "checkbox",
            label => '2',
            inline => true,
            radio => true,
            name => "radio2"
        ]}
    ]},
    [   
        type => "select",
        label => 'Select',
        name => "sel",
        items => [
            [text => "First", value => '1'],
            [text => "second", value => '2']
        ],
        selected => '2',
        custom => true,
        size => "sm"
    ],
    [   
        type => "file",
        label => 'File',
        name => "filesel",
        custom => true,
        size => "sm"
    ],
    {component "bs-button" text="Отправить" type="submit"}
]}