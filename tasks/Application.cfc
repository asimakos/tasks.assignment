
component extends=framework.one {

	this.name="appealsManager";

	/*optionsAccessControl = {
		  origin: "*",
		  headers: "x-requested-with",
		  credentials: false,
		  maxAge: 604800
		};
    */
	variables.framework =   {

	  optionsAccessControl = {
			origin: "*",
			headers: "Origin, X-Requested-With, Content-Type, Accept, Authorization, Access-Control-Allow-Headers, Access-Control-Allow-Methods, Access-Control-Allow-Origin"
		},	
	  preflightOptions = true,
      generateSES = true,
      //SESOmitIndex = true,
      routes= [
		{ "$POST/user/login/" = "/main/get" },
		{ "$POST/user/register/" = "/main/register" },
		{ "$GET/main/activate/:code" = "/main/activation/code/:code"},
		{ "$GET/user/judgements/" = "/main/judgelist"},
		{ "$GET/user/judgesearchbar/" = "/main/judgesearchbar"},
		{ "$POST/user/judgeadd/" = "/main/judgenew"},
		{ "$DELETE/user/judgeremove/" = "/main/judgedelete"},
		{ "$GET/user/judgedisplay/" = "/main/judgeview"},
		{ "$PUT/user/judgeupdate/" = "/main/judgeupdate"},
		{ "$GET/user/assistances/" = "/main/assistlist"},
		{ "$POST/user/assistadd/" = "/main/assistnew"},
		{ "$GET/user/assistsearchbar/" = "/main/assistsearchbar"},
		{ "$GET/user/assistdisplay/" = "/main/assistview"},
		{ "$PUT/user/assistupdate/" = "/main/assistupdate"},
		{ "$DELETE/user/assistremove/" = "/main/assistdelete"},
		{ "$GET/user/appeals/" = "/main/appeallist"},
		{ "$POST/user/appealadd/" = "/main/appealnew"},
		{ "$DELETE/user/appealremove/" = "/main/appealdelete"},
		{ "$GET/user/appealdisplay/" = "/main/appealview"},
		{ "$PUT/user/appealupdate/" = "/main/appealupdate"},
		{ "$GET/user/appealsearchbar/" = "/main/appealsearchbar"}
		]
 
	};

	function setupApplication(){

		application.dsn="appeals";
	}

}