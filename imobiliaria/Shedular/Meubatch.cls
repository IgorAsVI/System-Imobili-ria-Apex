public  class Meubatch implements Database.Batchable<Sobject> {
   
    public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([SELECT id,name FROM Opportunity WHERE CloseDAte = LAST_N_MONTHS:3 AND IsClosed = False ]);
    }

    public void execute(Database.BatchableContext BC, list<Opportunity> opp){
        For(Opportunity op: opp){
            op.CloseDAte = system.today();
        }
    }

    public void finish(Database.BatchableContext BC){
        system.debug('Registros deletados');

}
}

