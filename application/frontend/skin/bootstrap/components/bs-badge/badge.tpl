{**
 * Значки
 *
 * @param mixed   $text           Массив либо строка с текстом уведомления. Массив должен быть в формате: `[ [ title, msg ], ... ]`
 * @param string  $bmods="success" Список модификторов основного блока (через пробел)
 * @param string  $classes        Список классов основного блока (через пробел)
 * @param array   $attributes     Список атрибутов основного блока
 *}

 
{* Название компонента *}
{$component = "badge"}

{component_define_params params=[  'text',  'bmods', 'classes', 'attributes' ]}

{* Smarty-блок для изменения опций *}
{block 'badge_options'}
{/block}


{block 'badge_content'}
    <span class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>{$text}</span>
{/block}