// Atividade 1
public with sharing class TriggersBO {
    public static void validaAccPorCNPJ(list<Account> listNew){
    set<Decimal> setCnpjs = new set<Decimal>();
    list <Decimal> AllCnpjs = new list<Decimal>();
    for (Account a :listNew){
        setCnpjs.add(a.CNPJ__c);
    }
    list<Account> oldlist = [SELECT id,CNPJ__c FROM Account WHERE CNPJ__C in : setCnpjs];
    for( Account a : oldlist){
        AllCnpjs.add(a.CNPJ__c);
        }
    for(Account a : listNew){
        if(AllCnpjs.contains(a.CNPJ__c) && a.CNPJ__c != null){
            a.addError('CNPJ já cadastrado'); 
            }
        }   
    }
    // Atividade 2
    public static void contatoRh (list<Contact> listNew){
        list<Account> AccUpdate = new list<Account>();
        list<id> contatosIdTest = new list<id>();
        for(Contact c : listNew){
            if (c.Department =='RH' && c.Description.containsIgnoreCase('RH')){
                    contatosIdTest.add(c.id);
                }
            }
        list<Contact> listContacts =[SELECT id,FirstName,AccountId FROM Contact WHERE id IN : contatosIdTest ] ;
        for(Contact c: listNew ){
            Account acc = new Account();
            acc.id = c.AccountId;
            acc.RHManagerName__c = c.FirstName;  
            acc.RHManagerCheck__c = true;
            AccUpdate.add(acc);
        }
       if(AccUpdate != null){ upsert AccUpdate;}
    }
   // Atividade 3
    public static void atribuiNewAccInOpp(list<Account> newacc){
        list <Opportunity> listespecifica = [SELECT name,StageName,Amount FROM opportunity WHERE (StageName ='Closed Lost' OR StageName ='Closed Won') AND Amount > 1000];
        list<opportunity> updateList = new list<opportunity>(); 
        for(Opportunity o : listespecifica){
            o.AccountId = newacc[0].id;
            updateList.add(o);
        }
        upsert updatelist;
}
  //Atividade 4
public static void VerificaLead(list<Lead> newlist,map<id,lead> oldmap){
    List<Lead> listaProcessada= new list<lead>();
    oldmap = oldmap == null ? new map<id, lead>() : oldmap;
    for (lead leadNew : newList){
        lead leadOld;
        leadold = oldmap.get(leadNew.id);
        if(leadold != null && leadold.Cnpj__c != leadNew.Cnpj__c ){
            listaProcessada.add(leadNew);
        }
    }
    VerificaLead(listaProcessada);
}

public static void VerificaLead(list<lead> newLeads){
    list<lead> leadsGerais = [SELECT id,Cnpj__c FROM lead ];
    list<Decimal> guardaCnjps = new list<Decimal>();
    list<Opportunity> listopp = new list<Opportunity>();
    for(lead leads : leadsGerais){
        guardaCnjps.add(leads.Cnpj__c);
        }
    for(lead leads : newLeads){
        if (guardaCnjps.contains(leads.Cnpj__c)){
            leads.ClienteJaExiste__c = true;
            opportunity opp = new opportunity();
            opp.Name = 'lead :' + leads.Name ;
            opp.StageName = 'Prospecting';
            opp.closeDate = date.today();
            listopp.add(opp);
            }else{
                leads.addError('Não é possivel atualizar esse lead pois não existe nenum outro lead com esse CNPJ');
            }
        }
        upsert listopp;
    }

   

}


    







