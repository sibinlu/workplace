String.prototype.trim = function()  
{  
  return this.replace(/(^\s*)|(\s*$)/g, "");  
}

//convert string to xml object 
function String2XML(xmlString) { 
  // for IE 
  if (window.ActiveXObject) { 
    var xmlobject = new ActiveXObject("Microsoft.XMLDOM"); 
    xmlobject.async = "false"; 
    xmlobject.loadXML(xmlString); 
    return xmlobject; 
  } 
  // for other browsers 
  else { 
    var parser = new DOMParser(); 
    var xmlobject = parser.parseFromString(xmlString, "text/xml"); 
    return xmlobject; 
  } 
}
 
//convert xml object to string 
function XML2String(xmlObject) { 
  // for IE 
  if (window.ActiveXObject) { 
    return xmlObject.xml; 
  } 
  // for other browsers 
  else { 
    return (new XMLSerializer()).serializeToString(xmlObject); 
  } 
} 