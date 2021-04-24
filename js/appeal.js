
//Appeal page insert

$$(document).on('page:init', '.page[data-name="appeal_new"]', function (e, page) {
  // Do something here when page with data-name="judge_new" attribute loaded and initialized
     $$("#appeal_submit").on('click',function(e){
           
        app.request({
            url:"http://127.0.0.1:49820/index.cfm/user/appealadd/",
            type:"POST",
            data:{
              "usernum":localStorage.userid,
              "applicant":$$("#applicant_new").val(),
              "assigner":$$("#assigner_new").val(),
              "amount":$$("#amount_new").val(),
              "appealdate":$$("#appeal_new_date").val()
            },
           dataType:"json",
           success:function(result){
               //console.log(result);
               if (result.SUCCESS){
                  app.dialog.alert("Η εγγραφή αποθηκεύτηκε επιτυχώς.","Ενημέρωση");
                  $$("#applicant_new").val("");
                  $$("#assigner_new").val("");
                  $$("#amount_new").val("");
                  $$("#appeal_new_date").val("");
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

$$(document).on('page:init', '.page[data-name="appeal_edit"]', function (e, page) {

//console.log(page.route);

 $$("#eappeal_id").hide();   

  const {appealID} = page.route.params;
  display_appeal(appealID);

  $$("#appeal_update").on('click',function(e){
           
      app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/appealupdate/",
          type:"PUT",
          data:{
            "applicant":$$("#applicant_edit").val(),
            "assigner":$$("#assigner_edit").val(),
            "amount":$$("#amount_edit").val(),
            "assigned":$$("#appeal_edit_date").val(),
            "appealid":$$("#appeal_eid").val()
          },
         dataType:"json",
         success:function(result){
             //console.log(result);
             if (result.SUCCESS){
                app.dialog.alert("Η εγγραφή ενημερώθηκε επιυχώς.","Ενημέρωση");
                $$("#applicant_edit").val("");
                $$("#assigner_edit").val("");
                $$("#amount_edit").val("");
                $$("#appeal_edit_date").val("");
                $$("#appeal_eid").val("");     
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

function display_appeal(appeal_id=0){

     app.request({
          url:"http://127.0.0.1:49820/index.cfm/user/appealdisplay/",
          type:"GET",
          data:{
            "appealid":appeal_id
          },
         dataType:"json",
         success:function(result){
             //console.log(result);
             if (result.SUCCESS){

               $$("#applicant_edit").val(result.APPEAL_APPLICANT);
               $$("#assigner_edit").val(result.APPEAL_ASSIGNER);
               $$("#amount_edit").val(result.APPEAL_AMOUNT);
               $$("#appeal_edit_date").val(result.DATE_ASSIGNED);
               $$("#appeal_eid").val(result.APPEAL_ID);                     
               
            }else if (result.ERROR){
                app.dialog.alert("Η εγγραφή δεν μπορεί να εμφανιστεί! Παρακαλώ προσπαθείστε ξανά.","Ενημέρωση");
            }
          },
          fail: function(xhr, textStatus, errorThrown){
            app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
          }
         });       
    }