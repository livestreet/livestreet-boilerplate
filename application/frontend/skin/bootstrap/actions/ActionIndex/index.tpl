{**
 * Главная
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    <div class="row justify-content-center">
        <h4 class="text-center col-md-7">Fend помогает получить отзывы и предложения о вашей работе</h4>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-7">
            <img class="w-100 mt-4" src="{Config::Get('path.skin.assets.web')}/images/fend1.jpg" alt="">
        </div>
        <div class="col-md-5 d-flex  justify-content-center">
            <div  style="max-width: 310px;">
                {component 'auth' template='registration'}
            </div>
        </div>
    </div>
    
{/block}