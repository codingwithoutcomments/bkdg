var $j = jQuery.noConflict();

$j(document).ready(function()
{
	$j(".post_a_comment").click(function(){
		$j("#comment").css("background-color", "#D4D5D7")
	});
});