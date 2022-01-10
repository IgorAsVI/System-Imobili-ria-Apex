public with sharing class MetDML {
    public static void inserir(decimal met,decimal quant,decimal val){
    imovel__c imovelRecebe = new imovel__c();
    imovelRecebe.Metragem__c = met;
    imovelRecebe.Quantidade_de_vagas__c = quant;
    imovelRecebe.Valorbase__c = val;
    insert imovelRecebe;

    }

    public static void atualizar(id thisID){

        imovel__c imovelAtualizar = new imovel__c();
        imovelAtualizar.id = thisID;
        imovelAtualizar.Status__c ='Vendido';
        update imovelAtualizar;
    }
    public static void atualizar1(id thisID,string status){

        imovel__c imovelAtualizar = new imovel__c();
        imovelAtualizar.id = thisID;
        imovelAtualizar.Status__c =status;
        update imovelAtualizar;
    }

    /*public static list<imovel__c> buscaporIDDML( id thisID){
   return[ SELECT
    id
    FROM
    imovel__c
    WHERE
    id = : thisID
    ];
    }*/

    /*public static  void aumentaValor(id thisID,decimal porcento){

        imovel__c imovelAtualizar = new imovel__c();
        imovelAtualizar.id = thisID;
        imovelAtualizar.Valorbase__c =imovelAtualizar.Valorbase__c*(10);
       update imovelAtualizar;
    }*/

    public static void deletar(id thisID){

        imovel__c imovelAtualizar = new imovel__c();
        imovelAtualizar.id = thisID;
        delete imovelAtualizar;
    }
}


