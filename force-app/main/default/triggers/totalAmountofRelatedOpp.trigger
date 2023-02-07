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























trigger totalAmountofRelatedOpp on Account(before update){
    Set<Id> accountIds = new Set<Id>();
    for(Account account : Trigger.new){
        accountIds.add(account.Id);
        account.Total_Opportunity_Amount__c = 0;
    }
    Map<Id,Double> mapAmounts = new Map<Id,Decimal>();
    List<AggregateResult> result = new List<AggregateResult>();
    result = [Select AccountId,sum(Amount) from Opportunity where AccountId In :accountIds group by AccountId];
    for(AggregateResult res : result){
        Id accountId = (Id)res.get('AccountId');
        double totalAmount = (double)res.get('TotalAmount');
        mapAmounts.put(accountId,totalAmount);
    }
    for(Account a : Trigger.new){
        if(mapAmounts.containsKey(a.accountId)){
            a.Total_Opportunity_Amount__c = mapAmounts.get(a.accountId);
        }
    }
}