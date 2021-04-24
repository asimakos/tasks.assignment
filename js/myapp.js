var app = new Framework7({
    // App root element
    root: '#app',
    // Change App name as per your requirement
    name: 'My App',
    // App id
    id: 'com.myapp.test',
    swipePanel: 'left',
    // Enable swipe panel
    panel: {
      swipe: 'left',
    },
    // Enable pushState for componentUrl logic which is most important during adnroid app development
    view: {
      pushState: true, //Enabled for pushState routing
      pushStateOnLoad: true, //Enabled for pushState routing
      pushStateSeparator: '#',
    },
    // Add default routes
    routes: [
      {
        path: '/',
        url: './index.html',
      },
      {
        path: '/add-user/',
        url: './pages/register.html',
      },
      {
        path: '/tab-menu/',
        url: './pages/menu.html',
        beforeEnter:checkAuth,
      },
      {
        path: '/judge-new/',
        url: './pages/judge/new.html',
        beforeEnter:checkAuth,
      },
      {
        path: '/assist-new/',
        url: './pages/assist/new.html',
        beforeEnter:checkAuth,
      },
      {
        path: '/judge-edit/:judgeID/',
        url: './pages/judge/edit.html',
        beforeEnter:checkAuth,
      },
      {
        path: '/assist-edit/:assistID/',
        url: './pages/assist/edit.html',
        beforeEnter:checkAuth,
      },
      {
        path: '/appeal-new/',
        url: './pages/appeal/new.html',
        beforeEnter:checkAuth,
      },
       {
        path: '/appeal-edit/:appealID/',
        url: './pages/appeal/edit.html',
        beforeEnter:checkAuth,
      }
    ],
    // ... other parameters
  });
  
  var mainView = app.views.create('.view-main');

  var $$ = Dom7;


//check if user logged-in
  function checkAuth(to, from, resolve, reject){

      var router=this;

      if (localStorage.getItem("status")){

        resolve();
      }
      else{
        reject();
        router.navigate('/');
        app.toast.show({
          text: 'Δυστυχώς δεν έχετε ακόμη πρόσβαση ως έγκυρος χρήστης !',
          closeButton: true,
          closeButtonText: 'Close Me',
          closeButtonColor: 'red',
        });
        return;
      }
}


 
  

 
  