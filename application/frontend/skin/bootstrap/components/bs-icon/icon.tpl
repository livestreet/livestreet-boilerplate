{**
 * Иконка
 *
 * @param string $icon
 * @param string $classes
 * @param string $mods
 * @param array  $attributes
 *}

{$component = 'fa'}
{component_define_params params=[ 'icon', 'mods', 'classes', 'attributes', 'display' ]}

<i class="{$component}{$display|default:"r"} fa-{$icon} {cmods name=$component mods=$mods delimiter='-'} {$classes}" {cattr list=$attributes}></i>