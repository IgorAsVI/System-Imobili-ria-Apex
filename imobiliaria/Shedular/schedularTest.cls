global class schedularTest implements schedulable  {
    global static void agendar(){
        String jobId = system.schedule('Fechamento automatico de oportunidade', '0 0 17 * * ?',new schedularTest());    
        }

    global void execute(schedulableContext context){
        Database.executeBatch(new Meubatch(), 50);
        }
}
