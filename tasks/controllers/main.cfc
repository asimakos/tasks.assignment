
component accessors=true {


	property userService;
    property judgerService;
    property assisterService;
    property appealerService;


	function init( fw ) {
        variables.fw = fw;
        return this;
    }

    function before(struct rc) {

    	rc.dsn = application.dsn;

    }

    function default( struct rc ) {
        
        request.layout=false;
        rc.name="ΡΨΩΓΔ";
        rc.dupl_name="üößä";
    }

    // Judge CRUD (list,new,view,delete,update) - searchbar

    function judgelist(struct rc){

        rc.judge_list = variables.judgerService.judge(rc.dsn,rc.usernum);

        variables.fw.renderData( "json", rc.judge_list).header( "Access-Control-Allow-Origin", "*" );  
    }

    function judgesearchbar(struct rc){

        rc.judge_search = variables.judgerService.judge_searchbar(rc.dsn,rc.usernum,rc.searchtoken);
        
        variables.fw.renderData( "json", rc.judge_search).header( "Access-Control-Allow-Origin", "*" );  
    }

     function judgenew(struct rc){

        rc.judge_new = variables.judgerService.judge_add(rc.dsn,rc.usernum,rc.judgename,rc.judgedate);
        
        variables.fw.renderData( "json", rc.judge_new).header( "Access-Control-Allow-Origin", "*" );         
        
       // local.checktype.dsn=getMetadata(rc.dsn).getName();
    
    }

    function judgeview(struct rc){

        rc.judge_display = variables.judgerService.judge_view(rc.dsn,rc.judgeid);
        
        variables.fw.renderData( "json", rc.judge_display).header( "Access-Control-Allow-Origin", "*" );         
        
    }

    function judgeupdate(struct rc){

        rc.judge_update = variables.judgerService.judge_put(rc.dsn,rc.judgename,rc.judgedate,rc.judgeid);
        
        variables.fw.renderData( "json", rc.judge_update).header( "Access-Control-Allow-Origin", "*" );         
    
    }

     function judgedelete(struct rc){

        rc.judge_delete = variables.judgerService.judge_remove(rc.dsn,rc.usernum,rc.judgeid);
        
        variables.fw.renderData( "json", rc.judge_delete).header( "Access-Control-Allow-Origin", "*" );         
           
    }

    // User login - register

    function get (struct rc) {
      
         rc.user_info = variables.userService.login(rc.dsn,rc.username,rc.password); 

         variables.fw.renderData( "json", rc.user_info).header( "Access-Control-Allow-Origin", "*" );
 
    }

    function register(struct rc){

        rc.user_register=variables.userService.check(rc.dsn,rc.username,rc.password,rc.name,rc.email);

        variables.fw.renderData( "json", rc.user_register).header( "Access-Control-Allow-Origin", "*" );
    }

    function activation(struct rc){
        rc.page_title="Ενεργοποίηση λογαριασμού...";
        rc.user_activation=variables.userService.user_activate(rc.dsn,arguments.rc.code);
    }

    // Assist CRUD (list,new,view,delete,update) - searchbar

    function assistlist(struct rc){

        rc.assist_list = variables.assisterService.assist(rc.dsn,rc.usernum);

        variables.fw.renderData( "json", rc.assist_list).header( "Access-Control-Allow-Origin", "*" );  
    }

    function assistnew(struct rc){

        rc.assist_new = variables.assisterService.assist_add(rc.dsn,rc.usernum,rc.assistname,rc.assistdate);
        
        variables.fw.renderData( "json", rc.assist_new).header( "Access-Control-Allow-Origin", "*" );         
            
    }

    function assistview(struct rc){

        rc.assist_display = variables.assisterService.assist_view(rc.dsn,rc.assistid);
        
        variables.fw.renderData( "json", rc.assist_display).header( "Access-Control-Allow-Origin", "*" );         
        
    }

    function assistsearchbar(struct rc){

        rc.assist_search = variables.assisterService.assist_searchbar(rc.dsn,rc.usernum,rc.searchtoken);
        
        variables.fw.renderData( "json", rc.assist_search).header( "Access-Control-Allow-Origin", "*" );  
    }

    function assistupdate(struct rc){

        rc.assist_update = variables.assisterService.assist_put(rc.dsn,rc.assisttitle,rc.assistdate,rc.assistid);
        
        variables.fw.renderData( "json", rc.assist_update).header( "Access-Control-Allow-Origin", "*" );         
    
    }

    function assistdelete(struct rc){

        rc.assist_delete = variables.assisterService.assist_remove(rc.dsn,rc.usernum,rc.assistid);
        
        variables.fw.renderData( "json", rc.assist_delete).header( "Access-Control-Allow-Origin", "*" );         
           
    }

    // Appeal CRUD (list,new,view,delete,update) - searchbar

    function appeallist(struct rc){

        rc.appeal_list = variables.appealerService.appeal(rc.dsn,rc.usernum);
        
        variables.fw.renderData( "json", rc.appeal_list).header( "Access-Control-Allow-Origin", "*" );  
    }

    function appealnew(struct rc){

        rc.appeal_new = variables.appealerService.appeal_add(rc.dsn,rc.usernum,rc.applicant,rc.assigner,rc.amount,rc.appealdate);
        
        variables.fw.renderData( "json", rc.appeal_new).header( "Access-Control-Allow-Origin", "*" );         
            
    }

    function appealview(struct rc){

        rc.appeal_display = variables.appealerService.appeal_view(rc.dsn,rc.appealid);
        
        variables.fw.renderData( "json", rc.appeal_display).header( "Access-Control-Allow-Origin", "*" );         
        
    }

    function appealupdate(struct rc){

        rc.appeal_update = variables.appealerService.appeal_put(rc.dsn,rc.applicant,rc.assigner,rc.amount,rc.assigned,rc.appealid);
        
        variables.fw.renderData( "json", rc.appeal_update).header( "Access-Control-Allow-Origin", "*" );         
    
    }

    function appealsearchbar(struct rc){

        rc.appeal_search = variables.appealerService.appeal_searchbar(rc.dsn,rc.usernum,rc.searchtoken);
        
        variables.fw.renderData( "json", rc.appeal_search).header( "Access-Control-Allow-Origin", "*" );  
    }

    function appealdelete(struct rc){

        rc.appeal_delete = variables.appealerService.appeal_remove(rc.dsn,rc.usernum,rc.appealid);
        
        variables.fw.renderData( "json", rc.appeal_delete).header( "Access-Control-Allow-Origin", "*" );         
           
    }

}