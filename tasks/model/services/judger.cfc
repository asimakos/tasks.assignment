
component {

	 function judge(string name, string usernum){

	        local.judgements=[];
	         
	        myQry=new Query();

	        myQry.setDatasource(name);
	        myQry.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
	        myQry.setSQL("select id, name, assigned FROM judge INNER JOIN users_judge ON judge.id=users_judge.judgeid WHERE users_judge.userid=:usernum");
	        
	      
	        for(i=1; i LTE myQry.execute().getResult().recordcount; i=i+1){
	            
	            local.judgement={};
	            
	            local.judgement.judge_id=myQry.execute().getResult().id[i];
	            local.judgement.judge_name=myQry.execute().getResult().name[i];
	            local.judgement.date_assigned=DateFormat(myQry.execute().getResult().assigned[i],"long");
	         
	            
	            arrayAppend(local.judgements, local.judgement);
	        }
	        
	        return local.judgements;
	    }

	function judge_searchbar(string name, string usernum, string searchtoken){

	        local.judgements=[];
	         
	        myQry=new Query();

	        myQry.setDatasource(name);
	        myQry.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
	        myQry.addParam(name="searchtoken", value="%#Trim(searchtoken)#%", cfsqltype="CF_SQL_VARCHAR");
	        myQry.setSQL("select id, name, assigned FROM judge INNER JOIN users_judge ON judge.id=users_judge.judgeid WHERE users_judge.userid=:usernum AND name LIKE :searchtoken");
	        
	      
	        for(i=1; i LTE myQry.execute().getResult().recordcount; i=i+1){
	            
	            local.judgement={};
	            
	            local.judgement.judge_id=myQry.execute().getResult().id[i];
	            local.judgement.judge_name=myQry.execute().getResult().name[i];
	            local.judgement.date_assigned=DateFormat(myQry.execute().getResult().assigned[i],"long");
	         
	            
	            arrayAppend(local.judgements, local.judgement);
	        }
	        
	        return local.judgements;
	    }

    function judge_add(string name,string usernum,string judgename,string judgedate){

	    local.status={};
	   
	    var arrayDate=listToArray(judgedate,"-");
	    var dateadded=createDate(arrayDate[1],arrayDate[2],arrayDate[3]);

	    transaction{

	        try{
	            
	            myQry1=new Query();
	            myQry1.setDatasource(name);
	            myQry1.addParam(name="judgename", value="#judgename#", cfsqltype="CF_SQL_VARCHAR");
	            myQry1.addParam(name="dateadded", value="#DateFormat(dateadded,'YYYY-MM-DD')#", cfsqltype="CF_SQL_DATE");
	            myQry1.setSQL("INSERT INTO judge (name,assigned) VALUES (:judgename,:dateadded)");
	            //myQry1.execute();
	           
	            transaction action="commit";

	            var judge_added=myQry1.execute().getPrefix().generatedkey;
	            
	            myQry2=new Query();
	            myQry2.setDatasource(name);
	            myQry2.addParam(name="judge_added", value="#judge_added#", cfsqltype="CF_SQL_INTEGER");
	            myQry2.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
	            myQry2.setSQL("INSERT INTO users_judge (judgeid,userid) VALUES (:judge_added,:usernum)");
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

	function judge_view(string name, string judgeid){

	        local.judgement={};
	         
	        myQry=new Query();

	        myQry.setDatasource(name);
	        myQry.addParam(name="judgeid", value="#Val(judgeid)#", cfsqltype="CF_SQL_INTEGER");
	        myQry.setSQL("select id, name, assigned FROM judge WHERE id=:judgeid");
	        
	        if (myQry.execute().getResult().recordcount EQ 1){
                        
	            local.judgement.success=1;
	            local.judgement.judge_id=myQry.execute().getResult().id[1];
	            local.judgement.judge_name=myQry.execute().getResult().name[1];
	            local.judgement.date_assigned=DateFormat(myQry.execute().getResult().assigned[1],"yyyy-MM-dd");

	        }
	        
	        else{

	        	local.judgement.error=1;
	        	local.judgement.error_msg="No data available";
	        }
	      
	        return local.judgement;
	    }

	function judge_put(string name,string judgename,string judgedate,string judgeid){

	        local.judgement={};

	        var arrayDate=listToArray(judgedate,"-");
	        var dateadded=createDate(arrayDate[1],arrayDate[2],arrayDate[3]);
	         
	        try{

		        myQry=new Query();

		        myQry.setDatasource(name);
		        myQry.addParam(name="judgename", value="#judgename#", cfsqltype="CF_SQL_VARCHAR");
		        myQry.addParam(name="dateadded", value="#DateFormat(dateadded,'YYYY-MM-DD')#", cfsqltype="CF_SQL_DATE");
		        myQry.addParam(name="judgeid", value="#Val(judgeid)#", cfsqltype="CF_SQL_INTEGER");
		        myQry.setSQL("UPDATE judge SET name=:judgename, assigned=:dateadded  WHERE id=:judgeid");
		        myQry.execute();

		        local.judgement.success=1;

	        }catch(any e){

	        	local.judgement.error=1;
	        	local.judgement.error_msg=e.Message;
	        }
	      
	        return local.judgement;
	    }


	function judge_remove(string name,string usernum,string judgeid){

	    local.status={};

	    transaction{

	        try{
	            
	            myQry1=new Query();
	            myQry1.setDatasource(name);
		    	myQry1.addParam(name="usernum", value="#Val(usernum)#", cfsqltype="CF_SQL_INTEGER");
		    	myQry1.addParam(name="judgeid", value="#Val(judgeid)#", cfsqltype="CF_SQL_INTEGER");
		    	myQry1.setSQL("DELETE FROM users_judge where userid=:usernum and judgeid=:judgeid");
	            myQry1.execute();

	           	           	            
	            myQry2=new Query();
	            myQry2.setDatasource(name);
	            myQry2.addParam(name="judgeid", value="#Val(judgeid)#", cfsqltype="CF_SQL_INTEGER");
		    	myQry2.setSQL("DELETE FROM judge where id=:judgeid");
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