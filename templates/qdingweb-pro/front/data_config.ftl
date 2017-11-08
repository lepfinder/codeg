<!-- 定义获取数据条数的sql，可以为空，如果为空，则使用下面的sql配置自动包装一个获取条数的sql -->
<countSql>
    SELECT count(t.id)
        FROM {{entity.tableName}} t
        WHERE 1 = 1
        <if test="id != null">
            and t.id = #{id}
        </if>
        {% for field in entity.fieldList %}
        <if test="{{field.javaName}} != null">
            and t.{{field.dbName}} = #{ {{field.javaName}} }
        </if>{% endfor %}
</countSql>

<!-- 定义获取数据的sql，不可以为空，注意表名上面需要指定库名,需要包含如下分页参数： 
-->
<sql>
    SELECT 
    {% for field in entity.fieldList %}t.{{field.dbName}}{%if not loop.last %},{% endif %}{% endfor %}
    FROM {{entity.tableName}} t
    WHERE 1 = 1
    <if test="id != null">
        and t.id = #{id}
    </if>
    {% for field in entity.fieldList %}
    <if test="{{field.javaName}} != null">
        and t.{{field.dbName}} = #{ {{field.javaName}} }
    </if>{% endfor %}
    order by t.id desc
    <if test="startIndex != null and pageSize !=null ">
        limit #{startIndex}, #{pageSize}
    </if>
</sql>

<!-- 定义文件导出的属性信息，对应导出的excel的表头部分 

-->
<fields>
    {% for field in entity.fieldList %}
        <field  name="{{field.label}}"   property="{{field.dbName}}" />
    {% endfor %}
</fields>
