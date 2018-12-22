
{$component = 'bs-media-library'}
{component_define_params params=[  'iUserId' , 'attributes', 'classes', 'mods' ]}

{$attributes = array_merge( $attributes|default:[], [
    'data-param-user-id' => $iUserId,
    'data-type'     => "library"
])}

<div class="{$component} {cmods name=$component mods=$mods} {$classes} row navbar-expand-lg" {cattr list=$attributes}>
    <div class="col-lg-8 col-12 d-flex align-self-start" data-type="files">
        <div data-type="lib-files">
            {component "blankslate" 
                classes     = "mb-0" 
                text        = $aLang.media.library.files.empty}
        </div>
    </div>
    <div class="col-lg-4 col-12 mt-lg-0 mt-2 pl-0">
        <div data-type="lib-info" class="p-0 collapse navbar-collapse">
            {component "blankslate" 
                attributes  = ["data-type" => "info-empty"]
                classes     = "mb-0" 
                text        = $aLang.media.library.info.empty}
                
            {component "bs-media.file-info"}
            
        </div>
    </div>
    
    <div class="file-tmpl d-none row">
        <div class="col-4">
            <div class="name-file">

            </div>
        </div>
        
        <div class="col">
            <div class="progress mt-1 w-100">
                <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
            </div>        
        </div>
        <div class="col-1">
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
        </div>
    </div>
</div>
