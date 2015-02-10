<form id="pagerForm" method="post" action="${PATH}/{{entity.name}}/">
    <input type="hidden" name="pageNum" value="${page.pageNumber}"/>
    <input type="hidden" name="numPerPage" value="${page.pageSize}"/>

</form>

<div class="pageHeader">
    <form onsubmit="return navTabSearch(this);" action="${PATH}/{{entity.name}}" method="post">
        <div class="searchBar">
            <table class="searchContent">
                <tr>
					{% for field in entity.fieldList %}
						{% if field.isPrimaryKey=="1" %}
                            <td>
								{{field.label}}:<input type="text" name="{{entity.name}}.f_{{field.name}}" />
								<input type="hidden" name="{{entity.name}}.f_{{field.name}}_op" value="LIKE" />
                            </td>
                       {% endif %}
					{% endfor %}
                </tr>
            </table>
            <div class="subBar">
                <ul>
                    <li>
                        <div class="buttonActive">
                            <div class="buttonContent">
                                <button type="submit">检索</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </form>
</div>
<div class="pageContent">
    <div class="panelBar">
        <ul class="toolBar">
            <li><a class="add" href="${PATH}/{{entity.name}}/add" target="navTab"
                   rel="rel_{{entity.name}}_add"><span>添加</span></a></li>
            <li><a class="delete" href="${PATH}/{{entity.name}}/delete/{sid_user}"
                   rel="rel_{{entity.name}}_delete" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
            <li><a class="edit" href="${PATH}/{{entity.name}}/edit/{sid_user}" target="navTab"
                   rel="rel_{{entity.name}}_edit"><span>修改</span></a></li>
            <li class="line">line</li>
            <li><a class="icon" href="${PATH}/{{entity.name}}/excel" target="dwzExport"
                   targetType="navTab" rel="rel_{{entity.name}}_dowmload" title="实要导出这些记录吗?"><span>导出EXCEL</span></a>
            </li>
        </ul>
    </div>
    <table class="table" width="100%" layoutH="138">
        <thead>
        <tr>
            {% for field in entity.fieldList %}
				{% if field.isPrimaryKey=="0" %}
                    <th width="80" align="center">{{field.label}}</th>
                {% endif %}
			{% endfor %}
        </tr>
        </thead>
        <tbody>
        
            <#list page.list as item>
        
        <tr target="sid_user" rel="${item.id}">
            {% for field in entity.fieldList %}
				{% if field.isPrimaryKey=="0" %}
                    <td>
                        ${item.{{field.name}} }
                    </td>
                {% endif %}
			{% endfor %}
        </tr>
        </#list>
        </tbody>
    </table>
    <div class="panelBar">
        <div class="pages">
            <span>显示</span>
            <select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
            <span>条，共${page.totalRow}条</span>
        </div>

        <div class="pagination" targetType="navTab" totalCount="${page.totalRow}"
             numPerPage="${page.pageSize}" pageNumShown="${page.pageSize}"
             currentPage="${page.pageNumber}"></div>

    </div>
</div>


