<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<style type="text/css">
.mouseOver{
background: #708090;
color: #FFFAFA;
}

.mouseOut{
background: #FFFAFA;
color: #000000;
}
</style>
<script type="text/javascript">
var xmlHttp;
function getMoreContents() {
	//获得用户输入
	var content=document.getElementById("keyword");
	if(content.value==""){
		clearContent();
		return;
	}
	//给服务器发送输入的内容，使用XmlHttp对象
	xmlHttp=getXmlHttp();
	//给服务器发送数据
	var url="search?keyword="+escape(content.value);
	//和服务器建立连接,true表示脚本会在send方法后，继续执行
	xmlHttp.open("GET",url,true);
	//xmlHttp绑定回调方法，状态码包含0-4
	xmlHttp.onreadystatechange=callback;
	xmlHttp.send(null);
}
function callback() {
	if(xmlHttp.readyState==4){
		if(xmlHttp.status==200){
			var result=xmlHttp.responseText;
			var json=eval("("+result+")");
			//alert(json);
			setContent(json);
		}
	}
}

function getXmlHttp() {
	var xmlHttp;
	if(window.XMLHttpRequest){
		xmlHttp=new XMLHttpRequest();
	}
	if(window.ActiveXObject){
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		if(!xmlHttp){
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
	}
	return xmlHttp;
}

//设置关联数据的显示
function setContent(content) {
	clearContent();
	var size=content.length;
	for(var i=0;i<size;i++){
		var nextNode=content[i];
		var tr=document.createElement("tr");
		var td=document.createElement("td");
		var text=document.createTextNode(nextNode);
		td.setAttribute("bgcolor","#FFFAFA");
		td.setAttribute("border","0");
		td.onmouseover=function(){
			this.className='mouseOver';
			//document.getElementById("keyword").value=content[i];
		};
		td.onmouseout=function(){
			this.className='mouseOut';
		};
		td.appendChild(text);
		tr.appendChild(td);
		document.getElementById("context_table_body").appendChild(tr);
	}
}

function clearContent() {
	var contentTableBody=document.getElementById("context_table_body");
	var size=contentTableBody.childNodes.length;
	for(var i=size-1;i>=0;i--){
		contentTableBody.removeChild(contentTableBody.childNodes[i]);
	}
}

function keywordblur() {
	
	clearContent();
}
</script>
</head>
<body>
	<div id="searchDiv">
		<input type="text" size="50" id="keyword" onkeyup="getMoreContents()" onblur="keywordblur()" onfocus="getMoreContents()"> 
		<input type="button" width="50px" value="搜索一下">
		<div id="popDiv">
			<table id="context_table">
				<tbody id="context_table_body">
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>