<div class="modal-header">
  <a class="close" ng-click="$dismiss()">&times;</a>
  <h4 class="modal-title">{{ title }}</h4>
</div>
<div class="modal-body">
  <form class="form-horizontal" name="form" ng-submit="confirm()">
    {% for field in entity.fieldList %}{% if field.isPrimaryKey!=1 %}
    <div class="form-group">
      <label class="col-sm-3 control-label"><i class="text-danger">*</i> {{field.label}}：</label>
      <div class="col-sm-7">
        <input type="text" class="form-control" name="{{field.javaName}}" placeholder="请输入{{field.label}}" ng-model="entity.{{field.javaName}}" required />
      </div>
    </div>
    {% endif %}{% endfor %}
  </form>
</div>
<div class="modal-footer">
  <button class="btn btn-primary" ng-click="confirm()" ng-disabled="form.$invalid || entity.creating|| entity.updating">
    <span ng-if="!entity.creating &amp;&amp; !entity.updating">确定</span>
    <span ng-if="entity.creating || entity.updating">处理中...</span>
  </button>
  <button class="btn btn-default" ng-click="$dismiss()">取消</button>
</div>