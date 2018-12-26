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
    {$classesGroup = "{$classesGroup} rating-group"}
{/block}


{block name="field_input"}

        <br>
        {if $withClear}
            <input class="rating__input rating__input--none" name="{$name}" id="rating-none" value="0" 
                checked   type="radio">
            <label aria-label="{lang 'rating.stars.clear'}"  title="{lang 'rating.stars.clear'}" class="rating__label" for="rating-none">
                <i class="rating__icon rating__icon--none fa fa-ban"></i>
            </label>
        {/if}

        
        {for $var=1 to $count}
            <label class="rating__label" aria-label="{lang 'rating.stars.title' val=$var of=$count}"  for="rating-{$var}"
                   aria-label="{lang 'rating.stars.title' val=$var of=$count}"  title="{lang 'rating.stars.title' val=$var of=$count}">
                <i class="rating__icon rating__icon--star fa fa-star"></i>
            </label>
            <input class="rating__input form-control d-none" id="rating-{$var}" type="radio" {cattr list=$attributes} 
                   {field_make_rules entity=$entity field=$name } name="{$name}" value="{$var}" 
                   {if round($value) == {$var}}checked{/if}>
            
        {/for}    
    
{/block}
