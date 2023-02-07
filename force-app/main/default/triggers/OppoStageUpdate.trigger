trigger OppoStageUpdate on Account (after update) {
    Set<Id> accountIds = new Set<Id>();
    for(Account a : Trigger.new){
        accountIds.add(a.Id);
    }
    DateTime d = System.now() - 30;
    List<Opportunity> opps = [SELECT Id,AccountId,StageName,CreatedDate,CloseDate from Opportunity where AccountId IN :accountIds AND StageName != 'Closed Won' AND CreatedDate<:d];
    if(opps.size()>0){
        for(Opportunity o : opps){
            o.StageName = 'Closed Lost';
            o.closeDate = System.today();
        }
        update opps;
    }
}