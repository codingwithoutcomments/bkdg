
var $j = jQuery.noConflict();

$j(document).ready(function()
{
                 $j("#datepicker").datepicker({
					showOn: 'button',
					buttonImage: '/images/calendar_3.png',
					buttonImageOnly: true,
					onSelect: function(dateText, inst) {
						var city = $j("#cityValue").val();
						var state = $j("#stateValue").val();
						var newLocation = "http://www.badkidsdancegood.com/" + city + "/" + state + "/" + "?date=" + dateText;
						window.location.href = newLocation;
					}
					
				});

                 $j(".ui-datepicker-trigger").attr("title", "Choose A Date");

//				$j('<div id="notice">|| Search And Date Selector Now Work Y\'all!  Check it out! ||</div>').insertBefore('#header');
//		  		$j("#notice")
//					.css("display", "none")
//					.fadeIn("slow");
//					
//				setTimeout(function() { $j('#notice').fadeOut("slow", function(){  $j(this).remove(); }) }, 5000);
});
