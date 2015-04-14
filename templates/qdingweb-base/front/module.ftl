/*global Modules:true*/

// define module
var demoModule = Modules.register('demoModule', ['app']);

// config routes
demoModule.config(function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('demo', {
      url: '/demo',
      "abstract": true,
      template: "<div ui-view></div>"
    })
    .state('demo.user', {
      url: '/user',
      templateUrl: "modules/demo/templates/user.html",
      controller: 'userController'
    });

});