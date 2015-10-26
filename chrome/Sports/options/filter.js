var defaultfilter="NBA,巴塞罗那,皇家马德里,广州恒大,曼联,欧冠,斯诺克,网球";
var validStr=['NBA','巴塞罗那','皇家马德里','广州恒大','曼联','欧冠','斯诺克'];
function optionfilters(){
	chrome.storage.sync.get({
    filter: defaultfilter
  }, function(items) {
    validStr= items.filter.split(",");
  });
}
