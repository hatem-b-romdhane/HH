<?php
/**
 * Created by PhpStorm.
 * User: LENOVO
 * Date: 26/03/14
 * Time: 10:32
 */

class CronControllerCore extends FrontController
{
    public function initContent()
    {
        parent::initContent();
    }

    public function postProcess()
    {
        $this->Crontab();
    }

    public function Crontab()
    {

        $oldQuestionnaire = Questionnaire::getOldProduct();
        //var_dump($oldQuestionnaire);
        foreach ($oldQuestionnaire as $old)
        {
            Questionnaire::setInacative($old['id_product']);
            $gagnant =Questionnaire::getGagnant($old['id_product']);
            if($gagnant != null)
            {
                Questionnaire::deleteCategoryProduct($old['id_product']);
                Questionnaire::updateCategory($old['id_product']);
                Questionnaire::addGagnant($gagnant['0']['id_customer'],$old['id_product']);

                var_dump($old['id_product']);
                var_dump($gagnant);
            }
        }
    }

}