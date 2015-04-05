<@layout>
<h1>{{entity.label}}管理 ---&gt; 查看{{entity.label}}
</h1>
<div class="pageContent">
	<div class="pageFormContent" layoutH="56">
	{% for field in entity.fieldList %}
    {% if field.isPrimaryKey==1 %}
     <input type="hidden" name="{{entity.name}}.{{field.javaName}}" id="{{entity.name}}.{{field.javaName}}"  value="${ {{entity.name}}.{{field.javaName}} }">
    {% else %}
		<p>
			<label>{{field.label}}：</label>
			<input type="text" readonly="readonly" name="{{entity.name}}.{{field.javaName}}" id="{{entity.name}}.{{field.javaName}}" class="textInput" size="30" value="${ {{entity.name}}.{{field.javaName}} }"/>
		</p>
	{% endif %}
    {% endfor %}
	</div>
</div>

</@layout>
