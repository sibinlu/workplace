var defaultfilter="巴塞罗那,皇家马德里,广州恒大,曼联";
var defaultfilterleague="NBA,欧冠,斯诺克,网球";
var validStr=['巴塞罗那','皇家马德里'];
var validStrleague=['NBA','斯诺克'];
function optionfilters(){
	chrome.storage.sync.get({
    filter: defaultfilter,
	filterleague: defaultfilterleague
  }, function(items) {
    validStr= items.filter.split(",");
	validStrleague = items.filterleague.split(",");
  });
}
