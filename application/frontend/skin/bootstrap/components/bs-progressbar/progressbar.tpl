{**
 * Кнопка
 *
 * @param string   $value     
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 *}
 


{component_define_params params=[ 'bmods', 'text', 'bg', 'classes', 'attributes', 'value', 'min', 'max', 'popover' ]}

{* Название компонента *}
{$component = "progress-bar"}

{block 'button_options'}{/block}

{block 'button_content'}{strip}
    <div class="progress">
        <div class="{$component} {cmods name=$component mods=$bmods delimiter="-"}" 
             {bs_popover popover=$popover} {cattr list=$attributes}
             role="progressbar" style="width: {$value}%" aria-valuenow="{$value}" 
             aria-valuemin="{$min|default:"0"}" aria-valuemax="{$max|default:"100"}">{$text}</div>
    </div>    
{/strip}{/block}