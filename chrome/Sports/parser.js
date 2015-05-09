var validStr=['NBA','巴塞罗那','皇家马德里','广州恒大','曼联','欧冠','斯诺克','网球']; 

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
    if (i==0 || (new Date(arr[i-1][0])).sbdate() != d.sbdate()){
      result += '<h1>' + line + d.sbdate() + '</h1>' ;
    }
    
    result +=  '<h2>    '  + d.sbtime() + ' ' + t + '    </h2>'; 
  
  }

  document.getElementById("event").innerHTML = result;
}

//x is the xml 
function parserXML(x){
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
  console.log('cache load successfully');
  renderEvent(arr);
}


