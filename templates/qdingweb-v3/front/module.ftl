/*global Modules:true*/

// define module
var {{project.name}}Module = Modules.register('{{project.name}}Module', ['app']);

// config routes
{{project.name}}Module.config(function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('{{project.name}}', {
      url: '/{{project.name}}bg',
      "abstract": true,
      template: "<div ui-view></div>"
    })
    {% for entity in project.entityList %}
    .state('{{project.name}}.{{entity.name}}', {
      url: '/{{entity.name}}',
      templateUrl: "modules/{{project.name}}/templates/{{entity.name}}.html",
      controller: '{{entity.name}}Controller'
    }){% endfor %};
});