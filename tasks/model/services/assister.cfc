
component{

	function assist(string name, string usernum){

		local.assistances=[];
         
        myQry=new Query();

        myQry.setDatasource(name);
        myQry.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
        myQry.setSQL("select id, title, assigned FROM assist INNER JOIN users_assist ON assist.id=users_assist.assistid WHERE users_assist.userid=:usernum");
        
      
        for(i=1; i LTE myQry.execute().getResult().recordcount; i=i+1){
            
            local.assistance={};
            
            local.assistance.assist_id=myQry.execute().getResult().id[i];
            local.assistance.assist_title=myQry.execute().getResult().title[i];
            local.assistance.assist_assigned=DateFormat(myQry.execute().getResult().assigned[i],"long");
         
            
            arrayAppend(local.assistances, local.assistance);
        }
        
        return local.assistances;
        
    }

    function assist_add(string name,string usernum,string assistname,string assistdate){

        local.status={};
       
        var arrayDate=listToArray(assistdate,"-");
        var dateadded=createDate(arrayDate[1],arrayDate[2],arrayDate[3]);

        transaction{

            try{
                
                myQry1=new Query();
                myQry1.setDatasource(name);
                myQry1.addParam(name="assistname", value="#assistname#", cfsqltype="CF_SQL_LONGVARCHAR");
                myQry1.addParam(name="dateadded", value="#DateFormat(dateadded,'YYYY-MM-DD')#", cfsqltype="CF_SQL_DATE");
                myQry1.setSQL("INSERT INTO assist (title,assigned) VALUES (:assistname,:dateadded)");
                //myQry1.execute();
               
                transaction action="commit";

                var assist_added=myQry1.execute().getPrefix().generatedkey;
                
                myQry2=new Query();
                myQry2.setDatasource(name);
                myQry2.addParam(name="assist_added", value="#assist_added#", cfsqltype="CF_SQL_INTEGER");
                myQry2.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
                myQry2.setSQL("INSERT INTO users_assist (assistid,userid) VALUES (:assist_added,:usernum)");
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

   function assist_view(string name, string assistid){

        local.assistance={};
         
        myQry=new Query();

        myQry.setDatasource(name);
        myQry.addParam(name="assistid", value="#Val(assistid)#", cfsqltype="CF_SQL_INTEGER");
        myQry.setSQL("select id, title, assigned FROM assist WHERE id=:assistid");
        
        if (myQry.execute().getResult().recordcount EQ 1){
                    
            local.assistance.success=1;
            local.assistance.assist_id=myQry.execute().getResult().id[1];
            local.assistance.assist_title=myQry.execute().getResult().title[1];
            local.assistance.date_assigned=DateFormat(myQry.execute().getResult().assigned[1],"yyyy-MM-dd");

        }
        
        else{

            local.assistance.error=1;
            local.assistance.error_msg="No data available";
        }
      
        return local.assistance;
    }

    function assist_searchbar(string name, string usernum, string searchtoken){

            local.assistances=[];
             
            myQry=new Query();

            myQry.setDatasource(name);
            myQry.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
            myQry.addParam(name="searchtoken", value="%#Trim(searchtoken)#%", cfsqltype="CF_SQL_VARCHAR");
            myQry.setSQL("select id, title, assigned FROM assist INNER JOIN users_assist ON assist.id=users_assist.assistid WHERE users_assist.userid=:usernum AND title LIKE :searchtoken");
            
          
            for(i=1; i LTE myQry.execute().getResult().recordcount; i=i+1){
                
                local.assistance={};
                
                local.assistance.assist_id=myQry.execute().getResult().id[i];
                local.assistance.assist_name=myQry.execute().getResult().title[i];
                local.assistance.date_assigned=DateFormat(myQry.execute().getResult().assigned[i],"long");
             
                
                arrayAppend(local.assistances, local.assistance);
            }
            
            return local.assistances;
        }

    function assist_put(string name,string assisttitle,string assistdate,string assistid){

        local.assistance={};

        var arrayDate=listToArray(assistdate,"-");
        var dateadded=createDate(arrayDate[1],arrayDate[2],arrayDate[3]);
         
        try{

            myQry=new Query();

            myQry.setDatasource(name);
            myQry.addParam(name="assisttitle", value="#assisttitle#", cfsqltype="CF_SQL_LONGVARCHAR");
            myQry.addParam(name="dateadded", value="#DateFormat(dateadded,'YYYY-MM-DD')#", cfsqltype="CF_SQL_DATE");
            myQry.addParam(name="assistid", value="#Val(assistid)#", cfsqltype="CF_SQL_INTEGER");
            myQry.setSQL("UPDATE assist SET title=:assisttitle, assigned=:dateadded  WHERE id=:assistid");
            myQry.execute();

            local.assistance.success=1;

        }catch(any e){

            local.assistance.error=1;
            local.assistance.error_msg=e.Message;
        }
      
        return local.assistance;
    }

    function assist_remove(string name,string usernum,string assistid){

        local.status={};

        transaction{

            try{
                
                myQry1=new Query();
                myQry1.setDatasource(name);
                myQry1.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
                myQry1.addParam(name="assistid", value="#Val(assistid)#", cfsqltype="CF_SQL_INTEGER");
                myQry1.setSQL("DELETE FROM users_assist where userid=:usernum and assistid=:assistid");
                myQry1.execute();

                                        
                myQry2=new Query();
                myQry2.setDatasource(name);
                myQry2.addParam(name="assistid", value="#Val(assistid)#", cfsqltype="CF_SQL_INTEGER");
                myQry2.setSQL("DELETE FROM assist where id=:assistid");
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