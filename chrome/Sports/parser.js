//var validStr=['NBA','巴塞罗那','皇家马德里','广州恒大','曼联','欧冠','斯诺克']; 

function validEvent(str){
  for(var i =0; i<validStr.length;i++){
    var index = str.indexOf(validStr[i]);
    if(index !=-1){
      return true;
    }
  }
  return false;
}



//arr of [date,title(str)]
function renderEvent(arr) {
  var line = '<HR style="FILTER: alpha(opacity=100,finishopacity=0,style=1)" width="80%" color=#987cb9 SIZE=3>';
  var result = '';
  var date = '';

  for (var i =0; i<arr.length; i++){
    var event = arr[i];
    var d = new Date(event[0]);
    var t = event[1];
	var h = event[2];
    if (i==0 || (new Date(arr[i-1][0])).sbdate() != d.sbdate()){
      result += '<span class=\"livedate\">' + line + d.sbdate() + '</span>' ;
    }
 
	var live = 'live';
	var timeleft = d.getTime() - (new Date()).getTime();
	if (timeleft > 10*60) live = '';
    result +=  '<span class=\"eventlink '+live+'\">    '  + d.sbtime()  + 
		' <span class=\"jumpout\" href=\"'+h + '\">' +t + '</span>    </span>'; 
  
  }

  document.getElementById("event").innerHTML = result;
}

//get date format for azhibo
function dateazhibo(daytime){
	var date = '';
	var cdate = new Date();
	var cm = cdate.getMonth();
	var cy = cdate.getFullYear();

    var indexm = daytime.indexOf('月');
    var indexd = daytime.indexOf('日');
	if (indexm != -1 && indexd > indexm) {
		var m = daytime.substr(0,indexm);
		var d = daytime.substr(indexm+1, indexd-indexm-1);
		var y = cy;
		if (cm == 12 && m == 1) y = cy +1;
		date = y+'-'+m+'-'+d;
	}

	return date;
}
//x is the xml ; for azhibo spidersrc=1
function parserazhibo(x){

  if(!x){
    console.log("not valid xml input");
  }
  //var filters = optionfilters();
  //validStr = filters;
  matchcont = x.getElementsByClassName('match-cont');
  matchdays = matchcont[0].getElementsByClassName('day all');

  var rarr = [];

  for (var i=0; i<matchdays.length ;i++)
  {
    var box = matchdays[i];
	// get date for day-box
    var daytime = box.getElementsByClassName('title')[0].innerText.trim();
	var date = dateazhibo(daytime);

    var lis = box.getElementsByTagName('li');
    //var d = new Date(t + ' GMT+0800');
    for (var j=0; j<lis.length;j++){
      var li = lis[j];
      var lic = li.cloneNode(true);
      var nameblock = lic.getElementsByClassName('name ')[0];
      
	  var title = nameblock.title.trim();
	  var href = nameblock.href;

	  var time = lic.getElementsByClassName('time ')[0].innerText.trim();
      if(validEvent(title)){
        
		var d1 = new Date(date + ' ' + time + ' GMT+0800' );
        var arr = [d1.getTime(),title,href];
        rarr[rarr.length] = arr;
      }               
    }
  }
  saveCache(rarr);
  showCache();
  //renderEvent(rarr);
}


//x is the xml 
function parserXML(x){

  if(!x){
    console.log("not valid xml input");
  }
  l = x.getElementById('left');
  boxes = l.getElementsByClassName('box');
    
  var rarr = [];

  for (var i=0; i<boxes.length ;i++)
  {
    var box = boxes[i];
    var t = box.getElementsByClassName('titlebar')[0].getElementsByTagName('h2')[0].title;
    var lis = box.getElementsByTagName('li');
    //var d = new Date(t + ' GMT+0800');
    for (var j=0; j<lis.length;j++){
      var li = lis[j];
      var lic = li.cloneNode(true);
      var as = lic.getElementsByTagName('a');
      for(var l=as.length-1; l>=0;l--)
      {
         lic.removeChild(as[l]);
      }
      var li_title = lic.innerText.trim();
      if(validEvent(li_title)){
        var index = li_title.indexOf(":");
        if (index == -1) continue;
        var t1 = li_title.substr(index-2,5);
        var event_title = li_title.substr(index+3);

        var d1 = new Date(t + ' ' + t1 + ' GMT+0800' );
        var arr = [d1.getTime(),event_title];
        rarr[rarr.length] = arr;
      }               
    }
  }
  saveCache(rarr);
  showCache();
  //renderEvent(rarr);
}

function saveCache(arr){
  if(!arr){
    console.log('arr=nil, cant save arr');
    return;
  }
  $.jStorage.set('cache',arr);
}

function showCache(){
  var arr = $.jStorage.get('cache');
  if(!arr){
    console.log('cache in null');
    return;
  }
  console.log('cache load successfully');
  renderEvent(arr);

  var links = document.getElementsByClassName("jumpout");
    for (var i = 0; i < links.length; i++) {
        (function () {
            var ln = links[i];
            var location = ln.href;
            ln.onclick = function () {
                chrome.tabs.create({active: true, url: location});
            };
        })();
    }

  window.resizeTo(800,800);
}


