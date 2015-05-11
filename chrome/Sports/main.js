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

document.addEventListener('DOMContentLoaded', function() {
  todo();
  document.getElementById('refresh').addEventListener('click',refresh);
});

//window.onload=todo;