{**
 * Оповещение о новом комментарии в топике
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.arbitrage_closed.text' params=[
        text            => $oArbitrage->getResponse()->getText(),
        user_name       => $oArbitrage->getResponse()->getTargetUser()->getName(),
        user_url        => $oArbitrage->getResponse()->getTargetUser()->getProfileUrl(),
        arbitrage_url   => $oArbitrage->getUrl(),
        result          => {lang "emails.arbitrage_closed.result.{$oArbitrage->getResponse()->getState()}"}
    ]}
{/block}