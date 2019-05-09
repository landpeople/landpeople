function search() {
    var jsonObj = {};
    var jsonObj2 = {};
    
//    if($("#selectId").val() != "C") {
//        jsonObj.serviceImplYn = $("#selectId").val();
//    }
    jsonObj.serviceImplYn = $("#selectId").val();
    jsonObj2.input = $("#input").val();
    
//    alert(JSON.stringify(jsonObj));
    
    $("#jqGrid").setGridParam({
        datatype : "json",
        postData : {"param" : JSON.stringify(jsonObj), "param2" : JSON.stringify(jsonObj2)},
        loadComplete : function(data) {
            
        },
        
        gridComplete : function() {
            
        }
    }).trigger("reloadGrid");
}
	
	

