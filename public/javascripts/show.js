var $j = jQuery.noConflict();

$j(document).ready(function()
{
	$j(".post_a_comment").click(function(){
		$j("#comment").css("background-color", "#D4D5D7")
	});
	
	$j('.flagShowButton').click(function() {
		var flagHTML = "<div>";
		flagHTML += "<div style='text-align:left;'><h2>Flag Show:</h2><span>";
		flagHTML += "<div style='text-align:left;'><input type='radio' name='group1' value='Offensive'>Offensive, Abusive, Or Hate Speech</span><br>";
		flagHTML += "<div style='text-align:left;'><input type='radio' name='group1' value='Duplicate'>Duplicate</span>";
		flagHTML += "</div>";
	    $j('.flagShow').remove();
	    var flagBox = $j('<div>').addClass('flagShow')
	                         .html(flagHTML)
	                         .css('left', $j(this).position().left)
							 .css('top', $j(this).position().top + 20);
	    $j(this).after(flagBox);
	    $j(flagBox).fadeIn('slow');
	});
	
	$j('.flagShow').live('click', function() {
	    $j(this).fadeOut('fast', function() { $j(this).remove(); });
	});
});