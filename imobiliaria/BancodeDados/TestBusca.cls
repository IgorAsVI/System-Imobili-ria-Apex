public with sharing class TestBusca {
    public static imovel__c busc( id thisID){
        return[ SELECT
         id,
         name,
         Valorbase__c,
         Metragem__c
         FROM
         imovel__c
         WHERE
         id = :thisID
         ];
         }


         public static decimal vpm (id idImovel){
            imovel__c imovel = busc(idImovel);
            return (imovel.Valorbase__c / imovel.Metragem__c);
}

public static  void aumentaValor(id thisID,decimal porcento){

    imovel__c imovelAtualizar = new imovel__c();
    imovelAtualizar.id = thisID;
    imovelAtualizar.Valorbase__c =imovelAtualizar.Valorbase__c*(10);
   update imovelAtualizar;
}
}