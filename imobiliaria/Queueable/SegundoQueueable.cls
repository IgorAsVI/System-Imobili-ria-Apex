public with sharing class SegundoQueueable implements Queueable {
    private list<Account> listAccounts = new list<Account>();
    public SegundoQueueable(list<Account> Accounts) {
        this.listAccounts = Accounts;
    }
    public void execute(QueueableContext context){
        for(Account a : listAccounts){
            Case c = new CAse();
            c.AccountId = a.id;
        }
    }
}
