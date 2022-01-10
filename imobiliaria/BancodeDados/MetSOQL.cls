public with sharing class MetSOQL {
  
   /* public static imovel__c buscaTdsImoveis(){
        return[
            SELECT Name, 
            RecordType.name,
            Valorbase__c 
            FROM 
            imovel__c
        ];
    }*/

    public static list <imovel__c> buscaApts(){
        return[
            SELECT Name, 
            RecordType.name,
            Valorbase__c 
            FROM 
            imovel__c
            WHERE
            RecordType.name ='Apartamento'
        ];
        
    }
    
    /*public static decimal recebeIDMetragem(id idImovel){
        imovel__c imovel = buscaporIDSOQL(idImovel);
        return (imovel.Valorbase__c / imovel.Metragem__c);
    
        }
       public static imovel__c buscaporIDSOQL( id thisID){
            return[ SELECT
             id,
             name
             FROM
             imovel__c
             WHERE
             id = : thisID
             ];
             }*/
         

    public static list <imovel__c> buscaUmMilhao(){
        return[
        SELECT 
            Name,
            RecordType.name,
            Valorbase__c
            FROM
            imovel__c
        WHERE
            Valorbase__c > 1000000
        ];
    }

    public static list <AggregateResult> listaStatus(){
        return[
            SELECT 
            Status__c,  
            COUNT(Id) quantidade 
            FROM Imovel__c 
            WHERE
            Status__c = 'vendido'
            GROUP BY Status__c  
        ];
    }
    
    public static list <AggregateResult> sumVlor(){
        return[
            SELECT 
            SUM(Valorbase__c)
            FROM
            imovel__c
        ];
    }
 
}



