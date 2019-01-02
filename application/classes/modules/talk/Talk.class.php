<?php

class ModuleTalk extends ModuleORM
{
    /**
     * Инициализация
     *
     */
    protected $oMapper = null;

    public function Init()
    {
        parent::Init();
       // $this->oMapper = Engine::GetMapper(__CLASS__);
    }
    
//    public function GetAllByFilter($aFilter) {
//        return $this->oMapper->getAllByFilter($aFilter, $this->oMapperORM);
//    }

    public function GetItemsByFilter($aFilter = [], $sEntityFull = NULL) {
        $sEntityName = func_underscore($sEntityFull);
        
        if(in_array($sEntityName, ['response', 'answer', 'arbitrage', 'proposal'])){
            return parent::GetItemsByFilter(array_merge($aFilter, ['type' => $sEntityName]), $sEntityFull );
        }
        
        return parent::GetItemsByFilter($aFilter, $sEntityFull );
    }
    
    public function GetByFilter($aFilter = array(), $sEntityFull = null){
        $sEntityName = func_underscore($sEntityFull);
        
        if(in_array($sEntityName, ['response', 'answer', 'arbitrage', 'proposal'])){
            return parent::GetByFilter(array_merge($aFilter, ['type' => $sEntityName]), $sEntityFull );
        }
        return parent::GetByFilter($aFilter, $sEntityFull );
    }
    
    public function GetCountItemsByFilter($aFilter = array(), $sEntityFull = null){
        $sEntityName = func_underscore($sEntityFull);
        
        if(in_array($sEntityName, ['response', 'answer', 'arbitrage', 'proposal'])){
            return parent::GetCountItemsByFilter(array_merge($aFilter, ['type' => $sEntityName]), $sEntityFull );
        }
        return parent::GetCountItemsByFilter($aFilter, $sEntityFull );
    }
}