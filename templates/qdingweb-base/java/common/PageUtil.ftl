package {{project.packageName}}.common;

import java.util.HashMap;

public class PageUtil {
	
	public static HashMap<String,Object> getPageMap(HashMap<String,Object> map){
		if(map!=null){
			Integer _start = (Integer)map.get("page");
			Integer _size =  (Integer)map.get("size");
			int startIndex = 0;
			if(_start!=null && _size!=null){
				if(_start>=1){
					startIndex = (_start - 1)*_size;
				}else{
					_start = 0;
					_size = 10;
					startIndex = 0;
				}
			}else{
				_start = 0;
				_size = 10;
				startIndex = 0;
			}
			map.put("pageNo", _start);
			map.put("pageSize", _size);
			map.put("startIndex", startIndex);
			
		}
		return map;
	}

}
