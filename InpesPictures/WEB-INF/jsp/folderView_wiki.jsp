
<%@ include file="/WEB-INF/jsp/definition_elements/init.jsp" %>
<%@ include file="/WEB-INF/jsp/common/include.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/common/common.jsp" %>

<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet" %>
<%@ taglib prefix="portletadapter" uri="http://www.sitescape.com/tags-portletadapter" %>



<%
	//VibeClient vc = new VibeClient("admin", "", "http://vibe.mmengual.com/ssr/secure/ws/TeamingServiceV1");
//	VibeClient.printStaticShit();
//	String s=  VibeClient.getUser(8);
//	vc.printShit();
	
%>
<link rel="stylesheet" type="text/css" href="<ssf:extensionUrl url='css/commonstyle.css' />" />
<link rel="stylesheet" type="text/css" href="<ssf:extensionUrl url='css/mainwikistyles.css' />" />



<script type="text/javascript" src="<ssf:extensionUrl url='js/jquery.js' />"></script>"

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



		var data_resultsCount =  "5";
		var binderId = ${ssBinder.id};

		$("div.ss_content_window").hide();		
		$("div#searchResults").hide();
		
		$("a#button_closeSearch").click(function(){
				$("div#searchResults").fadeOut("slow");			
		});
		
		$("button.searchButton").click(function(){
											
			idChoices= '<c:forEach var="blogPage" items="${ssBlogPages}"><c:out value="searchFolders_${blogPage.id}%20" /></c:forEach>';
			var searchText=$("input#searchFieldInput").val();			
			var url = "/ssf/a/do?p_name=ss_forum&p_action=1&operation=ss_searchResults&tabTitle=&quickSearch=true&binderId="+${ssBinder.id}+"&data_resultsCount="+data_resultsCount+"&data_summaryWordCount=5&action=advanced_search&searchText="+searchText+"&newTab=1&vibeonprem_url=1&idChoices="+idChoices+" ul.ss_searchResult";
			
			$("div#searchResults_load").load(url, function() { $("div#searchResults").fadeIn("slow"); }); 						
			$("p#searchResults_label").html("R&eacute;sultat de la recherche : "+searchText);
		});
		

	});
	
	
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




<% //Toolbar %>
<div class="ss_wiki_folder">
	<div class="wiki-content">
		<c:set var="entryDefs" value="${ssBinder.entryDefinitions}"/>
		<c:forEach var="entryDefsScan" items="${entryDefs}">
			<c:if test="${entryDefsScan.name == '_wikiEntry'}">
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
		         	<img width="15px" height="15px" src="<ssf:extensionUrl url='pics/magnifying-glass.jpg'/>" />
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
				   ><img src=<ssf:extensionUrl url='images/pics/nl_left_noborder_16.png' />"
					 title="<ssf:nlt tag="nav.prevEntry"/>"></a>
				   <a class="ss_box_next" href="${ss_nextPrevUrl}" 
				     onclick="ss_loadUrlInEntryFrameNext(this.href);return false;"
					 style="margin-right:10px;"
				   ><img src="<ssf:extensionUrl url='images/pics/nl_right_noborder_16.png' />"
					 title="<ssf:nlt tag="nav.nextEntry"/>"></a>
			  	   <a class="ss_actions_bar13_pane_none" href="javascript: window.print();"><img border="0" 
			         alt="<ssf:nlt tag="navigation.print"/>" title="<ssf:nlt tag="navigation.print"/>"
			         src="<<ssf:extensionUrl url='images/pics/masthead/masthead_printer.png' />" /></a>&nbsp;&nbsp;
			       <ssf:showHelp className="ss_actions_bar13_pane_none" guideName="user" pageId="entry" />
			     </c:if>
			    </form>
			  </c:if>
			  <span style="font-size:10px;"><ssf:nlt tag="wiki.findPage"/></span>
		  </div>
		  <div id="input_searchContent" style="display: none;">
			<div class="logo" style="margin: 5px 5px 5px 5px;">
				<p>
					<img width="15px" height="15px" src="<ssf:extensionUrl url='pics/magnifying-glass.jpg' />" />	
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
	 	 	<img width="38px" height="38px" src="<ssf:extensionUrl url='pics/wiki-logo-circle.png' />" />
	 	 </div>
	 	  <div style="left:40px;">
		      <h2>${ssBinder.title}
			      			      <a class="ss_linkButton" target="_blank" href='<ssf:url operation="modify" action="modify_binder" binderId="${ssBinder.id}">
								   		 	<ssf:param name="binderType" value="folder" />
								   		 	<ssf:param name="p_action" value="1" />
								   		 	<ssf:param name="_element" value="description" />
								   		 	<ssf:param name="binderType" value="folder" />
								   		 	</ssf:url>'> 
								   		 	<img src="<ssf:extensionUrl url='pics/edit.png' />"/ width="16px" height="16px" target="_blank" /></a></h2>			      
		      </h2>
		      
		      <div class="content">
			      	${ssBinder.description}
		      </div>
	 	  </div>
	</div>	 	 
	<div id="col1">
		 <div class="logo" style="position: absolute;">
	 	 	<img width="32px" height="32px" src="<ssf:extensionUrl url='pics/wikibooks.png' />" />
	 	 </div>
	 	  <div style="left:40px;">
		      <h2>Rubriques</h2>   <p><a class="ss_linkButton" href='<ssf:url action="add_binder" binderId="${ssBinder.id}">
			<ssf:param name="templateName" value="folder_rubrique" />
			<ssf:param name="binderType" value="folder" />
              	</ssf:url>'> <img src="<ssf:extensionUrl url='pics/folder_add_256.png' />"/ width="18px" height="18px" /> <strong> Ajouter une nouvelle rubrique </strong></p></a>

		   </div>
		   <div >
		      	<ul style="margin: 0; padding: 0;">
			      	 <c:forEach var="blogPage" items="${ssBlogPages}">
					   <c:if test="${topWikiFolder != blogPage}">
					   		<div class="rubrique">
							  <li>
							  	<a  class="wiki-topic-a <c:if test="${blogPage.id == ssBinder.id}">wiki-topic-selected</c:if>" 
								  href="<ssf:url action="view_folder_listing" binderId="${blogPage.id}">
										  			<ssf:param name="wiki_folder_list" value="1"/>
										 </ssf:url>"
							   ><c:out value="${blogPage.title}" escapeXml="true" />	</a> 
							   	 <a class="ss_linkButton" target="_blank" href='<ssf:url operation="modify" action="modify_binder" binderId="${blogPage.id}">
								  		 	<ssf:param name="binderType" value="folder" />
								   		 	<ssf:param name="p_action" value="1" />
								   		 	<ssf:param name="_element" value="pageAccueil" />
								   		 	<ssf:param name="binderType" value="folder" />
								</ssf:url>'> <img src="<ssf:extensionUrl url='pics/edit.png' />" width="16px" height="16px" />
								</a>
														 	

							   </li>
					   		</div>
					   </c:if>
					 </c:forEach>
				 </ul>
				 	 <div class="logo" style="position: absolute;">
		 	 	<img width="35px" height="35px" src="<ssf:extensionUrl url='pics/community-icon.gif' />" />
		 	 </div>
		 	  <div style="left:40px;">
			      <h2>Membres</h2>
				      <a class="ss_linkButton" target="_blank" href='<ssf:url action="add_team_member" binderId="${ssBinder.id}">
									   		 	<ssf:param name="binderType" value="folder" />
									   		 	</ssf:url>'> 
				      	<img width="18px" height="18px" src="<ssf:extensionUrl url='pics/addmember.png'/>" />  Ajouter un membre
				      </a>
				   		<ul style="list-style: none;">
							<c:forEach var="members"  items="${ssTeamMembers}" >
							 <jsp:useBean id="members" type="java.util.Map.Entry" />
						      <%					      				      
													
									%>			
										<li style="list-style: none;  vertical-align: middle;" class="members"><img src="/<ssf:extensionUrl url='pics/usericon.png' />" width="16px" height="16px" /> <label style="margin-bottom:5px"> <%=members.getKey() %> </label></li>
									<%						
									
						      %>
							</c:forEach>
				   		</ul>
	
		 	  </div>
		 </div>
		 
	 	 
	</div>
	

	<div id="col2outer">
		  <div id="header">
		 	 <div class="logo" style="position: absolute;">
		 	 	<img width="38px" height="38px" src="<ssf:extensionUrl url='pics/star.png' />" />
		 	 </div>
		 	  <div style="left:40px;">
			      <h2>Page d'accueil wiki
			      			      
			      <a class="ss_linkButton" target="_blank" href='<ssf:url operation="modify" action="modify_binder" binderId="${ssBinder.id}">
								   		 	<ssf:param name="binderType" value="folder" />
								   		 	<ssf:param name="p_action" value="1" />
								   		 	<ssf:param name="_element" value="pageAccueil" />
								   		 	<ssf:param name="binderType" value="folder" />
								   		 	</ssf:url>'> 
								   		 	<img src="<ssf:extensionUrl url='pics/edit.png' />"/ width="16px" height="16px" /></a></h2>
								   		 	
					<div class="content">${ssBinder.customAttributes['pageAccueil'].value}</div>			      

		 	  </div>
		 </div>
		 		 		 



	 </div>
</div>







 

