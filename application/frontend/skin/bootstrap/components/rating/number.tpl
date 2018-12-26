{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}

{component_define_params params=[  'mods', 'classes', 'attributes', 'value', 'of' ]}

<span class="display-2 text-secondary"><strong>{$value}</strong></span> <span class="text-muted">{$aLang.rating.of} {$of}</span>
