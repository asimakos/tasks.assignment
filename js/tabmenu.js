
//Tab menu page

$$(document).on('page:init', '.page[data-name="menu"]', function (e, page) {
  // Do something here when page with data-name="menu" attribute loaded and initialized
    
    judgement_list();
    assistance_list();
    appeal_list();

    //Direct judge delete page

    $$("#judgement_list").on('click',"#delete",function(e){
        
        var del_id=$$(this).data('id');

        app.dialog.confirm("Επιθυμείτε να διαγράψετε αυτήν την εγγραφή?","Ενημέρωση",function(){
            //app.dialog.alert(del_id);

            app.request({
                url:"http://127.0.0.1:49820/index.cfm/user/judgeremove/",
                type:"DELETE",
                data:{
                  "usernum":localStorage.userid,
                  "judgeid":del_id
                },
               dataType:"json",
               success:function(result){
                   //console.log(result);
                   if (result.SUCCESS){
                      app.dialog.alert("Η εγγραφή διαγράφτηκε επιτυχώς.","Ενημέρωση");
                      judgement_list();
                  }else if (result.ERROR){
                      app.dialog.alert("Η εγγραφή δεν μπορεί να διαγραφεί! Παρακαλώ προσπαθείστε ξανά.","Προειδοποίηση");
                  }
                },
                fail: function(xhr, textStatus, errorThrown){
                  app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
                }
           });   

        },function(){
            //app.dialog.alert('Cancel');
        });
          
     });
     
    //Direct assist delete page

    $$("#assistance_list").on('click',"#delete",function(e){
        
        var del_id=$$(this).data('id');

        app.dialog.confirm("Επιθυμείτε να διαγράψετε αυτήν την εγγραφή?","Ενημέρωση",function(){
            //app.dialog.alert(del_id);

            app.request({
                url:"http://127.0.0.1:49820/index.cfm/user/assistremove/",
                type:"DELETE",
                data:{
                  "usernum":localStorage.userid,
                  "assistid":del_id
                },
               dataType:"json",
               success:function(result){
                   //console.log(result);
                   if (result.SUCCESS){
                      app.dialog.alert("Η εγγραφή διαγράφτηκε επιτυχώς.","Ενημέρωση");
                      assistance_list();
                  }else if (result.ERROR){
                      app.dialog.alert("Η εγγραφή δεν μπορεί να διαγραφεί! Παρακαλώ προσπαθείστε ξανά.","Προειδοποίηση");
                  }
                },
                fail: function(xhr, textStatus, errorThrown){
                  app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
                }
           });   

        },function(){
            //app.dialog.alert('Cancel');
        });
          
     });

    //Direct appeal delete page

    $$("#appeal_list").on('click',"#delete",function(e){
        
        var del_id=$$(this).data('id');

        app.dialog.confirm("Επιθυμείτε να διαγράψετε αυτήν την εγγραφή?","Ενημέρωση",function(){
            //app.dialog.alert(del_id);

            app.request({
                url:"http://127.0.0.1:49820/index.cfm/user/appealremove/",
                type:"DELETE",
                data:{
                  "usernum":localStorage.userid,
                  "appealid":del_id
                },
               dataType:"json",
               success:function(result){
                   //console.log(result);
                   if (result.SUCCESS){
                      app.dialog.alert("Η εγγραφή διαγράφτηκε επιτυχώς.","Ενημέρωση");
                      appeal_list();
                  }else if (result.ERROR){
                      app.dialog.alert("Η εγγραφή δεν μπορεί να διαγραφεί! Παρακαλώ προσπαθείστε ξανά.","Προειδοποίηση");
                  }
                },
                fail: function(xhr, textStatus, errorThrown){
                  app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
                }
           });   

        },function(){
            //app.dialog.alert('Cancel');
        });
          
     });


    //Direct judge edit page

    $$("#judgement_list").on('click',"#edit",function(e){

       var edit_id=$$(this).data('id');

       app.views.main.router.navigate('/judge-edit/'+ edit_id +'/');

    });

    //Direct assist edit page

    $$("#assistance_list").on('click',"#edit",function(e){

       var edit_id=$$(this).data('id');

       app.views.main.router.navigate('/assist-edit/'+ edit_id +'/');

    });

    //Direct appeal edit page

    $$("#appeal_list").on('click',"#edit",function(e){

       var edit_id=$$(this).data('id');

       app.views.main.router.navigate('/appeal-edit/'+ edit_id +'/');

    });

    //Searchbar events in judge section menu

    var searchbar_judge = app.searchbar.create({
          el: '.search_judge',
          customSearch: true
        });

    searchbar_judge.on('search', function(){
        //console.log('Searching', searchbar.query);
        judgement_searchbar(searchbar_judge.query);
    });

    searchbar_judge.on('clear', function(){
        //console.log('clear');
        judgement_list();
    });

    //Searchbar events in assist section menu

    var searchbar_assist = app.searchbar.create({
          el: '.search_assist',
          customSearch: true
        });

    searchbar_assist.on('search', function(){
        //console.log('Searching', searchbar.query);
        assistance_searchbar(searchbar_assist.query);
    });

    searchbar_assist.on('clear', function(){
        //console.log('clear');
        assistance_list();
    });

    //Searchbar events in appeal section menu

    var searchbar_appeal = app.searchbar.create({
          el: '.search_appeal',
          customSearch: true
        });

    searchbar_appeal.on('search', function(){
        //console.log('Searching', searchbar.query);
        appeal_searchbar(searchbar_appeal.query);
    });

    searchbar_appeal.on('clear', function(){
        //console.log('clear');
        appeal_list();
    });

 });

// Judge Grid

function judgement_list(){
  
  var judgement="";

   app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/judgements/",
          type:"GET",
          data:{
          "usernum":localStorage.userid
        },
         dataType:"json",
          success:function(result){
            //console.log(result);         
            for (var i=0; i<result.length;i++){
                judgement=judgement+"<tr>"+
                    "<td class='numeric-cell'>" +(i+1) + "</td>" +
                    "<td class='label-cell'>" + result[i].JUDGE_NAME + "</td>" +
                    "<td class='medium-only'>" + result[i].DATE_ASSIGNED + "</td>" +
                    "<td class='medium-only'><a href='#' id='edit' class='color-orange' data-id='"+ result[i].JUDGE_ID +"'><i class='f7-icons'>pencil</i></a> | <a href='#' id='delete' class='color-red' data-id='"+ result[i].JUDGE_ID +"'><i class='f7-icons'>trash</i></a></td>" +
                    "</tr>";
               }
            
            $$("#judgement_list").html(judgement); 
                      
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
      });

   
}

//Searchbar search event in judge section menu

function judgement_searchbar(searchtoken=""){
  
  var judgement="";

   app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/judgesearchbar/",
          type:"GET",
          data:{
          "usernum":localStorage.userid,
          "searchtoken":searchtoken
        },
         dataType:"json",
          success:function(result){
            //console.log(result);         
            for (var i=0; i<result.length;i++){
                judgement=judgement+"<tr>"+
                    "<td class='numeric-cell'>" +(i+1) + "</td>" +
                    "<td class='label-cell'>" + result[i].JUDGE_NAME + "</td>" +
                    "<td class='medium-only'>" + result[i].DATE_ASSIGNED + "</td>" +
                    "<td class='medium-only'><a href='#' id='edit' class='color-orange' data-id='"+ result[i].JUDGE_ID +"'><i class='f7-icons'>pencil</i></a> | <a href='#' id='delete' class='color-red' data-id='"+ result[i].JUDGE_ID +"'><i class='f7-icons'>trash</i></a></td>" +
                    "</tr>";
               }
            
            $$("#judgement_list").html(judgement); 
                      
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
      });

   
}

// Assist Grid

function assistance_list(){
  
  var assistance="";

   app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/assistances/",
          type:"GET",
          data:{
          "usernum":localStorage.userid
        },
         dataType:"json",
          success:function(result){
           // console.log(result);         
            for (var i=0; i<result.length;i++){
                assistance=assistance+"<tr>"+
                    "<td class='numeric-cell'>" +(i+1) + "</td>" +
                    "<td class='label-cell'>" + result[i].ASSIST_TITLE + "</td>" +
                    "<td class='medium-only'>" + result[i].ASSIST_ASSIGNED + "</td>" +
                    "<td class='medium-only'><a href='#' id='edit' class='color-orange' data-id='"+ result[i].ASSIST_ID +"'><i class='f7-icons'>pencil</i></a> | <a href='#' id='delete' class='color-red' data-id='"+ result[i].ASSIST_ID +"'><i class='f7-icons'>trash</i></a></td>" +
                    "</tr>";
               }
            
            $$("#assistance_list").html(assistance); 
                     
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Something wrong appeared! Please try again later.","Error");
          }
      });
   
}

//Searchbar search event in assist section menu

function assistance_searchbar(searchtoken=""){
  
  var assistance="";

   app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/assistsearchbar/",
          type:"GET",
          data:{
          "usernum":localStorage.userid,
          "searchtoken":searchtoken
        },
         dataType:"json",
          success:function(result){
            //console.log(result);         
            for (var i=0; i<result.length;i++){
                assistance=assistance+"<tr>"+
                    "<td class='numeric-cell'>" +(i+1) + "</td>" +
                    "<td class='label-cell'>" + result[i].ASSIST_NAME + "</td>" +
                    "<td class='medium-only'>" + result[i].DATE_ASSIGNED + "</td>" +
                    "<td class='medium-only'><a href='#' id='edit' class='color-orange' data-id='"+ result[i].ASSIST_ID +"'><i class='f7-icons'>pencil</i></a> | <a href='#' id='delete' class='color-red' data-id='"+ result[i].ASSIST_ID +"'><i class='f7-icons'>trash</i></a></td>" +
                    "</tr>";
               }
            
            $$("#assistance_list").html(assistance); 
                      
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
      });

   
}

// Appeal Grid

function appeal_list(){
  
  var appeal="";

   app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/appeals/",
          type:"GET",
          data:{
          "usernum":localStorage.userid
        },
         dataType:"json",
          success:function(result){
            //console.log(result);         
            for (var i=0; i<result.length;i++){
                appeal=appeal+"<tr>"+
                    "<td class='numeric-cell'>" +(i+1) + "</td>" +
                    "<td class='label-cell'>" + result[i].APPEAL_APPLICANT + "</td>" +
                    "<td class='label-cell'>" + result[i].APPEAL_ASSIGNER + "</td>" +
                    "<td class='numeric-cell'>" + result[i].AMOUNT + "</td>" +
                    "<td class='medium-only'>" + result[i].APPEAL_ASSIGNED + "</td>" +
                    "<td class='medium-only'><a href='#' id='edit' class='color-orange' data-id='"+ result[i].APPEAL_ID +"'><i class='f7-icons'>pencil</i></a> | <a href='#' id='delete' class='color-red' data-id='"+ result[i].APPEAL_ID +"'><i class='f7-icons'>trash</i></a></td>" +
                    "</tr>";
               }
            
            $$("#appeal_list").html(appeal); 
                      
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
      });

   
}

 //Searchbar search event in appeal section menu

function appeal_searchbar(searchtoken=""){
  
  var appeal="";

   app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/appealsearchbar/",
          type:"GET",
          data:{
          "usernum":localStorage.userid,
          "searchtoken":searchtoken
        },
         dataType:"json",
          success:function(result){
            //console.log(result);         
            for (var i=0; i<result.length;i++){
                appeal=appeal+"<tr>"+
                    "<td class='numeric-cell'>" +(i+1) + "</td>" +
                    "<td class='label-cell'>" + result[i].APPEAL_APPLICANT + "</td>" +
                    "<td class='label-cell'>" + result[i].APPEAL_ASSIGNER + "</td>" +
                    "<td class='numeric-cell'>" + result[i].AMOUNT + "</td>" +
                    "<td class='medium-only'>" + result[i].APPEAL_ASSIGNED + "</td>" +
                    "<td class='medium-only'><a href='#' id='edit' class='color-orange' data-id='"+ result[i].APPEAL_ID +"'><i class='f7-icons'>pencil</i></a> | <a href='#' id='delete' class='color-red' data-id='"+ result[i].APPEAL_ID +"'><i class='f7-icons'>trash</i></a></td>" +
                    "</tr>";
               }
            
            $$("#appeal_list").html(appeal);
                      
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
      });

   
}

