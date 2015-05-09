function gethtml(){
  var url = "http://www.zhibo8.cc/";
  var xhr = new XMLHttpRequest();
  xhr.onload = function() {
    var x = this.responseXML;
    console.log('Get Html Success');
    
    parserXML(x);
  }
  xhr.open("GET", url);
  xhr.setRequestHeader("Access-Control-Allow-Origin", "*"); 
  xhr.responseType = "document";
  xhr.send();
}


