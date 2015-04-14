CREATE DATABASE {{project.name}} DEFAULT CHARACTER SET utf8 ;

USE {{project.name}} ;
{% for entity in project.entityList %}
DROP TABLE IF EXISTS `{{entity.name}}`;
CREATE TABLE `{{entity.name}}` (
    {% for field in entity.fieldList %}
    `{{field.dbName}}` {{field.dbType}} COMMENT '{{field.label}}' {% if field.isPrimaryKey==1 %}AUTO_INCREMENT{% endif %},
    {% endfor %}{% for field in entity.fieldList %}{% if field.isPrimaryKey==1 %}
     PRIMARY KEY (`{{field.dbName}}`)
    {% endif %}{% endfor %}
)ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='{{entity.label}}';
{% endfor %}
