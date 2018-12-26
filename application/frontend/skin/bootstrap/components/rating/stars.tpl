{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}

{component_define_params params=[  'mods', 'classes', 'attributes', 'value' ]}

<div  class="star-rating {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
    <div class="star-rating__wrap">
        <input class="star-rating__input" id="star-rating-5" type="radio" name="rating" value="5" {if round($value) == 5}checked{/if}>
        <label class="star-rating__ico fa fa-star-o fa-lg" for="star-rating-5" title="5 out of 5 stars"></label>
        <input class="star-rating__input" id="star-rating-4" type="radio" name="rating" value="4" {if round($value) == 4}checked{/if}>
        <label class="star-rating__ico fa fa-star-o fa-lg" for="star-rating-4" title="4 out of 5 stars"></label>
        <input class="star-rating__input" id="star-rating-3" type="radio" name="rating" value="3" {if round($value) == 3}checked{/if}>
        <label class="star-rating__ico fa fa-star-o fa-lg" for="star-rating-3" title="3 out of 5 stars"></label>
        <input class="star-rating__input" id="star-rating-2" type="radio" name="rating" value="2" {if round($value) == 2}checked{/if}>
        <label class="star-rating__ico fa fa-star-o fa-lg" for="star-rating-2" title="2 out of 5 stars"></label>
        <input class="star-rating__input" id="star-rating-1" type="radio" name="rating" value="1" {if round($value) == 1}checked{/if}>
        <label class="star-rating__ico fa fa-star-o fa-lg" for="star-rating-1" title="1 out of 5 stars"></label>
    </div>
</div>
