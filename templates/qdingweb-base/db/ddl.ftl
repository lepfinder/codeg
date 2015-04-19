CREATE DATABASE {{project.name}} DEFAULT CHARACTER SET utf8 ;

USE {{project.name}} ;
{% for entity in project.entityList %}
DROP TABLE IF EXISTS `{{entity.name}}`;
CREATE TABLE `{{entity.name}}` (
    {% for field in entity.fieldList %}
    `{{field.dbName}}` {{field.dbType}} COMMENT '{{field.label}}' {% if field.isPrimaryKey==1 %}AUTO_INCREMENT{% endif %},
    `is_del` int(2) default 0 comment '删除标志',
    {% endfor %}{% for field in entity.fieldList %}{% if field.isPrimaryKey==1 %}
     PRIMARY KEY (`{{field.dbName}}`)
    {% endif %}{% endfor %}
)ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='{{entity.label}}';
{% endfor %}
