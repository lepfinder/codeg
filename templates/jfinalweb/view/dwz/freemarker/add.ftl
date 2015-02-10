<div class="pageContent">
	<form method="post" action="${PATH}/{{entity.name}}/save" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<#include "_form.html">
	</form>
</div>