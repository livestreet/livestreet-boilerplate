{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}

{component_define_params params=[  'mods', 'classes', 'attributes', 'stat' ]}

{function name="progress" stars=1 value=0}
    <div class="row">
        <div class="col-4 col-lg-4  text-right" style="line-height: 0.8em;">
            {for $foo=1 to $stars}
                <small>{component "icon" icon="star"  classes="text-muted small"}</small>
            {/for}
        </div>
        <div class="col-8 col-lg-8 align-items-end" style="line-height: 0.8em;">
            {component "bs-progressbar" popover=[content=>"{$value}%"] value=$value height=5 bg="warning" classes="mt-1"}
        </div>
    </div>
{/function}

<div class="{$classes}"  {cattr list=$attributes}>
    {foreach $stat as $key => $val}
        {progress stars=$key value=$val}
    {/foreach}
</div>