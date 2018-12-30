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
    
    public function GetAllByFilter($aFilter) {
        return $this->oMapper->getAllByFilter($aFilter, $this->oMapperORM);
    }

}