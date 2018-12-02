{**
 * Основная навигация
 *
 * @param array   $items       Элементы
 * @param array   $itemsCollapse       Элементы сворачиваемые
 * 
 *}
 
{$component = "navbar"}

{component_define_params params=[ 'brand', 'items', 'bmods', 'attributes', 'classes', 'before', 'after' ]}

{$id = "navbar{math equation='rand()'}"}

<nav class="navbar {$classes} {cmods name=$component mods=$bmods delimiter="-"}" {cattr list=$attributes}>
    {if $brand}
        <a class="navbar-brand" href="#">{$brand}</a>
    {/if}
    
    {$before}
    
    <div class="collapse navbar-collapse" id="{$id}">
        {foreach $items as $item}
            {$item}
        {/foreach}   
    </div>
        
    {$after}
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#{$id}" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
</nav>
