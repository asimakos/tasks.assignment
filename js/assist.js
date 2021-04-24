
//Assist page insert

$$(document).on('page:init', '.page[data-name="assist_new"]', function (e, page) {
  // Do something here when page with data-name="judge_new" attribute loaded and initialized
     $$("#assist_submit").on('click',function(e){
           
        app.request({
            url:"http://127.0.0.1:49820/index.cfm/user/assistadd/",
            type:"POST",
            data:{
              "usernum":localStorage.userid,
              "assistname":$$("#assist_new").val(),
              "assistdate":$$("#assist_new_date").val()
            },
           dataType:"json",
           success:function(result){
               //console.log(result);
               if (result.SUCCESS){
                  app.dialog.alert("Η εγγραφή αποθηκεύτηκε επιτυχώς.","Ενημέρωση");
                  $$("#assist_new").val("");
                  $$("#assist_new_date").val("");
                  app.views.main.router.navigate('/tab-menu/');
              }else if (result.ERROR){
                  app.dialog.alert("Η εγγραφή δεν μπορεί να αποθηκευτεί! Παρακαλώ προσπαθείστε ξανά.","Προειδοποίηση");
              }
            },
            fail: function(xhr, textStatus, errorThrown){
              app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
            }
        
          });   
     });

 });


//Assist page edit

$$(document).on('page:init', '.page[data-name="assist_edit"]', function (e, page) {

//console.log(page.route);

  $$("#eassist_id").hide();   

  const {assistID} = page.route.params;
  display_assist(assistID);

  $$("#assist_update").on('click',function(e){
           
      app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/assistupdate/",
          type:"PUT",
          data:{
            "assistid":$$("#assist_eid").val(),
            "assisttitle":$$("#assist_edit").val(),
            "assistdate":$$("#assist_edit_date").val()
          },
         dataType:"json",
         success:function(result){
             //console.log(result);
             if (result.SUCCESS){
                app.dialog.alert("Η εγγραφή ενημερώθηκε επιυχώς.","Ενημέρωση");
                $$("#assist_eid").val("");
                $$("#assist_edit").val("");
                $$("#assist_edit_date").val("");
                app.views.main.router.navigate('/tab-menu/');
            }else if (result.ERROR){
                app.dialog.alert("Η εγγραφή δεν μπορεί να ενημερωθεί! Παρακάλώ προσπαθείστε ξανά.","Προειδοποίηση");
            }
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
      
        });   
   });

});


function display_assist(assist_id=0){

     app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/assistdisplay/",
          type:"GET",
          data:{
            "assistid":assist_id
          },
         dataType:"json",
         success:function(result){
             //console.log(result);
             if (result.SUCCESS){

                $$("#assist_edit").val(result.ASSIST_TITLE);
                $$("#assist_edit_date").val(result.DATE_ASSIGNED);
                $$("#assist_eid").val(result.ASSIST_ID);                     
               
            }else if (result.ERROR){
                app.dialog.alert("Η εγγραφή δεν μπορεί να εμφανιστεί! Παρακαλώ προσπαθείστε ξανά.","Ενημέρωση");
            }
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
         });       
    }

