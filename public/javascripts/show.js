var $j = jQuery.noConflict();

$j(document).ready(function()
{
	$j(".post_a_comment").click(function(){
		$j("#comment").css("background-color", "#D4D5D7")
	});
	
	$j('.flagShowButton').click(function() {
		var flagHTML = "";
		flagHTML += "<div style='text-align:left;'><h2>Issue With A Show?</h2><span>";
		flagHTML += "<div style='text-align:left;'><input type='radio' name='group1' value='1' checked='checked'>Offensive, Abusive, Or Hate Speech</span><br>";
		flagHTML += "<div style='text-align:left;'><input type='radio' name='group1' value='2'>Duplicate</span>";
		flagHTML += "<div style='text-align:left;margin-top:15px;'>"
		flagHTML += "<div id='flagCancel'>Cancel</div>"
		flagHTML += "<div id='flagShow'>Flag Show</div>"
		flagHTML += "</div>"
		flagHTML += "";
	    $j('.flagShow').remove();
	    var flagBox = $j('<div>').addClass('flagShow')
	                         .html(flagHTML)
	                         .css('left', $j(this).position().left)
							 .css('top', $j(this).position().top + 20);
	    $j(this).after(flagBox);
	    $j(flagBox).fadeIn('slow');
	});
	
	$j('#flagCancel').live('click', function() {
	    $j('.flagShow').fadeOut('fast', function() { $j(this).remove(); });
	});

        $j('#flagShow').live('click', function(){
	
            var showID = $j('#showinfo').attr("showid");
			var flagValue = $j('.flagShow input:radio:checked').val();
            
            $j.ajax({
              url: 'http://www.badkidsdancegood.com/shows/flag/' + showID,
              success: function(data) {
				
              }
            });

			$j('.flagShow').fadeOut('fast', function() { $j(this).remove(); });
                        
        });
});
