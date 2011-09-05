function $get(key,url){
	    if(arguments.length < 2) url =location.href;
	    if(arguments.length > 0 && key != ""){
	        if(key == "#"){
	            var regex = new RegExp("[#]([^$]*)");
	        } else if(key == "?"){
	            var regex = new RegExp("[?]([^#$]*)");
	        } else {
	            var regex = new RegExp("[?&]"+key+"=([^&#]*)");
	        }
	        var results = regex.exec(url);
	        return (results == null )? "" : results[1];
	    } else {
	        url = url.split("?");
	        var results = {};
	            if(url.length > 1){
	                url = url[1].split("#");
	                if(url.length > 1) results["hash"] = url[1];
	                url[0].split("&").each(function(item,index){
	                    item = item.split("=");
	                    results[item[0]] = item[1];
	                });
	            }
	        return results;
	    }
}
