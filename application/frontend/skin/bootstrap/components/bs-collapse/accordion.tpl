{**
 * Аккордион
 *
 * @param mixed   $text             Массив либо строка с текстом уведомления. Массив должен быть в формате: `[ [ title, msg ], ... ]`
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * @param bool    $indicators       Индикаторы
 * @param bool    $controls         Кнопки Previous Next
 *}{strip}
 
{* Название компонента *}
{$component = "accordion"}

{component_define_params params=[ 'bmods', 'bg', 'classes', 'attributes',  'btnClasses', 'controls', 'items', 'id' ]}

{$id = $id|default:{"accordion{math equation='rand()'}"}}
{$attributes = ['id' => $id]}

{block 'collapse_options'}{/block}

{block 'collapse_content'}{strip}
    
    <div class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        {foreach $items as $item}
            {$idCollapse = "collapse{math equation='rand()'}"}
            {$idHeading = "heading{math equation='rand()'}"}
            {component 'bs-card'
                border =   $item.bmods
                classes = $item.classes                
                content=[
                [   
                    
                    type => 'header',
                    bg =>   $item.bmods,
                    attributes => [ 'id' => $idHeading ],
                    content => [
                        [
                            type => "tit", 
                            content => {component "bs-button"
                                textMod = $item.textMod
                                bmods = "link"
                                text = $item.text
                                attributes = [
                                    "data-toggle"=>"collapse",
                                    "data-target"=>"#{$idCollapse}"
                                ]
                            }
                        ]
                    ]
                ],
                {component "bs-collapse.item" 
                    attributes = [
                        "aria-labelledby" =>    $idHeading,
                        "data-parent" =>        "#{$id}",
                        "id" =>                   $idCollapse
                    ]
                    id = $idCollapse
                    content = {component 'bs-card' type="body" content = $item.content}
                }
            ]}
        {/foreach}
    </div>
{/strip}{/block}{/strip}