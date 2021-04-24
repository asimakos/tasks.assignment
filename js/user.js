
//User login page

$$("#submit").on('click',function(e){
   
     var username= $$("#username").val();
     var password= $$("#password").val();

     
    app.request({
        url:"http://127.0.0.1:49820/index.cfm/user/login/",
        type:"POST",
        data:{
          "username":username,
          "password":password
        },
       /* crossDomain: true,
        xhrFields: { withCredentials: false },
        headers: {
         'Access-Control-Allow-Origin': '*',
         'Access-Control-Allow-Methods':'GET,HEAD,OPTIONS,POST,PUT',
         'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization',
         'Content-type': 'application/json; charset=utf-8',
        },*/
        dataType:"json",
        success:function(result){
           //console.log(result);
           if (result.SUCCESS){
            
              localStorage.setItem("status","valid");
              localStorage.setItem("userid",result.USERID);
              localStorage.setItem("username",result.USERNAME);
            
              app.views.main.router.navigate('/tab-menu/');
          }else if (result.ERROR){
              app.dialog.alert("Wrong username/password! Please try again.","Warning");
          }
        },
        fail: function(xhr, textStatus, errorThrown){
          app.dialog.alert("Something wrong appeared! Please try again later.","Error");
        }
    
      });

  
  });


  $$("#reset").on('click',function(e){
   
     $$("#username").val("");
     $$("#password").val("");

  });

  $$(".logout").on('click',function(e){
     
    app.dialog.alert("Μόλις αποσυνδεθήκατε!","Ενημέρωση");
      
    localStorage.removeItem("status");
    localStorage.removeItem("userid");
    localStorage.removeItem("username");
  
    app.views.main.router.navigate('/');
  });


//User page register

$$(document).on('page:init', '.page[data-name="register_user"]', function (e, page) {
  // Do something here when page with data-name="register_user" attribute loaded and initialized
  
     $$("#register_submit").on('click',function(e){
           
        app.request({
            url:"http://127.0.0.1:49820/index.cfm/user/register/",
            type:"POST",
            data:{
              "username":$$("#reg_username").val(),
              "password":$$("#reg_password").val(),
              "name":$$("#reg_name").val(),
              "email":$$("#reg_email").val()
            },
           dataType:"json",
           success:function(result){
                 //console.log(result);
               if (result.SUCCESS){
                  app.toast.show({
                  text: 'Ο χρήστης αποθηκεύτηκε επιτυχώς! Παρακαλώ ελέγξτε το email σας για ενεργοποίηση.',
                  closeButton: true,
                });
                  $$("#reg_username").val("");
                  $$("#reg_password").val("");
                  $$("#reg_name").val("");
                  $$("#reg_email").val("");
                //  app.views.main.router.navigate('/tab-menu/'); 
              }else if (result.ERROR){
                  app.toast.show({
                  text: 'Υπάρχει ήδη χρήστης με αυτό το όνομα! Παρακαλώ επιλέξτε άλλο όνομα χρήστη.',
                  closeButton: true,
                });
              }
            },
            fail: function(xhr, textStatus, errorThrown){
              app.dialog.alert("Κάποιο σφάλμα προέκυψε! Παρακαλώ προσπαθείστε ξανά.","Σφάλμα");
            }
        
          });   
     });

 });
