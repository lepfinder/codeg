

// basis.developer
demoModule.controller('userController', function ($scope, $state, $modal, growl, userService, controllerGenerator) {
  controllerGenerator($scope, userService, {
    title: '用户',
    property: 'name',
    createTemplate: 'modules/demo/templates/partial/user-form.html',
    updateTemplate: 'modules/demo/templates/partial/user-form.html',
    autoload: true
  });

  // 定义搜索参数
  $scope.searchParams = function () {
    return {
      queryKey: $scope.key || null,
      status: $scope.status || null
    };
  };

});
