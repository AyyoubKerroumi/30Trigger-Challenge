trigger changeShippingAddress on Account (before insert) {
    for(Account account : Trigger.new){
        if(account.BillingStreet != null){
            account.ShippingStreet = account.BillingStreet;
        }
        if(account.BillingCity != null){
            account.ShippingCity = account.BillingCity;
        }
        if(account.BillingState != null){
            account.BillingState = account.BillingState;
        }
        if(account.BillingPostalCode != null){
            account.ShippingPostalCode = account.BillingPostalCode;
        }
        if(account.BillingCountry != null){
            account.ShippingCountry = account.BillingCountry;
        }
    }
}