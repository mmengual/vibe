<%@ include file="/WEB-INF/jsp/definition_elements/init.jsp" %>

<jsp:useBean id="property_name" type="String" scope="request" />
<jsp:useBean id="property_caption" type="String" scope="request" />
<jsp:useBean id="ssConfigDefinition" type="org.dom4j.Document" scope="request" />
<jsp:useBean id="ssDefinitionEntry" type="java.lang.Object" scope="request" />
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

<link rel="stylesheet" type="text/css" href="<%=fullUrl %>css/commonstyle.css" />
<link rel="stylesheet" type="text/css" href="<%=fullUrl %>css/wikistyles.css" />




<br/>	

 <c:forEach var="entry" items="${ssFolderEntries}">
	 <c:if test="${entry._docId == ssEntryIdToBeShown}">
      <c:set var="ssEntryToBeShown" value="${entry}" />
    </c:if>
 </c:forEach>



<script type="text/javascript">
var ss_showAsWiki = false;
if (self.window.name.indexOf("gwtContentIframe") == 0) {
	ss_showAsWiki = true;  //Indicate that we are showing a wiki folder so wiki links don't pop-up
}
var ss_columnCount = 0;

//Routine called when "find wiki page" is clicked
function ss_loadWikiEntryId${renderResponse.namespace}(id) {
	var urlParams = {entryId:id, namespace:'${renderResponse.namespace}', entryViewStyle:'popup'};
	var url = ss_buildAdapterUrl(ss_AjaxBaseUrl, urlParams, "view_folder_listing");
	self.location.href = url;
}
	
</script>



<script type="text/javascript" src="<%=fullUrl %>js/jquery.js"></script>
<script>
	$(document).ready(function(){
	
	

		//Choix du type de champ de recherche
		$("div#radioSearch input").click(function(){
			if ( $("input#pageRadio").attr("checked") == "checked"){
				$("div#input_searchContent").hide();
				$("div#input_searchPage").show();
			}		
			
			if ( $("input#contentRadio").attr("checked") == "checked"){
				$("div#input_searchPage").hide();
				$("div#input_searchContent").show();				
			}
		});
	
		$("div#searchResults").hide();
		<c:choose>
			<c:when test="${!empty ssEntryIdToBeShown}">		

				var link = '<ssf:url action="view_folder_entry" entryId="${ssEntryToBeShown._docId}" binderId="${ssBinder.id}">
				<ssf:param name="namespace" value="_ss_forum_" />
	   		 	<ssf:param name="entryViewStyle" value="iframe"	/>
	   		 	<ssf:param name="displayStyle" value="iframe" /></ssf:url>';
								   		 	
			 	$("iframe#myiFrame").attr("src",link);
				$("h2.articleTitle").html("${ssEntryToBeShown.title}");	
					

			</c:when>
			<c:otherwise>

				var link = '<ssf:url action="view_folder_entry" entryId="${ssFolderEntries[0]._docId}" binderId="${ssBinder.id}">
				<ssf:param name="namespace" value="_ss_forum_" />
	   		 	<ssf:param name="entryViewStyle" value="iframe"	/>
	   		 	<ssf:param name="displayStyle" value="iframe" /></ssf:url>';
								   		 	
			 	$("iframe#myiFrame").attr("src",link);
				$("h2.articleTitle").html("${ssFolderEntries[0].title}");	
					

			</c:otherwise>
							
		</c:choose>

		var data_resultsCount =  "5";
		var binderId = ${ssBinder.id};
		
		
			
		$("div.ss_content_window").hide();		
		$("button.searchButton").click(function(){
				
			idChoices= 'searchFolders_${ssBinder.id}';

			var searchText=$("input#searchFieldInput").val();			
			var url = "/ssf/a/do?p_name=ss_forum&p_action=1&operation=ss_searchResults&tabTitle=&quickSearch=true&binderId="+${ssBinder.id}+"&data_resultsCount="+data_resultsCount+"&data_summaryWordCount=5&action=advanced_search&searchText="+searchText+"&newTab=1&vibeonprem_url=1&idChoices="+idChoices+" ul.ss_searchResult";


			
			$("div#searchResults_load").load(url, function() { $("div#searchResults").fadeIn("slow"); }); 			
			$("div#searchResults").css("visibility", "visible");

			$("p#searchResults_label").html("R&eacute;sultat de la recherche : "+searchText);
		});
		
		
		
		$("a#button_closeSearch").click(function(){
				$("div#searchResults").fadeOut("slow");			
		});
		
		
	});
	
	
	

		//$(window).unload(function() { alert('Handler for .unload() called.'); });

</script>




<% //Get home page %>
<c:set var="ss_wikiEntryBeingShown" value="${ss_wikiHomepageEntry}" scope="request"/>



<% //For each folder %>

 <c:set var="topWikiFolder" value="${ssBinder}"/>
<c:forEach var="blogPage" items="${ssBlogPages}">
  <c:set var="blogPageParentFound" value="false"/>
  <c:forEach var="blogPage2" items="${ssBlogPages}">
    <c:if test="${blogPage.parentBinder == blogPage2}">
      <c:set var="blogPageParentFound" value="true"/>
    </c:if>
  </c:forEach>
  <c:if test="${!blogPageParentFound}">
    <c:set var="topWikiFolder" value="${blogPage}"/>
  </c:if>
</c:forEach>


<c:if test="${!empty ssFolderEntries}">
	<a style="margin-left:20px;margin-bottom:-2px;font-weight:bold;font-size:18px;"  href='<ssf:url operation="modify" action="view_permalink" binderId="${ssFolderEntries[0]._topFolderId}">
		 	<ssf:param name="binderType" value="folder" />
		 	<ssf:param name="p_action" value="1" />
		 	<ssf:param name="_element" value="description" />
		 	<ssf:param name="binderType" value="folder" />
	 	</ssf:url>'><img style="margin-bottom:-2px" src="<%=fullUrl %>pics/backarrow.png" width="15px" height="15px"/>&nbsp;&nbsp;Revenir &agrave; la liste des rubriques</a> 	
</c:if>


<div class="ss_wiki_folder">
	<div class="wiki-content">
		<c:set var="entryDefs" value="${ssBinder.entryDefinitions}"/>
		<c:forEach var="entryDefsScan" items="${entryDefs}">
			<c:if test="${entryDefsScan.name == 'article'}">
				<c:set var="entryDef" value="${entryDefsScan}"/>
			</c:if>
		</c:forEach>

	</div>
</div>


<div id="maix-wiki">

	<div id="searchBox" style="">


		<div id="searchResults" >
				<div id="closeLink" style="float: right;"><a href="#" id="button_closeSearch">Fermer</a></div>
			<p id="searchResults_label" style="font-weight:bold;font-size:15px"></p>
			<div id="searchResults_load"></div>	
		</div>


		<div id="searchForm" >
			<div id="radioSearch" style="margin: 5px 5px 5px 5px;">
				<input type="radio" name="searchBox" id ="pageRadio" checked="checked"/> Page
				<input type="radio" name="searchBox" id="contentRadio" /> Contenu
			</div>
			
			<div id="input_searchPage" style="margin: 5px 5px 5px 5px;">
		      <c:if test="${ssConfigJspStyle != 'template'}">
		     

			    <form method="post" 
			        name="ss_findWikiPageForm${renderResponse.namespace}"
			        id="ss_findWikiPageForm${renderResponse.namespace}"
			    	action="<ssf:url action="view_folder_listing" actionUrl="true"><ssf:param 
							name="binderId" value="${ssBinder.id}"/><ssf:param 
							name="wiki_folder_list" value="true"/></ssf:url>">
		         	<img width="15px" height="15px" src="<%=fullUrl %>pics/magnifying-glass.jpg" />
				 <ssf:find formName="ss_findWikiPageForm${renderResponse.namespace}" 
				    formElement="searchTitle" 
				    type="entries"
				    width="100px" 
				    binderId="${ssBinder.id}"
				    searchSubFolders="true"
				    showFolderTitles="true"
				    singleItem="true"
				    clickRoutine="ss_loadWikiEntryId${renderResponse.namespace}"
				    accessibilityText="wiki.findPage"
				    /> 
				 <c:if test="${ss_showHelpIcon}">
				   <a class="ss_box_prev" href="${ss_nextPrevUrl}" 
				     onclick="ss_loadUrlInEntryFramePrev(this.href);return false;"
					 style="margin-left:10px;"
				   ><img src="<%=fullUrl %>images/pics/nl_left_noborder_16.png"
					 title="<ssf:nlt tag="nav.prevEntry"/>"></a>
				   <a class="ss_box_next" href="${ss_nextPrevUrl}" 
				     onclick="ss_loadUrlInEntryFrameNext(this.href);return false;"
					 style="margin-right:10px;"
				   ><img src="<%=fullUrl %>images/pics/nl_right_noborder_16.png"
					 title="<ssf:nlt tag="nav.nextEntry"/>"></a>
			  	   <a class="ss_actions_bar13_pane_none" href="javascript: window.print();"><img border="0" 
			         alt="<ssf:nlt tag="navigation.print"/>" title="<ssf:nlt tag="navigation.print"/>"
			         src="<%=fullUrl %>images/pics/masthead/masthead_printer.png" /></a>&nbsp;&nbsp;
			       <ssf:showHelp className="ss_actions_bar13_pane_none" guideName="user" pageId="entry" />
			     </c:if>
			    </form>
			  </c:if>
			  <span style="font-size:10px;"><ssf:nlt tag="wiki.findPage"/></span>
		  </div>
		  <div id="input_searchContent" style="display: none;">
			<div class="logo" style="margin: 5px 5px 5px 5px;">
				<p>
					<img width="15px" height="15px" src="<%=fullUrl %>pics/magnifying-glass.jpg" />	
					<input type="text" id="searchFieldInput" style="width:100px;" class="searchFieldInput" name="searchFieldInput" />
					<button class="searchButton" style="font-size:10px">Recherche </button>								
				</p>
			</div>
		  </div>
		</div>
	</div>

	
	<!-- Clear float and separate seach from content !-->
	<div style="clear:both; height:20px"></div>

	


	 <div id="header">
	 	 <div class="logo" style="position: absolute;">
	 	 	<img width="38px" height="38px"  src="<%=fullUrl %>pics/wiki-logo-circle.png" />
	 	 </div>
	 	  <div style="left:40px;">
		      <h2>${ssBinder.title}
			      			      <a class="ss_linkButton" href='<ssf:url operation="modify" action="modify_binder" binderId="${ssBinder.id}">
								   		 	<ssf:param name="binderType" value="folder" />
								   		 	<ssf:param name="p_action" value="1" />
								   		 	<ssf:param name="_element" value="description" />
								   		 	<ssf:param name="binderType" value="folder" />
								   		 	</ssf:url>' target="_blank"> 
								   		 	<img  src="<%=fullUrl %>pics/edit.png"/ width="16px" height="16px" /></a>			      
		      </h2>
		      
		      					<div class="content">${ssBinder.description}</div>		
	 	  </div>
	</div>	 	 
	<div id="col1">
		 <div class="logo" style="position: absolute; margin-top: 0px; margin-left:5px;">
	 	 	<img width="30px" height="30px" src="<%=fullUrl %>pics/Article.png" />
	 	 </div>
	 	  <div style="left:40px;">
	 
	 	  
		      <h2>Articles</h2>   <p>
		      
		      <a class="ss_linkButton" 
	   		 	href='<ssf:url action="add_folder_entry" binderId="${ssBinder.id}">
		   		 	<ssf:param name="entryType" value="${entryDef.id}" /></ssf:url>'> 
		   		 	<img src="<%=fullUrl %>pics/Document-Write-icon.png"/ width="18px" height="18px" /> 
		   		 	<strong> Ajouter un article</strong>
		   		 	</a>
							
	   		

								   		 	 
		   </div>
		   <div >
		      	<ul style="margin: 0; padding: 0;">
			      	 <c:forEach var="entry" items="${ssFolderEntries}">
					   		<div class="rubrique">
					   		
	
					   			
							  <li>	  					   								 				 								 
								 <script type="text/javascript">
									
										$("iframe#myiFrame").ready(function(){ 									
											$("a#view_entry_${entry._docId}").click(function(){		
											
												var entryId = $(this).attr('class');
												var link = '<ssf:url action="view_folder_entry" entryId="${entry._docId}" binderId="${ssBinder.id}">
												<ssf:param name="namespace" value="_ss_forum_" />
									   		 	<ssf:param name="entryViewStyle" value="iframe"	/>
									   		 	<ssf:param name="displayStyle" value="iframe" /></ssf:url>';
					
												$("iframe#myiFrame").attr("src",link);
												$("h2.articleTitle").html("${entry.title}");

											});
										});		
										
										

								 </script>
								 
								 
								 <a  id="view_entry_${entry._docId}" class="view_entry" href="#"> 
								   		 	<c:out value="${entry.title}" escapeXml="true" />	 		
								 
								 </a>

								                                                 

							   <br/>							 
							   </li>

					   		</div>
					   
					 </c:forEach>
				 </ul>
		   </div>
	 	 
	</div>
	<div id="col2" >
		 <div id="article">
			 <div class="logo" style="float:left;">
		 	 	<img width="38px" height="38px" src="<%=fullUrl %>pics/star.png" />
		 	 </div>

		 	  <div style="left:40px;">
			      <h2 class="articleTitle">Select an entry</h2>
				 	<iframe id="myiFrame"  src="" width="100%" height="750px" frameborder="0" name="gwtContentIframe">
		            </iframe>
		 	  </div>
		 </div>		                 
	 </div>
</div>






<% //Listing des rubriques %>

 

