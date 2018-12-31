<div class="cont">
<div class="title">
  <h1>stars<span>.css</span></h1>
</div>
<div class="stars">
<form action="">
  <input class="star star-5" id="star-5" type="radio" name="star"/>
  <label class="star star-5" for="star-5"></label>
  <input class="star star-4" id="star-4" type="radio" name="star"/>
  <label class="star star-4" for="star-4"></label>
  <input class="star star-3" id="star-3" type="radio" name="star"/>
  <label class="star star-3" for="star-3"></label>
  <input class="star star-2" id="star-2" type="radio" name="star"/>
  <label class="star star-2" for="star-2"></label>
  <input class="star star-1" id="star-1" type="radio" name="star"/>
  <label class="star star-1" for="star-1"></label>
</form>
</div>
  <p>click the stars</p>
</div>


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
    <div class="d-flex align-items-center ">
        <div class="d-block">
            
            <input class="star star-last" id="star-5" type="radio" name="star"/>
            <label class="star star-last" for="star-5"></label>
            <input class="star star-4" id="star-4" type="radio" name="star"/>
            <label class="star star-4" for="star-4"></label>
            <input class="star star-3" id="star-3" type="radio" name="star"/>
            <label class="star star-3" for="star-3"></label>
            <input class="star star-2" id="star-2" type="radio" name="star"/>
            <label class="star star-2" for="star-2"></label>
            <input class="star star-first" id="star-1" type="radio" name="star"/>
            <label class="star star-first" for="star-1"></label>
        </div>
    </div>
{/block}
