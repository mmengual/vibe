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


<style type="text/css">
	.mainbody {
		height: 1080px;
		
	}

	.header {
		height: 50px;
		
	}
	.sendfile {
		margin-top: 50px;
		margin-left: 50px;
		float:left;
		width: 20%;
	}
	
	.footer {
		
		height: 50px;
	}
	
	table#hor-minimalist-a {
		width: 65%;		
	}
	
</style>


<script type="text/javascript" src="<%=fullUrl %>js/jquery.js" ></script>

<div class="ss_wiki_folder">
	<div class="wiki-content">
		<c:set var="entryDefs" value="${ssBinder.entryDefinitions}"/>
		<c:forEach var="entryDefsScan" items="${entryDefs}">
			<c:if test="${entryDefsScan.name == 'document'}">
				<c:set var="entryDef" value="${entryDefsScan}"/>
			</c:if>
		</c:forEach>

	</div>
</div>

<script>
		$("iframe#iframe_add_entry").ready(function(){ 				


			$("a#link_add_entry").click(function(){									
//	   		 	$("div.footer").show();
	   		 	$("div.header").fadeIn(500);
	   		 	
			});
		});									
	</script>

<div class="mainbody">
	<div class="header" style="display:none;height: 250px;">
		<iframe id="iframe_add_entry"  src='<ssf:url action="add_folder_entry" binderId="${ssBinder.id}"><ssf:param name="entryType" value="${entryDef.id}" /></ssf:url>' width="100%" height="250px" frameborder="0" name="gwtContentIframe"></iframe>

	</div>
	
	<!-- Left column div -->
	<div class="sendfile">								
			<label style="font-size:18px;font-weight:bold;"> Partager un fichier </label><br/>
			&nbsp;&nbsp;&nbsp;<a id="link_add_entry" href='#'><img src="<%=fullUrl %>pics/upload.png" width="110px" height="110px" /></a>
	</div>
	
	<div class="viewfile">			
		<table id="hor-minimalist-a" summary="2007 Major IT Companies' Profit">
		    <thead>
		    	<tr>
		        	<th scope="col">Fichier</th>
		            <th scope="col">Auteur</th>
		            <th scope="col">Date de cr&eacute;ation</th>
		
		        </tr>
		    </thead>
		        <tbody>
		     	<c:forEach var="entry" items="${ssFolderEntries}">
		     	<jsp:useBean id="entry" type="java.util.HashMap" />
			    	<tr>	    	
			     
			        	<td>			        					   								 				 								 
							 <script type="text/javascript">					
									$("iframe#iframe_view_entry").ready(function(){ 									
										$("a#view_entry_${entry._docId}").click(function(){		
										
											var entryId = $(this).attr('class');
											var link = '<ssf:url action="view_folder_entry" entryId="${entry._docId}" binderId="${ssBinder.id}">
											<ssf:param name="namespace" value="_ss_forum_" />
								   		 	<ssf:param name="entryViewStyle" value="iframe"	/>
								   		 	<ssf:param name="displayStyle" value="iframe" /></ssf:url> ';
						
											$("iframe#iframe_view_entry").attr("src",link);											
										});
									});		
							 </script>				 
				 
							 <a  id="view_entry_${entry._docId}" class="view_entry" href="#"> 
							   		 	<c:out value="${entry.title}" escapeXml="true" /></a>							                                                 			
			   <br/>							 
			   </td>	            	            	
			            <td>${entry._creatorTitle}</td>
			            <td>  <span class="ss_nowrap" ><fmt:formatDate timeZone="${ssUser.timeZone.ID}"
						     value="${entry._lastActivity}" type="both" 
							 timeStyle="short" dateStyle="short" /></span></td>	
			        </tr>
		     	</c:forEach>
		     </tbody>
		</table>

	</div>			
	
	<div class="footer" style="">
			<iframe id="iframe_view_entry" src="" width="100%" height="500px" frameborder="0" name="gwtContentIframe"></iframe>
	</div>		
</div>	


		
		
<style type="text/css">
<!--
@import url("<%=fullUrl %>css/tablestyle.css");
-->
</style>

