{**
 * Главная
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    <div class="row justify-content-center mt-5">
        
        <div class="col-md-7">
            <h5 class="text-center">Fend помогает получить отзывы и предложения о вашей работе</h5>
            <h6 class="text-center mt-3">Оставлять отзывы и ставить рейтинг людям и компаниям</h6>

            <img class="w-100 mt-4" src="{Config::Get('path.skin.assets.web')}/images/fend1.jpg" alt="">
        </div>
        <div class="col-md-5 d-flex  justify-content-center mt-md-0 mt-4">
            <div style="max-width: 310px;">
                <h5 class="text-center">Зарегестрироваться</h5><br>
                {component 'auth' template='registration'}
            </div>
        </div>
    </div>
    
{/block}