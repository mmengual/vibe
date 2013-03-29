<%@ include file="/WEB-INF/jsp/definition_elements/init.jsp" %>
<%@ page import="org.kablink.teaming.domain.Binder" %>
<%@ page import="org.dom4j.tree.DefaultDocument" %>
<%@ page import="org.kablink.teaming.context.request.RequestContextHolder" %>
<%@ page import="org.kablink.teaming.web.WebKeys" %>
<%@ page import="org.kablink.teaming.ObjectKeys" %>
<%@ page import="org.dom4j.Document" %>
<script type="text/javascript" src="<html:rootPath/>js/forum/ss_entry.js"></script>

<%
	org.kablink.teaming.domain.Binder ssBinder = (org.kablink.teaming.domain.Binder)pageContext.getAttribute("ssBinder", PageContext.REQUEST_SCOPE);	
	String zoneId = Long.toString(ssBinder.getZoneId());		
	String url="";		
	String extensionName = ((Document) pageContext.getRequest()
						.getAttribute(WebKeys.CONFIG_DEFINITION)).getRootElement()
						.attributeValue(ObjectKeys.XTAG_ATTRIBUTE_EXTENSION, "");
	String fullUrl="";

	if ( ssBinder.getZoneId() == 1){						
		fullUrl = ((HttpServletRequest)pageContext.getRequest()).getContextPath() +  "/ext/" + RequestContextHolder.getRequestContext().getZoneName() +
						"/" + extensionName + "/" + url;
	}
	else{
		fullUrl = ((HttpServletRequest)pageContext.getRequest()).getContextPath() +  "/ext/" + RequestContextHolder.getRequestContext().getZoneName() +"_"+zoneId+"/" + extensionName +"/" + url;	
	}
		
%>

<script type="text/javascript" src="<html:rootPath/>js/forum/ss_folder.js"></script>
<script type="text/javascript" src="<%=fullUrl %>/js/jquery.js"></script>
<script type="text/javascript">         
	$(document).ready(function(){	
	

		function getParameterByName(name) {
		    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
		    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
		}
		if (getParameterByName("operation") == "delete"){
			ss_postToThisUrl(window.location);
		}
		
		
		if (getParameterByName("action") == "modify_folder_entry"){
			$("input.submitfile").hide();
		}
	});
</script>


<style type="text/css">
	div#addPicture_main label {
		width: 80px;
		float: left;
		text-align: right;
		margin-right: 10px;
		margin-top: 3px;
	}
	
	
	input.submitfile{
		width: 300px;
		margin-left: 90px;
	}	

	div#addPicture_main textarea{	
		width: 300px;
		height: 100px;
	}
	
	div#addPicture_main{
		width: 500px;
	}
	

</style>


<div id="addPicture_main">
	<p><label for="title"> Titre :  </label><input type="text" id="title" name="title" value="${ssDefinitionEntry.title}" /></p>
	<p><label for="title"> Description :  </label><textarea type="text" id="description" name="description">${ssDefinitionEntry.description}</textarea>  </p>
	<p><input type="file" class="ss_text submitfile" name="image" id="image" size="30"></p>	

	<p><input type="submit" style="width: 35px;" class="ss_submit" name="okBtn" value="OK" onclick="ss_buttonSelect('okBtn'); "></p>
	
</div>

