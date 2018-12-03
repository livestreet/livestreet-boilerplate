{**
 * Коллапс
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 *}{strip}
 
 {* Название компонента *}
{$component = "collapse"}

{component_define_params params=[ 'bmods', 'bg', 'classes', 'attributes',  'id', 'content' ]}


{block 'collapse_options'}{/block}

{block 'collapse_content'}{strip}
    <div id="{$id}" class="collapse {$classes}" {cattr list=$attributes}>
        {$content}
    </div>
{/strip}{/block}{/strip}