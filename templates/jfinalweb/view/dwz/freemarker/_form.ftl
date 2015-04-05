<div class="pageFormContent" layoutH="56">
    {% for field in entity.fieldList %}
        {% if field.isPrimaryKey==1 %}
            <input type="hidden" name="{{entity.name}}.{{field.javaName}}" id="{{entity.name}}.{{field.javaName}}"
                   value="${ ({{entity.name}}.{{field.javaName}})! }">
        {% else %}
            <p>
                <label>{{field.label}}：</label>
                <input type="text" name="{{entity.name}}.{{field.javaName}}" id="{{entity.name}}.{{field.javaName}}"
                       class="textInput" size="30"
                       value="${ ({{entity.name}}.{{field.javaName}})! }"/>
            </p>
       {% endif %}
    {% endfor %}
</div>
<div class="formBar">
    <ul>
        <li>
            <div class="buttonActive">
                <div class="buttonContent">
                    <button type="submit">保存</button>
                </div>
            </div>
        </li>
        <li>
            <div class="button">
                <div class="buttonContent">
                    <button type="button" class="close">取消</button>
                </div>
            </div>
        </li>
    </ul>
</div>
