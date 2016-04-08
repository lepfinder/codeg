{% for entity in project.entityList %}
{{project.name}}Module.controller('{{entity.name}}Controller', function ($scope, $state, $modal, growl, {{entity.name}}Service, controllerGenerator) {
  controllerGenerator($scope, {{entity.name}}Service, {
    title: '{{entity.label}}',
    property: 'name',
    createTemplate: 'modules/{{project.name}}/templates/partial/{{entity.name}}-form.html',
    updateTemplate: 'modules/{{project.name}}/templates/partial/{{entity.name}}-form.html',
    autoload: true
  });

  $scope.sParams = {};
  // 定义搜索参数
  $scope.searchParams = function () {
    return $scope.sParams
  };

});
{% endfor %}

