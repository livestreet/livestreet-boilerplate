{**
 * Оповещение о новом комментарии в топике
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.arbitrage_answer.text' params=[
        text            => $oArbitrage->getResponse()->getText(),
        user_name       => $oArbitrage->getResponse()->getTargetUser()->getName(),
        user_url        => $oArbitrage->getResponse()->getTargetUser()->getProfileUrl(),
        arbitrage_url   => $oArbitrage->getUrl()]}
{/block}