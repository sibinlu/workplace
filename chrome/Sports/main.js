function closeAndReloadPopup() {
  if (SAFARI) {
    safari.self.hide();
    setTimeout(function() {
      window.location.reload();
    }, 200);
  } else {
    window.close();
  }
}

function todo(){
  
  var timer=setInterval(function(){ 
    showCache(); 
    window.scrollTo(0,0); 
    clearInterval(timer); 
    gethtml();
  },"100");
}

function refresh(){
  gethtml();
}

function setting(){
    //gethtml();
    chrome.runtime.openOptionsPage(function(){
      closeAndReloadPopup();
    });
    
}

document.addEventListener('DOMContentLoaded', function() {
  todo();
  document.getElementById('refresh').addEventListener('click',refresh);
  document.getElementById('setting').addEventListener('click',setting);
     
});

//window.onload=todo;