<div class="page-header">
  <h1>用户</h1>
</div>
<div class="filter clearfix">
  <div class="row">
    <div class="col-sm-8">
      <form class="form-inline" ng-submit="query()">
        <div class="form-group mb10 mr10">
          <label class="control-label text-normal">姓名：</label>
          <input type="text" class="form-control" ng-model="key" />
        </div>
        <div class="mb10 mr10">
          <button type="submit" class="btn btn-primary ml10" ng-disabled="form.$invalid">
          <i class="fa fa-search"></i> 搜索
          </button>
        </div>
      </form>
    </div>
    <div class="col-sm-4 text-right">
      <a class="btn btn-success" ng-click="create()"><i class="fa fa-plus"></i> 添加</a>
    </div>
  </div>
</div>
<table class="table table-hover">
  <thead>
    <tr>
      <th>名称</th>
      <!-- <th>更新人</th> -->
      <th>邮箱</th>
      
      <th class="text-right">操作</th>
    </tr>
  </thead>
  <tbody>
    <tr ng-if="loading">
      <td class="loading-holder" colspan="40">
        <div class="text-center"><span class="loading"></span></div>
      </td>
    </tr>
    <tr ng-if="total === 0">
      <td colspan="40">
        <div class="text-center">抱歉，没有相关数据</div>
      </td>
    </tr>
    <tr ng-repeat="item in list">
      <td ng-bind="item.name"></td>
      <td ng-bind="item.email"></td>
      
      <td class="text-right">
        <a href="" ng-click="update(item)" ng-if="!item.updating">修改</a>
        <span class="loading-sm" ng-if="item.updating"></span>
        <i class="text-divider" >|</i>
        <a href="" ng-click="remove(item)" ng-if="!item.deleting">删除</a>
        <span class="loading-sm" ng-if="item.deleting"></span>
      </td>
    </tr>
  </tbody>
</table>
<div class="text-right" ng-show="!(list|empty)">
<ul class="pagination-sm" pagination ng-model="page" items-per-page="size" total-items="total" ng-change="query()"></ul>
</div>