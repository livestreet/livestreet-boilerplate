
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
                
            {capture name="content"}
                <div class="row mb-1">
                    <div class="col-12"  data-type="img"></div>
                </div>
                <div class="row mb-1">
                    <div class="col-sm-6 col-12">{$aLang.media.library.info.list.id}</div>
                    <div class="col-sm-6 col-12" data-type="id"></div>
                </div>
                <div class="row mb-1">
                    <div class="col-sm-6 col-12">{$aLang.media.library.info.list.name}</div>
                    <div class="col-sm-6 col-12" data-type="name"></div>
                </div>
                <div class="row mb-1" >
                    <div class="col-sm-6 col-12">{$aLang.media.library.info.list.date}</div>
                    <div class="col-sm-6 col-12" data-type="date"></div>
                </div>
                <div class="row mb-1">
                    <div class="col-sm-6 col-12">{$aLang.media.library.info.list.dimensions}</div>
                    <div class="col-sm-6 col-12" data-type="dimensions"></div>
                </div>
                <div class="row mb-1">
                    <div class="col-sm-6 col-12">{$aLang.media.library.info.list.size}</div>
                    <div class="col-sm-6 col-12" data-type="size"></div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-12">{$aLang.media.library.info.list.sizes}</div>
                    <div class="col-sm-6 col-12" data-type="sizes"></div>
                </div>
            {/capture}

            {component "bs-card" classes="d-none"
                attributes = ['data-type' => 'file-info']
                content=[
                    [
                        type => 'body',
                        content => $smarty.capture.content
                    ]
                ]}
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
