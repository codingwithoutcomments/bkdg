// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var $j = jQuery.noConflict()
$j.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$j(document).ready(function() {
	
	    $j("#q").click(function(){
			$j(this).css("color", "#808185");
			$j(this).setCursorPosition(0);
			
		});
		
		$j("#q").keypress(function(e){
			
			if($j(this).val() == "search for shows, bands, venues")
			{
				$j(this).val("");
				$j(this).css("color", "black");
				
			}
		});
		
		new function($) {
		  $.fn.setCursorPosition = function(pos) {
		    if ($(this).get(0).setSelectionRange) {
		      $(this).get(0).setSelectionRange(pos, pos);
		    } else if ($(this).get(0).createTextRange) {
		      var range = $(this).get(0).createTextRange();
		      range.collapse(true);
		      range.moveEnd('character', pos);
		      range.moveStart('character', pos);
		      range.select();
		    }
		  }
		}(jQuery);
		
			
		$j('.attend-recommend .attendincrement').click(function(){
					
                    $j('#attendincrement').attr("id", "");
                    $j(this).attr("id", "attendincrement");
					
		 });							
	
  	$j('.attenderror').click(function() {
	    $j('.error-notification').remove();
	    var err = $j('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to attend shows</h2>(click on this box to close)')
	                         .css('left', $j(this).position().left)
							 .css('top', $j(this).position().top + $j(this).height() + 8);
	    $j(this).after(err);
	    $j(err).fadeIn('slow');
	});
	
	$j('.timeError').click(function() {
	    $j('.error-notification').remove();
	    var err = $j('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to edit the show time</h2>(click on this box to close)')
	                         .css('left', $j(this).position().left)
							 .css('top', $j(this).position().top + $j(this).height() + 8);
	    $j(this).after(err);
	    $j(err).fadeIn('slow');
	});
	
	$j('.priceError').click(function() {
	    $j('.error-notification').remove();
	    var err = $j('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to edit the show price</h2>(click on this box to close)')
	                         .css('left', $j(this).position().left)
							 .css('top', $j(this).position().top + $j(this).height() + 8);
	    $j(this).after(err);
	    $j(err).fadeIn('slow');
	});
	
	$j('.addOpenersError').click(function() {
	    $j('.error-notification').remove();
	    var err = $j('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to add opening bands</h2>(click on this box to close)')
	                         .css('left', $j(this).position().left)
							 .css('top', $j(this).position().top + $j(this).height() + 8)
							 .css('font-size', '80%');
	    $j(this).after(err);
	    $j(err).fadeIn('slow');
	});
	
	$j('.commenterror').click(function() {
	    $j('.error-notification').remove();
	    var err = $j('<div>').addClass('error-notification')
	                         .html('<h2>Please <a href = "/login">login</a> or <a href = "/users/new">signup</a> <br> to comment on shows</h2>(click on this box to close)')
	                         .css('left', $j(this).position().left +30)
							 .css('top', $j(this).position().top - 110);
	    $j(this).after(err);
	    $j(err).fadeIn('slow');
	});
	
	$j('.error-notification').live('click', function() {
	    $j(this).fadeOut('fast', function() { $j(this).remove(); });
	});
	
	if($j("#flashnotice").css("display") == "block")
	{
		setTimeout('fadeOutFlashNotice()', 1000)
	}

});

function fadeOutFlashNotice()
{
	$j("#flashnotice").fadeOut("slow");
}


