		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse"><div></div></div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse"><h2>主菜单</h2><div>收缩</div></div>
				<div class="accordion" fillSpace="sidebar">
					<div class="accordionHeader">
						<h2><span>Folder</span>管理</h2>
					</div>
					<div class="accordionContent">
						{% for entity in project.entityList %}
						<ul class="tree treeFolder">
							<li><a href="${PATH}/{{entity.name}}/" target="navTab" rel="rel_{{entity.name}}">{{entity.label}}管理</a>
								
							</li>
						</ul>
						{% endfor %}
					</div>
				</div>
			</div>
		</div>
		
		
		