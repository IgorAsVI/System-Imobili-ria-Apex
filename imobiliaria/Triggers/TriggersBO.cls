public with sharing class TriggersBO {
    public static void validaAccPorCNPJ(list<Account> listNew){
    //set<Account> setAccNew = new set<Account>();
    list<Account> allAcc = [SELECT id,name, CNPJ__c FROM Account];
    for(Account a : listNew){
        for (Account a2: allAcc){
            if(a.CNPJ__c == a2.CNPJ__c){
                a.addError('CNPJ já cadastrado');
                }
            }
        }
    }
}

    

