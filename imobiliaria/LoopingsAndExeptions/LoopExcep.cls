public with sharing class LoopExcep {
    public static list <imovel__c> buscImovelID( id thisID){
        return[ SELECT
         id,
         name,
         Valorbase__c,
         RecordType.name
         FROM
         imovel__c
         WHERE
         id = :thisID
         ];
         }

        
     public static list < Contact > buscContatoID( id thisID){
        return[ SELECT
         id,
         name
         FROM
         Contact
         WHERE
         id = :thisID
             ];
             }
    public static User buscUserID( id thisID){
        return[ SELECT
             id,
             name
             FROM
             User
             WHERE
             id = :thisID
                 ];
                 }

    public static Decimal retornaValorAumentadoPorRecordType(id thisid){
             list   <imovel__c> listimoveltip = buscImovelID(thisid);
             imovel__c imoveltip = listimoveltip[0];
                decimal result;
                if (imoveltip.RecordType.name =='Apartamento') {
                    result =  imoveltip.Valorbase__c = imoveltip.Valorbase__c * 1.04;
                    
                }else {
                    result =  imoveltip.Valorbase__c = imoveltip.Valorbase__c * 1.02;
                    
                }
                update imoveltip;
                return result;

  }

public static PropostaDeCompra__c criaProposta (id imovelID, id userID, id contatoID,Decimal valor, integer ano,integer mes, integer dia){
    PropostaDeCompra__c proposta = new PropostaDeCompra__c();
try{

list <imovel__c> lista = buscImovelID(imovelID);
list <Contact> contato = buscContatoID(contatoID);
User vendedor = buscUserID(userID);
date hoje = date.Today();
lista[0].status__c = 'Disponível';
proposta.imovel__c = lista[0].id;
proposta.Contact__c = contato[0].id; 
proposta.User__C = vendedor.id;
proposta.Data__c = date.newInstance(mes,dia,ano);
proposta.Moeda__c = valor;


if(lista[0].Status__C == ('Reservado' ) || lista[0].Status__C == ('Vendido')){
    
    throw new statusException('Imovel Reservado ou Vendido');

}else if (proposta.Data__c < hoje){
    
    throw new dateException ('Data da proposta Inválida');
    
}else if(proposta.Moeda__c< 0 ){
    throw new valorException('Valor da propósta inválido');
    
}else{




insert proposta;
}

}catch(statusException e) {
    system.System.debug('Error Mensage => ' + e.getMessage());
}catch(dateException e) {
    system.System.debug('Error Mensage => ' + e.getMessage());
}catch(valorException e) {
    system.System.debug('Error Mensage => ' + e.getMessage());
}









 
return proposta;


}
 

public class statusException extends Exception {}
public class dateException extends Exception {}
public class valorException extends Exception {}


}

    


