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

<a style="float:right;font-size:20px;font-weight:bold;margin-right:15px" href='<ssf:url action="view_folder_listing" binderId="${ssFolder.id}"><ssf:param name="displayStyle" value="iframe"/></ssf:url>'> <img style="margin-bottom:-5px;" src="<%=fullUrl %>pics/backarrow.png" width="25px" height="25px"/>&nbsp; &nbsp;Retour rubrique </a>
