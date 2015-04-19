{% for entity in project.entityList %}
{{project.name}}Module.factory('{{entity.name}}Service', function (serviceGenerator, $http) {
  return serviceGenerator().actions({
    query: '/{{project.name}}/admin/{{entity.name}}/list',
    create: '/{{project.name}}/admin/{{entity.name}}/save',
    update: '/{{project.name}}/admin/{{entity.name}}/update',
    remove: '/{{project.name}}/admin/{{entity.name}}/deleteById',
    toggle: '/{{project.name}}/admin/{{entity.name}}/toggle'
  });
});
{% endfor %}