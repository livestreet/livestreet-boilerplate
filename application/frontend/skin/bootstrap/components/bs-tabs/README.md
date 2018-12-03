# Компонент navbar

Навигация

{component "bs-nav" bmods="pills" items = [
    [ 
        menu => [
            text => "item1", 
            items => [
                [text => "drop1"],
                [text => "drop2"],
                [text => "-"],
                [
                    text => "drop2",
                    menu => [
                        items => [
                            [text => "drop1"],
                            [text => "drop2"],
                            [text => "-"],
                            [
                                text => "drop2",
                                menu => [
                                    items => [
                                        [text => "drop1"],
                                        [text => "drop2"]
                                    ]
                                ] 
                            ]
                        ]
                    ] 
                ]
            ]
        ]
    ],
    [text => "item2", url => "22"],
    [text => "item3", url => "33"]
]}