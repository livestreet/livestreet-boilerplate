
{$component = 'bs-media-file'}
{component_define_params params=[  'items' , 'paging',  'attributes', 'classes', 'mods' ]}

{component "bs-pagination"
    attributes  = [ "data-type" => "pagination"]
    current     = $paging.iCurrentPage
    total       = $paging.iCountPage}

{foreach $items as $item}
    {component "bs-media.file" oMediaItem = $item}
{/foreach}

{component "bs-pagination"
    attributes  = [ "data-type" => "pagination"]
    current     = $paging.iCurrentPage
    total       = $paging.iCountPage}