trigger totalAmountofRelatedOpp on Account (before update) {
    Set<Id> accountIds = new Set<Id>();
    for(account a : Trigger.new){
        accountIds.add(a.Id);
        a.Total_Opportunity_Amount__c = 0;
    }
    Map<Id,Double> amountMap = new Map<Id,Double>();
    List<AggregateResult> result = new List<AggregateResult>();
    results = [Select AccountId,sum(Amount)TotalAmount from Opportunity where AccountId In :accountIds group by AccountId];
    if(result.size()>0){
        for(AggregateResult a : result){
            Id accountId = (Id)a.get('AccountId');
            double TotalAmount = (double)a.get('TotalAmount');
            amountMap.put(accountId,TotalAmount);
        }
    }
    for(Account a : Trigger.new){
        if(amountMap.containsKey(a.Id)){
            a.Total_Opportunity_Amount__c=amountMap.get(acc.Id);
        }
    }
}