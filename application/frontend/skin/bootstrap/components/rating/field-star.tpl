{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}
 
 {extends "component@bs-form.field"}

{component_define_params params=[ 'count', 'withClear' ]}


{block name="field_options"}
    {$classesGroup = "{$classesGroup} rating-group js-field-star"}
{/block}


{block name="field_input"}
    <input type="number" name="{$name}" style="display:none;"
        class="js-field-input {$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" 
        {cattr list=$attributes} {cattr list=$validateRules}>
    <div class="d-flex align-items-center ">
        <div class="d-block">
            {for $var=$count to 1 step -1}
                {$classInput = ""}
                {if $var == 1}
                    {$classInput = 'star-first'}
                {/if}
                
                {if $var == $count}
                    {$classInput = 'star-last'}
                {/if}

                <input class="star {$classInput}" value="{$var}" id="star-{$var}" type="radio" name="{$name}" {if $value == $var}checked{/if}/>
                <label class="star {$classInput}" aria-label="{lang 'rating.stars.title' val=$var of=$count}" for="star-{$var}"
                    title="{lang 'rating.stars.title' val=$var of=$count}"></label>

            {/for}
        </div>
    </div>
{/block}
