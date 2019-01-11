{**
 * Media content
 *}
 
{component_define_params params=[ 'uploader' ]}

{$component="bs-media"}

<div class="{$component} js-media">
    <div class="row">
        <div class="col-12">
            
            {component 'bs-media.uploader' 
                targetType  = 'user'
                userId    = $oUserCurrent->getId()
                attributes  = [ 'data-type' => 'media-uploader' ]
                params      = $uploader}
        </div>
    </div>
    <hr>
    {component "bs-media.library"}
</div>

