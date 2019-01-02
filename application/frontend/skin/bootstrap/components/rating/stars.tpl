{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}
{$component ="stars"}
{component_define_params params=[  'bmods', 'classes', 'attributes', 'value' ]}

{$value = $value|default:0}

{$value = round($value)}
<div class="stars  {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
    {for $var=1 to $value}
        {component "bs-icon" icon="star" display="s" classes="text-warning" mods="lg"}
    {/for}
    {for $var=1 to (5-$value)}
        {component "bs-icon" icon="star"  classes="text-muted" mods="lg"}
    {/for}

    
</div>
