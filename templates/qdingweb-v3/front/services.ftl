{% for entity in project.entityList %}
{{project.name}}Module.factory('{{entity.name}}Service', function (serviceGenerator, $http) {
  return serviceGenerator().actions({
    query: '/{{project.name}}bg/admin/{{entity.name}}/list',
    create: '/{{project.name}}bg/admin/{{entity.name}}/save',
    update: '/{{project.name}}bg/admin/{{entity.name}}/update',
    remove: '/{{project.name}}bg/admin/{{entity.name}}/deleteById',
    toggle: '/{{project.name}}bg/admin/{{entity.name}}/toggle'
  });
});
{% endfor %}