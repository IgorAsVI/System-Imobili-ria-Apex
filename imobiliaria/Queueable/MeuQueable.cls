public with sharing class MeuQueable implements Queueable {
   
   private list<Case> listCases = new list<Case>();
   list<Account> Acc = new list<Account>();
   public MeuQueable(list<case> cases) {
       this.listCases = cases;
   }
   public void execute(QueueableContext context){
    
    for(Case cas : listcases){
      Contact Con = new Contact();
      con.AccountId = cas.AccountId;
        }
        System.enqueueJob(new SegundoQueueable(Acc));
    }
}
