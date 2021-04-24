
component{

	function appeal(string name, string usernum){

		local.appeals=[];
	     
	    myQry=new Query();

	    myQry.setDatasource(name);
	    myQry.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
	    myQry.setSQL("select id, applicant, assigner, amount, assigned FROM appeal INNER JOIN users_appeal ON appeal.id=users_appeal.appealid WHERE users_appeal.userid=:usernum");
	    
	  
	    for(i=1; i LTE myQry.execute().getResult().recordcount; i=i+1){
	        
	        local.appeal={};
	        
	        local.appeal.appeal_id=myQry.execute().getResult().id[i];
	        local.appeal.appeal_applicant=myQry.execute().getResult().applicant[i];
	        local.appeal.appeal_assigner=myQry.execute().getResult().assigner[i];
	        local.appeal.amount=myQry.execute().getResult().amount[i];
	        local.appeal.appeal_assigned=DateFormat(myQry.execute().getResult().assigned[i],"long");
	                 
	        arrayAppend(local.appeals, local.appeal);
	    }
	    
	    return local.appeals;
	    
	}

	function appeal_add(string name,string usernum,string applicant,string assigner,string amount,string appealdate){

        local.status={};
       
        var arrayDate=listToArray(appealdate,"-");
        var dateadded=createDate(arrayDate[1],arrayDate[2],arrayDate[3]);

        transaction{

            try{
                
                myQry1=new Query();
                myQry1.setDatasource(name);
                myQry1.addParam(name="applicant", value="#applicant#", cfsqltype="CF_SQL_VARCHAR");
                myQry1.addParam(name="assigner", value="#assigner#", cfsqltype="CF_SQL_VARCHAR");
                myQry1.addParam(name="amount", value="#Val(amount)#", cfsqltype="CF_SQL_NUMERIC");
                myQry1.addParam(name="dateadded", value="#DateFormat(dateadded,'YYYY-MM-DD')#", cfsqltype="CF_SQL_DATE");
                myQry1.setSQL("INSERT INTO appeal (applicant,assigner,amount,assigned) VALUES (:applicant,:assigner,:amount,:dateadded)");
                //myQry1.execute();
               
                transaction action="commit";

                var appeal_added=myQry1.execute().getPrefix().generatedkey;
                
                myQry2=new Query();
                myQry2.setDatasource(name);
                myQry2.addParam(name="appeal_added", value="#appeal_added#", cfsqltype="CF_SQL_INTEGER");
                myQry2.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
                myQry2.setSQL("INSERT INTO users_appeal (appealid,userid) VALUES (:appeal_added,:usernum)");
                myQry2.execute();
              
                local.status.success=1;

            }catch(any e){
                
                local.status.msg=e.Message;
                local.status.error=1;
                transaction action="rollback"; 
                
             }
        }

    return local.status;

    }

    function appeal_view(string name, string appealid){

        local.appeal={};
         
        myQry=new Query();

        myQry.setDatasource(name);
        myQry.addParam(name="appealid", value="#Val(appealid)#", cfsqltype="CF_SQL_INTEGER");
        myQry.setSQL("select id, applicant, assigner, amount, assigned FROM appeal WHERE id=:appealid");
        
        if (myQry.execute().getResult().recordcount EQ 1){
                    
            local.appeal.success=1;
            local.appeal.appeal_id=myQry.execute().getResult().id[1];
            local.appeal.appeal_applicant=myQry.execute().getResult().applicant[1];
            local.appeal.appeal_assigner=myQry.execute().getResult().assigner[1];
            local.appeal.appeal_amount=myQry.execute().getResult().amount[1];
            local.appeal.date_assigned=DateFormat(myQry.execute().getResult().assigned[1],"yyyy-MM-dd");

        }
        
        else{

            local.appeal.error=1;
            local.appeal.error_msg="No data available";
        }
      
        return local.appeal;
    }

    function appeal_searchbar(string name, string usernum, string searchtoken){

        local.appeals=[];
         
        myQry=new Query();

        myQry.setDatasource(name);
        myQry.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
        myQry.addParam(name="searchtoken", value="%#Trim(searchtoken)#%", cfsqltype="CF_SQL_VARCHAR");
        myQry.setSQL("select id, applicant, assigner, amount, assigned FROM appeal INNER JOIN users_appeal ON appeal.id=users_appeal.appealid WHERE users_appeal.userid=:usernum AND (applicant LIKE :searchtoken OR assigner LIKE :searchtoken)");
        
      
        for(i=1; i LTE myQry.execute().getResult().recordcount; i=i+1){
            
            local.appeal={};
	        
	        local.appeal.appeal_id=myQry.execute().getResult().id[i];
	        local.appeal.appeal_applicant=myQry.execute().getResult().applicant[i];
	        local.appeal.appeal_assigner=myQry.execute().getResult().assigner[i];
	        local.appeal.amount=myQry.execute().getResult().amount[i];
	        local.appeal.appeal_assigned=DateFormat(myQry.execute().getResult().assigned[i],"long");
	                            
            arrayAppend(local.appeals, local.appeal);
        }
        
        return local.appeals;
    }

    function appeal_put(string name,string applicant,string assigner,string amount,string appealdate,string appealid){

        local.appeal={};

        var arrayDate=listToArray(appealdate,"-");
        var dateadded=createDate(arrayDate[1],arrayDate[2],arrayDate[3]);
         
        try{

            myQry=new Query();

            myQry.setDatasource(name);
            myQry.addParam(name="applicant", value="#applicant#", cfsqltype="CF_SQL_VARCHAR");
            myQry.addParam(name="assigner", value="#assigner#", cfsqltype="CF_SQL_VARCHAR");
            myQry.addParam(name="amount", value="#Val(amount)#", cfsqltype="CF_SQL_NUMERIC");
            myQry.addParam(name="dateadded", value="#DateFormat(dateadded,'YYYY-MM-DD')#", cfsqltype="CF_SQL_DATE");
            myQry.addParam(name="appealid", value="#Val(appealid)#", cfsqltype="CF_SQL_INTEGER");
            myQry.setSQL("UPDATE appeal SET applicant=:applicant, assigner=:assigner, amount=:amount, assigned=:dateadded  WHERE id=:appealid");
            myQry.execute();

            local.appeal.success=1;

        }catch(any e){

            local.appeal.error=1;
            local.appeal.error_msg=e.Message;
        }
      
        return local.appeal;
    }


    function appeal_remove(string name,string usernum,string appealid){

        local.status={};

        transaction{

            try{
                
                myQry1=new Query();
                myQry1.setDatasource(name);
                myQry1.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
                myQry1.addParam(name="appealid", value="#Val(appealid)#", cfsqltype="CF_SQL_INTEGER");
                myQry1.setSQL("DELETE FROM users_appeal where userid=:usernum and appealid=:appealid");
                myQry1.execute();

                                        
                myQry2=new Query();
                myQry2.setDatasource(name);
                myQry2.addParam(name="appealid", value="#Val(appealid)#", cfsqltype="CF_SQL_INTEGER");
                myQry2.setSQL("DELETE FROM appeal where id=:appealid");
                myQry2.execute();
               
                transaction action="commit";                
                local.status.success=1;

            }catch(any e){
                
                local.status.msg=e.Message;
                local.status.error=1;
                transaction action="rollback"; 
                
             }
        }

    return local.status;

    }


}