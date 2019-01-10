<?php


class ActionCompanies extends Action
{

    protected $sMenuHeadItemSelect = 'companies';

    /**
     * Инициализация
     *
     */
    public function Init()
    {
        $this->SetDefaultEvent('');
    }

    /**
     * Регистрация евентов
     *
     */
    protected function RegisterEvent()
    {
         $this->AddEventPreg( '/^(page(\d))?$/i',  ['EventSearch' , 'companies']);
    }


    public function EventSearch() {
        $iLimit = Config::Get('module.user.search.per_page');
        
        $iPage = $this->GetEventMatch(2);
        $iPage = $iPage?$iPage:1;
        
        $aFilter = [
            '#index-from'   => 'id',
            '#page'         => [$iPage, $iLimit],
            'activate'      => 1,
            'role'          => 'company'
        ];
        
        $aUsers = $this->User_GetUserItemsByFilter($aFilter);

            
                
        $aPaging = $this->Viewer_MakePaging($aUsers['count'], $iPage, $iLimit, 
                Config::Get('module.user.search.pagination.pages_count'), Router::GetPath('people'));

        $this->Viewer_Assign('aPaging', $aPaging);
        $this->Viewer_Assign('aUsers', $aUsers['collection']);
        $this->Viewer_Assign('count', $aUsers['count']);
        $this->SetTemplateAction('search');
    }

}