{**
 * Рейтинг

 * @param array|string $list
 * @param array|string $tabs
 * @param string       $mods       Список модификторов основного блока (через пробел)
 * @param string       $classes    Список классов основного блока (через пробел)
 * @param array        $attributes Список атрибутов основного блока
 *}

{$component = 'bs-rating'}
{component_define_params params=[  'mods', 'classes', 'attributes', 'oUser' ]}

<div class="row {$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
    <div class="col-12 col-sm-6 col-lg-3 text-center">
        {component "rating.number" value=$oUser->getRating() of={Config::Get('module.rating.max_rating')}}
    </div>
    <div class="col-12 col-sm-6 col-lg-3  text-center  align-self-end pb-3">
{*        {component "rating.stars"  value = $oUser->getRating()}*}
            
        <span class="text-muted">
            {$aLang.rating.count}: 
            {count_modifer count=$oUser->getCountRated()}
        </span>
    </div>
    <div class="col-12 col-sm-12 col-lg-6   align-self-end pb-3">
        {component "rating.stat" stat=$oUser->getRatingStat() 
            classes="mr-4"
            attributes=['style' => 'line-height:1.2em;']}
    </div>
</div>
