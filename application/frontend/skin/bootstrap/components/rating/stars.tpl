{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}

{component_define_params params=[  'bmods', 'classes', 'attributes', 'value' ]}

{$value = $value|default:0}

{$value = round($value)}
<div class="stars  {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
    {for $var=1 to $value}
        {component "icon" icon="star" classes="text-warning" mods="lg"}
    {/for}
    {for $var=1 to (5-$value)}
        {component "icon" icon="star-o" classes="text-muted" mods="lg"}
    {/for}

    
</div>
