
{component_define_params params=[ 'targetType', 'targetId', 'userId', 'targetTmp', 'name' ]}

{$attributes = array_merge( $attributes|default:[], [
    'data-param-target_type' => {$targetType|default:'user'},
    'data-param-target_id'   => $targetId,
    'data-param-user_id'   => $userId,
    'data-param-security_ls_key'  => $LIVESTREET_SECURITY_KEY,
    'data-type'             => 'uploader'
])}

<div class="{$component} {cmods name=$component mods=$mods} {$classes}" {cattr list=$attributes}>
    {* Drag & drop зона *}
    {component 'bs-media' template='upload-area' name={$name|default:"filedata"}}
    
    <div class="file-uploded-tmpl d-none row">
        <div class="col-12 col-md-6">
            <div class="name-file">

            </div>
        </div>
        
        <div class="col-11 col-md-5">
            <div class="progress mt-1 w-100">
                <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
            </div>        
        </div>
        <div class="col-1 col-md-1">
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
        </div>
    </div>
</div>
