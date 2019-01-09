{**
 * Оповещение о новом комментарии в топике
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.answer_response.text' params=[
        text            => $oAnswer->getResponse()->getText(),
        user_name       => $oAnswer->getResponse()->getTargetUser()->getName(),
        user_url        => $oAnswer->getResponse()->getTargetUser()->getProfileUrl(),
        text_response   => $oAnswer->getResponse()->getText()]}
{/block}