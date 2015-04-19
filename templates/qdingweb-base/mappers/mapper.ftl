<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
{% set entityName = entity.name | capitalize%}
<mapper namespace="{{project.packageName}}.dao.I{{entityName}}Dao">
    <resultMap id="BaseResultMap" type="{{project.packageName}}.domain.{{entityName}}" >
        {% for field in entity.fieldList %}<result column="{{field.dbName}}" property="{{field.javaName}}" />
        {% endfor %}
    </resultMap>

    <sql id="Base_Column_List" >
    {% for field in entity.fieldList %}{{field.dbName}}{%if not loop.last %},{% endif %}{% endfor %}
    </sql>
    
    <insert id="insert" parameterType="{{project.packageName}}.domain.{{entityName}}">
        INSERT INTO {{entity.tableName}}
        (
          {% for field in entity.fieldList %}{{field.dbName}}{%if not loop.last %},{% endif %}{% endfor %}
        )
        VALUES
        (
          {% for field in entity.fieldList %}#{ {{field.javaName}} }{%if not loop.last %},{% endif %}{% endfor %}
        )
    </insert>

    <select id="selectById" resultMap="BaseResultMap" parameterType="java.lang.Long" >
      select 
        <include refid="Base_Column_List" />
      from {{entity.tableName}}
      where id = #{id}
    </select>

    <delete id="deleteById" parameterType="java.lang.Long" >
      update {{entity.tableName}}
      set is_del = 1
      where id = #{id}
    </delete>
   
    <insert id="insertSelective" parameterType="{{project.packageName}}.domain.{{entityName}}" >
        insert into {{entity.tableName}}
        <trim prefix="(" suffix=")" suffixOverrides="," >
        {% for field in entity.fieldList %}
          <if test="{{field.javaName}} != null" >
            {{field.dbName}},
          </if>{% endfor %}
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides="," >
        {% for field in entity.fieldList %}
          <if test="{{field.javaName}} != null" >
            #{ {{field.javaName}} },
          </if>{% endfor %}
        </trim>
    </insert>

    <update id="updateByIdSelective" parameterType="{{project.packageName}}.domain.{{entityName}}" >
        update {{entity.tableName}}
        <set >
          {% for field in entity.fieldList %}
          <if test="{{field.javaName}} != null" >
            {{field.dbName}} = #{ {{field.javaName}} },
          </if>{% endfor %}
        </set>
        where id = #{id}
    </update>

    <update id="updateById" parameterType="{{project.packageName}}.domain.{{entityName}}" >
        update {{entity.tableName}}
        set 
        {% for field in entity.fieldList %}
            {{field.dbName}} = #{ {{field.javaName}} }{%if not loop.last %},{% endif %}{% endfor %}
        where id = #{id}
    </update>


    <!-- 根据条件查询数量-->
    <select id="getPageCountByParam" parameterType="java.util.HashMap" resultType="java.lang.Integer">
        SELECT count(t.id)
        FROM {{entity.tableName}} t
        WHERE (is_del=0 or is_del is NULL)
        <if test="id != null">
            and t.id = #{id}
        </if>
        {% for field in entity.fieldList %}{% if field.isSearchable==1 %}
        <if test="{{field.javaName}} != null">
            and t.{{field.dbName}} = #{ {{field.javaName}} }
        </if>{% endif %}{% endfor %}
    </select>

    <select id="getPageListByParam" parameterType="java.util.HashMap" resultMap="BaseResultMap">
        SELECT t.*
        FROM {{entity.tableName}} t
        WHERE (is_del=0 or is_del is NULL)
        <if test="id != null">
            and t.id = #{id}
        </if>
        {% for field in entity.fieldList %}{% if field.isSearchable==1 %}
        <if test="{{field.javaName}} != null">
            and t.{{field.dbName}} = #{ {{field.javaName}} }
        </if>{% endif %}{% endfor %}
        order by t.id desc
        <if test="startIndex != null and pageSize !=null ">
            limit #{startIndex}, #{pageSize}
        </if>
    </select>

</mapper>