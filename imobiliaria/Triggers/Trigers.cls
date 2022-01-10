public with sharing class Trigers {
    public static void criacomissao(list<PropostaDeCompra__c> listProposta, map <id, PropostaDeCompra__c> mapPropostaOld){
list<PropostaDeCompra__c> listProcessada = new list<PropostaDeCompra__c>();
mapPropostaOld  = mapPropostaOld == null ? new map<id, PropostaDeCompra__c>() : mapPropostaOld;


for (PropostaDeCompra__c proposta : listProposta){
    PropostaDeCompra__c propostaOld;

    propostaOld = mapPropostaOld.get(proposta.id);

    if (propostaOld != null && proposta.status__c != propostaOld.status__c && proposta.status__c != 'Paga' ){

        continue;
    }

    listProcessada.add(proposta);
}
criacomissao(listProcessada);
    }

public static void criacomissao(list<PropostaDeCompra__c > listproposta){

    list<Comicao__c> listComissao = new list<Comicao__c>();
    for(PropostaDeCompra__c p : listProposta){
        comicao__c comissao = new comicao__c();
        comissao.Proposta_de_compra__c = p.id;
        comissao.Valor__c = p.Moeda__c ;
        comissao.status__c = 'Em pagamento';
        listComissao.add(comissao);
    }
    insert listComissao;
}
 
public static void reservadoEnviada(list<PropostaDeCompra__c> listaProposta, map<id,PropostaDeCompra__c> oldMapProposta){
    list<PropostaDeCompra__c> listaPropostas = new list<PropostaDeCompra__c>();
    OldmapProposta  = OldmapProposta == null ? new map<id, PropostaDeCompra__c>() : OldmapProposta;
    for ( PropostaDeCompra__c proposta : listaProposta){
       PropostaDeCompra__c propostaOld = oldMapProposta.get(proposta.id);
        if(propostaOld != null && proposta.status__c == 'Aguardando pagamento' && proposta.status__c != propostaOld.status__c ){
            listaPropostas.add(proposta);
            }
        }
        reservadoEnviada(listaPropostas);
    }
public static void reservadoEnviada(list<PropostaDeCompra__c> listaProposta){
    list<imovel__c> listImoveis = new list<imovel__C>();
    for(PropostaDeCompra__c proposta : listaProposta){
        imovel__c imovel = new imovel__c ();
        imovel.id = proposta.imovel__c;
        imovel.status__c = 'Reservado';
        listImoveis.add(imovel);
}
     upsert listImoveis;
}
public static void finalizadoVendido(list<PropostaDeCompra__c> listaProposta, map<id,PropostaDeCompra__c> oldMapProposta){
    list<PropostaDeCompra__c> listProcessada = new list<PropostaDeCompra__c>();
    OldmapProposta  = OldmapProposta == null ? new map<id, PropostaDeCompra__c>() : OldmapProposta;
    for ( PropostaDeCompra__c proposta : listaProposta){
       PropostaDeCompra__c propostaOld = oldMapProposta.get(proposta.id);
       

        if(propostaOld != null && proposta.status__c == 'Finalizada' && proposta.status__c != propostaOld.status__c ){
            listProcessada.add(proposta);
            }
        }
        finalizadoVendido(listProcessada);
    }
    public static void finalizadoVendido(list<PropostaDeCompra__c> listaProposta){
        list<imovel__c> listImoveis = new list<imovel__C>();
        for(PropostaDeCompra__c proposta : listaProposta){
            imovel__c imovel = new imovel__c ();
            imovel.id = proposta.imovel__c;
            imovel.status__c = 'Vendido';
            listImoveis.add(imovel);
        }
         upsert listImoveis;
    }


    public static void bloqueiaProposta(list<PropostaDeCompra__c> listaProposta){
     list<imovel__c> imoveis = [SELECT id, name FROM imovel__c WHERE status__c = 'Vendido'];

     for(PropostaDeCompra__c proposta : listaProposta){
         for (imovel__c imovel : imoveis){
             if(proposta.imovel__c == imovel.id){
                 proposta.addError('Imovel já vendido');
                }
            }
        }
    }
    
    
    public static void enviaEmail (list<Comicao__c> comissoes){
      list <Messaging.SingleEmailMessage> listMail = new list <Messaging.SingleEmailMessage>();
      list<PropostaDeCompra__c> listaProposta = [SELECT id,User__c FROM PropostaDeCompra__c];//Usser__c seria meu vendedor
        for(Comicao__c comissao : comissoes){
            for(PropostaDeCompra__c proposta : listaProposta) {
                if(proposta.id == comissao.Proposta_de_compra__c){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(proposta.User__c);
            mail.setSubject('Comissão criada em seu nome');
            mail.setPlainTextBody( 'Status==> ' + comissao.status__c + '   Valor = R$ ' + comissao.Valor__c + '   Nome ==> ' + comissao.id );
            listMail.add(mail);
            mail.saveAsActivity = false;
                }
            }
        }
        if(!listMail.isEmpty()){ 
                messaging.sendEmail(listMail);
        }
    }
}
 



