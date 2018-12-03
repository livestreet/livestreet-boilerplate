{**
 * Табы
 *
 * @param array     $items
 * @param string    $activeItem
 * @param string    $justify        Горизонтальное выравнивание
 * @param bool      $vertical       
 * 
 *}
{component_define_params params=[ 'items', 'activeItem', 'classes', 'attributes', 'bmods', 'id' ]}

{$id = $id|default:{"tabs{math equation='rand()'}"}}

{block 'tabs_content'}{strip}
    {component 'bs-tabs.list' items=$items id=$id params=$params }
    {component 'bs-tabs.panes' items=$items id=$id}    
{/strip}{/block}

