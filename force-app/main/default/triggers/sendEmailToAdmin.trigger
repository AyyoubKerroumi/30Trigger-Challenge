trigger sendEmailToAdmin on Account (after insert) {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    User userObj = [SELECT Id,Email,Profile.Name from User where Profile.Name = 'System Administrator'];
    for(Account a : Trigger.new){
        if(userObj.Email!=null){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSenderDisplayName('Salesforce');
            mail.setUseSignature(false);
            mail.setBccSender(false);
            mail.setSaveAsActivity(false);
            mail.toAddresses = new String[]{userObj.Email};
            mail.setSubject('New Account was Created.');
            String body = 'Dear System Administrator, <br/>';
            body += 'An account has been created and name is '+a.Name+'.';
            //Assigning the variable in which we wrote the body to the Mail Body
            mail.setHtmlBody(body);
            mails.add(mail);
        }
    }
    if(mails.size() > 0 ){
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        if (results[0].success)
        {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '+ results[0].errors[0].message);
        }
    }
}