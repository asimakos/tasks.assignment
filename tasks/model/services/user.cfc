
component {
    
    function login(string name,string username,string password) {
       
        local.status={};
    	myQry=new Query();

    	myQry.setDatasource(name);
    	myQry.addParam(name="username", value="#username#", cfsqltype="CF_SQL_VARCHAR");
    	myQry.setSQL("select * FROM users where username=:username and active=1");
    	//myQry.execute().getResult();
        //myQry.execute().getResult().recordcount EQ 1

        var encypted_text=myQry.execute().getResult().password[1];
        var decrypted_text=decrypt(encypted_text,'WTq8zYcZfaWVvMncigHqwQ==','AES','Base64');
        
        if  ((compare(decrypted_text,password) EQ 0) AND (myQry.execute().getResult().recordcount EQ 1)){
                        
            local.status.success=1;
            local.status.userid=myQry.execute().getResult().id[1];
            local.status.username=myQry.execute().getResult().username[1];
            
        }
        else{

        	local.status.error=1;
        	local.status.error_msg="No data available";
        }
        
       return local.status;
    }

    function check(string datasource,string username,string password,string name,string email) {
       
        local.status={};
        var activation_code=createUUID();

        myQry=new Query();

        myQry.setDatasource(datasource);
        myQry.addParam(name="username", value="#username#", cfsqltype="CF_SQL_VARCHAR");
        myQry.setSQL("select * FROM users where username=:username");
        //myQry.execute().getResult();
        
        if (myQry.execute().getResult().recordcount GTE 1){
            
            local.status.error=1;
            local.status.error_msg="Same username already exists!";            
           
        }else{
            
            user_add(datasource,username,password,name,email,activation_code);
            send_email(email,activation_code); 
            local.status.success=1; 
        }
                
       return local.status;
    }

    function send_email(string email,string activation){


        savecontent variable="mailbody"{
           
            writeOutput("Προκειμένου να ενεργοποιήσετε τον λογαριασμό σας,"); 
            writeOutput("παρακαλώ επισκεφτείτε τον παρακάτω σύνδεσμο:");
            writeOutput("http://127.0.0.1:49820/index.cfm/main/activate/" & activation);

        };

        mailService=new mail(
            to=email,
            from="xxxxxxx@otenet.gr",
            subject="Ενεργοποίηση λογαριασμού",
            body=mailbody,
            server="mailgate.otenet.gr",
            port="587",
            username="XXXXXX",
            password="XXXXXXX",
            charset="utf-8");

        mailService.send();
    }

     function user_add(string datasource,string username,string password,string name,string email,string activation){

        myQry=new Query();
        myQry.setDatasource(datasource);
        myQry.addParam(name="username", value="#username#", cfsqltype="CF_SQL_VARCHAR");
        myQry.addParam(name="password", value="#encrypt(password,'WTq8zYcZfaWVvMncigHqwQ==','AES','Base64')#", cfsqltype="CF_SQL_VARCHAR");
        myQry.addParam(name="name", value="#name#", cfsqltype="CF_SQL_VARCHAR");
        myQry.addParam(name="email", value="#email#", cfsqltype="CF_SQL_VARCHAR");
         myQry.addParam(name="activation", value="#activation#", cfsqltype="CF_SQL_VARCHAR");
        myQry.setSQL("INSERT INTO users (username,password,name,email,activation) VALUES (:username,:password,:name,:email,:activation)");
        myQry.execute();

   }

    function user_activate(string name,string code){

        local.activation={};

        try{

            myQry=new Query();

            myQry.setDatasource(name);
            myQry.addParam(name="code", value="#code#", cfsqltype="CF_SQL_VARCHAR");
            myQry.setSQL("UPDATE users SET active=1  WHERE activation=:code");
            myQry.execute();

            local.activation.success=1;

            }catch(any e){

                local.activation.error=1;
                local.activation.error_msg=e.Message;
            }

           return local.activation;
    }


}