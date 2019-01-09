{**
 * Оповещение о новом комментарии в топике
 *}

{extends 'Component@email.email'}

{block 'content'}
    {lang name='emails.proposal_new.text' params=[
        text => $oProposal->getText(),
        user_name => $oProposal->getTargetUser()->getName(),
        user_url => $oProposal->getTargetUser()->getProfileUrl()]}
{/block}