CREATE DATABASE {{project.name}} DEFAULT CHARACTER SET utf8 ;

USE {{project.name}} ;

{% for entity in project.entityList %}
DROP TABLE IF EXISTS `{{entity.name}}`;
CREATE TABLE `{{entity.name}}` (
    {% for field in entity.fieldList %}
    `{{field.name}}` {{field.dbtype}}{% if field.longness > 0 %}({{field.longness}}){% endif %} COMMENT '{{field.label}}' {% if field.isPrimaryKey==1 %}AUTO_INCREMENT{% endif %},
    {% endfor %}
    {% for field in entity.fieldList %}
    {% if field.isPrimaryKey=="1" %}
     PRIMARY KEY (`{{field.name}}`)
    {% endif %}
    {% endfor %}
)ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='{{entity.label}}';
{% endfor %}
