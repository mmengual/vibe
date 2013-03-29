$(document).ready(function(){
    Galleria.loadTheme('<%=fullUrl %>js/galleria/themes/classic/galleria.classic.min.js');
    Galleria.run('#galleria');		
    
    $("label.addButton").click(function(){
	    $("div#addNewEntry_toggle").toggle();
    });
    
    $("label.addButton2").click(function(){	    

	    ss_showFolderAddAttachmentDropbox('_ss_forum_', '210','true');
    });
    
});