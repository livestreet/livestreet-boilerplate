{**
 * Основная навигация
 *
 * @param array   $items       Элементы
 * @param array   $itemsCollapse       Элементы сворачиваемые
 * 
 *}
 
{$component = "navbar"}

{component_define_params params=[ 'brand', 'url', 'items', 'bmods', 'attributes', 'classes', 'before', 'after', 'classesBrand' ]}

{$id = "navbar{math equation='rand()'}"}

<nav class="navbar {$classes} {cmods name=$component mods=$bmods delimiter="-"}" {cattr list=$attributes}>
    {if is_array($brand)}
        {$brand.classes = "{$brand.classes} navbar-brand"}
        {component "bs-button" params=$brand}
    {else}
        <a class="navbar-brand" href="{$url}">{$brand}</a>
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
