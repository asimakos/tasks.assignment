
//Judge page insert

$$(document).on('page:init', '.page[data-name="judge_new"]', function (e, page) {
  // Do something here when page with data-name="judge_new" attribute loaded and initialized
     $$("#judge_submit").on('click',function(e){
           
        app.request({
            url:"http://127.0.0.1:49820/index.cfm/user/judgeadd/",
            type:"POST",
            data:{
              "usernum":localStorage.userid,
              "judgename":$$("#judge_new").val(),
              "judgedate":$$("#judge_new_date").val()
            },
           dataType:"json",
           success:function(result){
               //console.log(result);
               if (result.SUCCESS){
                  app.dialog.alert("Η εγγραφή αποθηκεύτηκε επιτυχώς.","Ενημέρωση");
                  $$("#judge_new").val("");
                  $$("#judge_new_date").val("");
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

//Judge page edit

$$(document).on('page:init', '.page[data-name="judge_edit"]', function (e, page) {

//console.log(page.route);

  $$("#ejudge_id").hide();   

  const {judgeID} = page.route.params;
  display_judge(judgeID);

  $$("#judge_update").on('click',function(e){
           
        app.request({
            url:"http://127.0.0.1:49820/index.cfm/user/judgeupdate/",
            type:"PUT",
            data:{
              "judgeid":$$("#judge_eid").val(),
              "judgename":$$("#judge_edit").val(),
              "judgedate":$$("#judge_edit_date").val()
            },
           dataType:"json",
           success:function(result){
               //console.log(result);
               if (result.SUCCESS){
                  app.dialog.alert("Η εγγραφή ενημερώθηκε επιυχώς.","Ενημέρωση");
                  $$("#judge_eid").val("");
                  $$("#judge_edit").val("");
                  $$("#judge_edit_date").val("");
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

function display_judge(judge_id=0){

     app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/judgedisplay/",
          type:"GET",
          data:{
            "judgeid":judge_id
          },
         dataType:"json",
         success:function(result){
             //console.log(result);
             if (result.SUCCESS){

                $$("#judge_edit").val(result.JUDGE_NAME);
                $$("#judge_edit_date").val(result.DATE_ASSIGNED);
                $$("#judge_eid").val(result.JUDGE_ID);                     
               
            }else if (result.ERROR){
                app.dialog.alert("Η εγγραφή δεν μπορεί να εμφανιστεί! Παρακαλώ προσπαθείστε ξανά.","Ενημέρωση");
            }
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
         });       
    }

