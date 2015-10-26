//0 : zhibo8 parserzhibo8  1 : azhibo parserazhibo
var spidersrc=1;


function gethtml(){
  var url = "http://www.zhibo8.cc/";
  if(spidersrc==1){
	  url = "http://www.azhibo.com/";
  }
  var xhr = new XMLHttpRequest();
  xhr.onload = function() {
    var x = this.responseXML;
    console.log('Get Html Success');
    
	if(spidersrc==0){
		parserXML(x);
	}
	else if (spidersrc==1){
		console.log("!azhibo:" + url);
		parserazhibo(x);
	}
  };
  xhr.onerror = function(){
    console.log("fail get html");
  };
  xhr.open("GET", url);
  xhr.setRequestHeader("Access-Control-Allow-Origin", "*"); 
  xhr.responseType = "document";
  xhr.send();
}


