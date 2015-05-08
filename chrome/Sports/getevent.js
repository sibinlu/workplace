var validStr=['NBA','巴塞罗那','皇家马德里','广州恒大','曼联','欧冠','斯诺克','网球']; 

String.prototype.trim = function()  
{  
  return this.replace(/(^\s*)|(\s*$)/g, "");  
}



// 对Date的扩展，将 Date 转化为指定格式的String 
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: meizz 
  var o = { 
    "M+" : this.getMonth()+1,                 //月份 
    "d+" : this.getDate(),                    //日 
    "h+" : this.getHours(),                   //小时 
    "m+" : this.getMinutes(),                 //分 
    "s+" : this.getSeconds(),                 //秒 
    "q+" : Math.floor((this.getMonth()+3)/3), //季度 
    "S"  : this.getMilliseconds()             //毫秒 
  }; 
  if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
  return fmt; 
}

Date.prototype.sbdate = function()  
{  
  return this.Format("yyyy-MM-dd");  
}

Date.prototype.sbtime = function()  
{  
  return this.Format("hh:mm");  
}

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
    if (i==0 || arr[i-1][0].sbdate() != arr[i][0].sbdate()){
      result += '<h1>' + line + arr[i][0].sbdate() + '</h1>' ;
    }
    var event = arr[i];
    var d = event[0];
    var t = event[1];
    result +=  '<h2>    '  + d.sbtime() + ' ' + t + '    </h2>'; 
    if (i==arr.length-1 || arr[i+1][0].sbdate() != arr[i][0].sbdate()){
      //result += '<br>' + line + arr[i][0].sbdate() + '<br>' ;
    }
  }
  result += '</ul>';

  document.getElementById("event").innerHTML = result;
}

function gethtml(){
  
  var url = "http://www.zhibo8.cc/";
  var xhr = new XMLHttpRequest();
  xhr.onload = function() {

    var x = this.responseXML;
    l = x.getElementById('left');
    boxes = l.getElementsByClassName('box');
    
    var rarr = [];

    for (var i=0; i<boxes.length ;i++)
    {
      var box = boxes[i];
      var t = box.getElementsByClassName('titlebar')[0].getElementsByTagName('h2')[0].title;
      var lis = box.getElementsByTagName('li');

      var d = new Date(t + ' GMT+0800');
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
            var arr = [d1,event_title];
            rarr[rarr.length] = arr;

          }
                     
      }
    }
    renderEvent(rarr);
  }
  xhr.open("GET", url);
  xhr.setRequestHeader("Access-Control-Allow-Origin", "*"); 
  xhr.responseType = "document";
  xhr.send();
}

function todo(){
  gethtml()
  //renderEvent("a event");
}


document.addEventListener('DOMContentLoaded', function() {
  todo();
});



//window.onload=todo;