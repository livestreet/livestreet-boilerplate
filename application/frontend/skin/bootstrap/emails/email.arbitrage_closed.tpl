{**
 * Оповещение о новом комментарии в топике
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.arbitrage_closed.text' params=[
        text            => $oResponse->getText(),
        user_name       => $oResponse->getTargetUser()->getName(),
        user_url        => $oResponse->getTargetUser()->getProfileUrl(),
        arbitrage_url   => $oArbitrage->getUrl(),
        result          => {lang "emails.arbitrage_closed.result.{$oResponse->getState()}"}
    ]}
{/block}