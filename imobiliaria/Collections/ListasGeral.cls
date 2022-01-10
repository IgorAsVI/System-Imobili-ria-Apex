public with sharing class ListasGeral {
    public static list<imovel__C> listImoveiscomQuintal(){
// Criar um método que retorna uma lista de casas que possuem quintal
       return [SELECT Id,
         name,
         status__c,
         ValorBAse__C
          FROM 
          imovel__c 
          WHERE 
          RecordType.name = 'Casa'  
          AND 
          Possuiquintal__c = true
          ];




    }
    public static list<imovel__c> listImoveiscomSacada(){
       // Criar um método que retorne um lista de apartamentos que possuem sacada
        return [
        SELECT 
        Id,
        name,
        status__c,
        ValorBAse__C
        FROM 
        imovel__c 
        WHERE 
        Possuisacada__c = true
         ];


    }

    public static list<imovel__C> ordenaImovelMaisCaro(){
       
        return [
         SELECT 
         Id,
         name,
         status__c,
         ValorBAse__C
         FROM
         imovel__c 
         ORDER BY
         ValorBAse__c DESC
         ];

    }
    public static  imovel__c selecionaImovelMaisCaro (){
      // Criar um método que retorne apenas o imóvel mais caro
        list<imovel__c> imovel = ordenaImovelMaisCaro();

        return imovel[0];


}

public static list <PropostaDeCompra__c> listaPropostas(){
    return [
        SELECT 
        Id,
        name
        FROM
        PropostaDeCompra__c 
        ORDER BY
        Moeda__c DESC
        ];
    
}
public static PropostaDeCompra__c retornaPropostaMaisCara(){
    // criar um método que retorne apenas a proposta mais cara
    list <PropostaDeCompra__c> lista = listaPropostas();
   return lista[0];
}

public static list<imovel__c> ordenaPorMetragem(){

         return [
          SELECT 
          Id,
          name,
          status__c,
          ValorBAse__C,
          Metragem__c
          FROM
          imovel__c 
          ORDER BY
          Metragem__c DESC
          ];
     }
     
public static imovel__C retornaValorDoMaior(){
    list <imovel__c> lista = ordenaPorMetragem();
    return lista[0] ;
}
}
