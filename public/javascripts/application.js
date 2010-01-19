// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.noConflict()
jQuery.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery(document).ready(function() {
			
		jQuery('.attend-recommend .attendincrement').click(function(){
					
					jQuery('#attendincrement').attr("id", "");
					jQuery(this).attr("id", "attendincrement");
					
		 });							
		    
		
	
  	jQuery('.attenderror').click(function() {
	    jQuery('.error-notification').remove();
	    var err = jQuery('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to attend shows</h2>(click on this box to close)')
	                         .css('left', jQuery(this).position().left);
	    jQuery(this).after(err);
	    jQuery(err).fadeIn('slow');
	});
	
	jQuery('.commenterror').click(function() {
	    jQuery('.error-notification').remove();
	    var err = jQuery('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to comment on shows</h2>(click on this box to close)')
	                         .css('left', jQuery(this).position().left);
	    jQuery(this).after(err);
	    jQuery(err).fadeIn('slow');
	});
	
	jQuery('.error-notification').live('click', function() {
	    jQuery(this).fadeOut('fast', function() { jQuery(this).remove(); });
	});

	
	
	
	
	
})