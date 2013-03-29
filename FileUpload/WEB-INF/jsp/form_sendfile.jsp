<%@ include file="/WEB-INF/jsp/definition_elements/init.jsp" %>
<%@ page import="org.kablink.teaming.domain.Binder" %>
<%@ page import="org.dom4j.tree.DefaultDocument" %>
<%@ page import="org.kablink.teaming.context.request.RequestContextHolder" %>
<%@ page import="org.kablink.teaming.web.WebKeys" %>
<%@ page import="org.kablink.teaming.ObjectKeys" %>
<%@ page import="org.dom4j.Document" %>

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


<br/>	


<style type="text/css" >

	div.ss_ClipboardUsersPane {
		display: none;
			
	}
</style>

<script type="text/javascript" src="/ssf/js/jquery.js"></script>
<script>
	$(document).ready(function(){
	

			
	

	});
	

	
</script>

