public with sharing class Repeticoes {
public class idInexistenteException extends Exception{}
public class listaVaziaException extends Exception{}
public class valorDaPropostaInvalidoException extends Exception{}
public class percentualComicaoException extends Exception{}

    

// Métodos de busca auxiliares
public static list<id> getIdImovelProposta(){
    list< PropostaDeCompra__c> propostas = [SELECT  imovel__c FROM PropostaDeCompra__c ];
    list<id> ids = new list<id> (); 
    for(PropostaDeCompra__c p : propostas){
        ids.add(p.imovel__c);
    }
    return ids;
    }

public static list<id> getImoveisID(){

list< imovel__c> imoveis = [SELECT  id FROM imovel__c];
list<id> ids = new list<id> (); 
for(imovel__c p : imoveis){
    ids.add(p.id);
}
return ids;
}

public static list<id> getIdProposta(){

list< PropostaDeCompra__c> propostas = [ SELECT Id FROM PropostaDeCompra__c];
list<id> ids = new list<id> (); 
for(PropostaDeCompra__c p : propostas){
    ids.add(p.id);
}
return ids;
}


 // Métodos que criam resgistos de comissões baseado na quantidade de Usuários numa lista e numa propósta de compra( acaba na linha 52)
    public static void criarComissoes(id thisID, list<id> Usuarios){
   try{ 
    PropostaDeCompra__c proposta = [SELECT Id,User__c,Moeda__c FROM PropostaDeCompra__c WHERE id = :thisID];
    Comicao__c comicao = new Comicao__c();
    List<id> idPropostas =getIdProposta();
    comicao.Proposta_de_compra__c = thisID;
    list<Comicao__C> listaDeComicoes = new list<comicao__c>();
    
        if(idPropostas.contains(comicao.Proposta_de_compra__c)){
        system.debug('teste');
        for(id vendedor : Usuarios){
            comicao.Proposta_de_compra__c = thisID;
            comicao.Valor__c = proposta.Moeda__c / Usuarios.size() ; 
            comicao.OwnerId = vendedor;
            system.debug('adicionado');
            listaDeComicoes.add(comicao);
            comicao = new Comicao__C();
        }
        }else {
            throw new idInexistenteException('ID não encontrado');
        }
        
        if(Usuarios.isEmpty()){
            throw new listaVaziaException('Lista de Usuários escolhida está vazia');
        }
        
        if(proposta.Moeda__c < 0 ){
            throw new valorDaPropostaInvalidoException('Valor da propósta inválido');
        }
        insert listaDeComicoes;
    }
    catch (idInexistenteException e){
            System.debug('Error Mensage => ' + e.getMessage());
    }catch (listaVaziaException e){
            System.debug('Error Mensage => ' + e.getMessage());
    }catch (valorDaPropostaInvalidoException e){
            System.debug('Error Mensage => ' + e.getMessage());
    }
    
    }// (Fim do método de comissão)




// Método de verificar itens de duas listas (acaba na linha 85)
public static integer comparaListas (list <string> lista1, list<string> lista2){
list <string> list1 = lista1;
list <string> list2 = lista2;
integer itensComuns;
try{
for(string item:lista1){
    if(lista2.contains (item)){
    itensComuns++;
    }

}

if(list1.isEmpty()){
throw new listaVaziaException ('Primeira lista vazia');
}
if (list2.isEmpty()){
    throw new listaVaziaException ('Segunda lista vazia');
    }

}catch(listaVaziaException e){
    System.debug('Error Mensage => ' + e.getMessage());
}

return itensComuns;


}
// Fim do método de verificar itens de duas listas   


public static map<id,integer> mapaQuantidadePropostasPorID(){
map<id,integer> m1 = new map<id,integer>() ; 
list<id> imoveis = getImoveisID();
list<id> imoveisIDProposta = getIdImovelProposta();
integer quantidade = 0;
    for(id idImovel : imoveis){
        for(id imovelProposta : imoveisIDProposta){
            if (idImovel == imovelProposta){
                quantidade ++;
        }
            m1.put(idImovel,quantidade) ; 
    }
    quantidade = 0;
}
system.debug(m1);
return m1;
}
public static map<id,list<PropostaDeCompra__c>> mapaPropostasPorID(){
    map<id,list<PropostaDeCompra__c>> m1 = new map<id,list<PropostaDeCompra__c>>() ; 
    list<id> imoveis = getImoveisID();
   
    list<PropostaDeCompra__c> listaPropostas = [SELECT  name, imovel__c FROM PropostaDeCompra__c ];
    list<PropostaDeCompra__c> Recebe = new list<PropostaDeCompra__c>();
    for(id idImovel : imoveis){
        for(PropostaDeCompra__c  proposta : listaPropostas){
            if (idImovel == proposta.imovel__c){//Só percebi que eu podia fazer isso de comparar com o campo 
               recebe.add(proposta);            //no lugar de ter que séparar os ids em listas diferentes...
            }                                   //nunca mais esqueço,tantos métodos em vão...
                m1.put(idImovel,recebe) ; 
    }
        recebe = new list<PropostaDeCompra__c>();
    }
    system.debug(m1.toString());
    return m1;
    }

public static void insertComissao(id user, id proposta, Decimal ValorComicao){
  try{ 
    PropostaDeCompra__c propostas = [SELECT Moeda__c FROM PropostaDeCompra__c WHERE id =: proposta ];
    Comicao__c comicao = new Comicao__c();
    comicao.OwnerId = user;
    comicao.Proposta_de_compra__c = proposta;
    comicao.Valor__c = ValorComicao;
  
if(comicao.Valor__c > 0.7 * propostas.Moeda__c){
throw new percentualComicaoException ('Valor da comoção excede o valor permitido');
}
}catch (percentualComicaoException e){
    System.debug('Error Mensage => ' + e.getMessage());
}
}
}







 
   
   
   
   
   
   
   
   
    
    
   

    



