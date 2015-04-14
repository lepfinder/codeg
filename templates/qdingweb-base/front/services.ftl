demoModule.factory('userService', function (serviceGenerator, $http) {
  return serviceGenerator().actions({
    query: '/demo/admin/user/list',
    create: '/demo/admin/user/save',
    update: '/demo/admin/user/update',
    remove: '/demo/admin/user/deleteById',
    toggle: '/demo/admin/user/toggle'
  });
});