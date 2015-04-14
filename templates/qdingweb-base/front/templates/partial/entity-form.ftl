<div class="modal-header">
  <a class="close" ng-click="$dismiss()">&times;</a>
  <h4 class="modal-title">{{ title }}</h4>
</div>
<div class="modal-body">
  <form class="form-horizontal" name="form" ng-submit="confirm()">
    <div class="form-group">
      <label class="col-sm-3 control-label"><i class="text-danger">*</i> 姓名：</label>
      <div class="col-sm-7">
        <input type="text" class="form-control" name="name" placeholder="请输入用户姓名" ng-model="entity.name" required />
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label"><i class="text-danger">*</i> 邮箱：</label>
      <div class="col-sm-7">
        <input type="text" class="form-control" name="email" placeholder="请输入用户邮箱" ng-model="entity.email" required />
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label"><i class="text-danger">*</i> 手机号：</label>
      <div class="col-sm-7">
        <input type="text" class="form-control" name="mobile" placeholder="请输入用户手机号" ng-model="entity.mobile" required />
      </div>
    </div>
  </form>
</div>
<div class="modal-footer">
  <button class="btn btn-primary" ng-click="confirm()" ng-disabled="form.$invalid || entity.creating|| entity.updating">
    <span ng-if="!entity.creating &amp;&amp; !entity.updating">确定</span>
    <span ng-if="entity.creating || entity.updating">处理中...</span>
  </button>
  <button class="btn btn-default" ng-click="$dismiss()">取消</button>
</div>