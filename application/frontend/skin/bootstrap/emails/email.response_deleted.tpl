{**
 * Оповещение о новом комментарии в топике
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.response_deleted.text' params=[
        text => $oResponse->getText(),
        user_name => $oResponse->getTargetUser()->getName(),
        user_url => $oResponse->getTargetUser()->getProfileUrl()]}
{/block}