
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

<style type="text/css">
		@font-face {
			font-family: cool_font;
			src: url('<%=fullUrl %>/fonts/GeosansLight.ttf');
		}
		
</style>

<c:set var="entryDefs" value="${ssBinder.entryDefinitions}"/>
<c:forEach var="entryDefsScan" items="${entryDefs}">
	<c:if test="${entryDefsScan.name == 'picture_form'}">
		<c:set var="entryDef" value="${entryDefsScan}"/>
	</c:if>
</c:forEach>

<link rel="stylesheet" href="<%=fullUrl %>css/basic.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=fullUrl %>css/pictures.css" />


<script type="text/javascript" src="<html:rootPath/>js/forum/ss_folder.js"></script>
<script type="text/javascript" src="<%=fullUrl %>/js/jquery.js"></script>
<script type="text/javascript">
          
	$(document).ready(function(){	 
	
	    $("label#addButton").click(function(){
		    
	    	
	    	if ( $("div#addNewEntry_toggle").css("display") == "none"){
	   		    $("div#addNewEntry_toggle").toggle();
			    $("div#addNewEntries").css("display","none");
		    }
		    $("iframe#iframe_addNewEntry").attr("src", '<ssf:url action="add_folder_entry" binderId="${ssBinder.id}">
		   		 	<ssf:param name="entryType" value="${entryDef.id}" /></ssf:url>');		    
		    
	    });	
	    
	    $("label#addButton2").click(function(){	    

   		    $("div#addNewEntries").toggle();   		    
   		    $("div#addNewEntry_toggle").css("display","none");
		    ss_showFolderAddAttachmentDropbox('_ss_forum_', '${ssFolder.id}','true');
	    });
	    
	    
	    $("a#nextpage").click(function(){
		   ss_showFolderPageIndex(this.href, '341', '2', 'ss_folder_view_common_ss_forum_', '', '', '', '');
		   return false; 
	    });
	    
	    if ( ${ssPageCurrent} == ${ssPageLast} ){
		    $("a.nav_NextPage").attr("href","#");
	    }
	});
</script>






<div class="main">
		<div id="actionDiv">
			<div id="buttonDiv">
				<label id="addButton" class="addButton_style">
					Ajouter une photo
				</label> &nbsp;&nbsp;				
				<label id="addButton2" class="addButton_style">
					Ajouter des photos
				</label>
			</div>				
			
			
							
			<div id="addNewEntries" class="addNewEntries" style="display:none;" >		 	
				<div id="ss_div_folder_dropbox${ssFolder.id}${renderResponse.namespace}" 
				  style="display:none;background-color:#fff;width:500px;">
				        <div align="right">
				                <a onClick="ss_hideFolderAddAttachmentDropbox('${renderResponse.namespace}','${ssFolder.id}'); return false;">
				                   <img border="0" src="<html:imagesPath/>icons/close_off.gif" <ssf:alt tag="alt.hideThisMenu"/> />
				                </a>
				        </div>
				        <iframe frameborder="0" scrolling="auto" 
				            id="ss_iframe_folder_dropbox${ssFolder.id}${renderResponse.namespace}" 
				            name="ss_iframe_folder_dropbox${ssFolder.id}${renderResponse.namespace}"
				            title="<ssf:nlt tag="toolbar.menu.dropBox.title"/>" 
				            src="<html:rootPath/>js/forum/null.html" 
				            height="80%" width="96%" style="padding:6px;">Novell Vibe</iframe>
				 </div>
			</div>			
			

		</div>
			<div id="addNewEntry_toggle" class="addNewEntry_toggle" >	
				<iframe id="iframe_addNewEntry" style="margin-top: 50px;"  frameborder="0" 
					src="" width="100%" height="100%" name="gwtContentIframe"></iframe>
		   	</div>
		 <div class="ss_clear"></div>
				
				
			<div id="col">
			
				<div id="gallery" style="width: 30%; float:left; margin-top: 66px;">
					<div style="width: 200px; margin-left: 30px;">

						<a  style="" class="nav_PrevPage" href='<ssf:url binderId="${ssBinder.id}" action="view_folder_listing">
			   		 	<ssf:param name="operation" value="save_folder_page_info" />
			   			<ssf:param name="ssPageStartIndex" value="${ssPagePrevious.ssPageInternalValue}"/> 	
				   			</ssf:url>'>  <img width="16px" height="16px" src='<%=fullUrl %>/pics/PreviousArrow.jpg' /> </a>
				   			
				   		<span style="margin-left: 15%; margin-right: 15%;">
					   		Page ${ssPageCurrent} de ${ssPageLast}
				   		</span>
				   		

				   		<a class="nav_NextPage" style=""  href='<ssf:url binderId="${ssBinder.id}" action="view_folder_listing">
				   		 	<ssf:param name="operation" value="save_folder_page_info" />
				   			<ssf:param name="ssPageStartIndex" value="${ssPageNext.ssPageInternalValue}"/> 	
				   		</ssf:url>'><img width="16px" height="16px" src='<%=fullUrl %>/pics/NextArrow.jpg' /></a>	   		
			   		</div>
					<ul>

							<c:forEach var="entry" items="${ssFolderEntries}"> 		
							<li>							
								<script type="text/javascript">         

									$(document).ready(function(){

									    $("a#thumbs_${entry._docId}").click(function(){
									    	$("div#viewPicture img").fadeOut("quick", function(){ 									    	
										    	 $("div#viewPicture img").attr("src", '<ssf:fileUrl search="${entry}"/>');									 
										    	 $("p.pictureTitle").html("${entry.title}");	
										    	 $("p.pictureDescription").html("${entry._desc}");											    	 									    	
									    	});	
										    $("div#viewPicture img").fadeIn("slow");
										    
									    });			
									
									
									    $("a#deleteButton_${entry._docId}").click(function(){		
				
									      $("iframe.deleteBox").attr("src",'<ssf:url action="modify_folder_entry" binderId="${ssBinder.id}">
										   		 	<ssf:param name="entryId" value="${entry._docId}" />
										   		 	<ssf:param name="entryType" value="${entryDef.id}" />
										   		 	<ssf:param name="operation" value="delete" />
									   		 	</ssf:url>');			
									   		
								   		 });
								   		 
								   		  $("a#editButton_${entry._docId}").click(function(){	
								   		  
								   		  		if ( $("div#addNewEntry_toggle").css("display") == "none" ){
										   		    $("div#addNewEntry_toggle").toggle();									   		  		
	    										    $("div#addNewEntries").css("display","none");
								   		  		}	

	
											    $("iframe#iframe_addNewEntry").attr("src",'<ssf:url action="modify_folder_entry" binderId="${ssBinder.id}">
											   		 	<ssf:param name="entryId" value="${entry._docId}" />
											   		 	<ssf:param name="entryType" value="${entryDef.id}" />	
										   		 	</ssf:url>');		
										   		 	

										   		
									   	}); 
								   		 
								   	});
								   	
								</script>
									<a href='#' title="${entry.title}" id="thumbs_${entry._docId}" class="thumbs">
							    		<img class="thumbs" width="54" height="54px" border="0" src='<ssf:fileUrl webPath="readThumbnail" search="${entry}"/>' alt="First" title="First image" />			    			
							    	</a>			

							    	<span><a style="vertical-align: top;" href="#" id="deleteButton_${entry._docId}" class="deleteButton" style=""><img src="<%=fullUrl %>/pics/delete-icon.png" style="width:8px; vertical-align: top" /></a>
							    	<a style="vertical-align: top;" href="#" id="editButton_${entry._docId}" class="editButton" style=""><img src="<%=fullUrl %>/pics/edit.png" style="width:8px; vertical-align: top" /></a>				    								    </span>

							</li>
							</c:forEach>			    	

					</ul>
				</div>
				
			
				<div id="col2" style="float: right; width: 65%; ">
					<div id="pictureInfo">
						<p class="pictureTitle" style="font-family: cool_font; font-size: 21px;"></p>
						<p class="pictureDescription" style="font-family: cool_font; font-size: 16px;"></p>
					</div>					
				
					<div id="viewPicture" class="viewPicture" >
						<img class="picture" src="" style="display: none;max-width:700px; max-height:700px; border:10px solid #000;"/>
					</div>	
				</div>
				
			</div>
				
				
          
								


					 
					 
<!--		 <img src="<ssf:fileUrl search="${entry}"/>"> -->
		 <div class="ss_clear"></div>

		 <iframe frameborder="0"  class="deleteBox" style="display:none"></iframe>

</div> 


 
 






