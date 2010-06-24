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
	                         .css('left', $j(this).position().left + 30)
							 .css('top', $j(this).position().top - 110);
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

	$j('.add_ticket_link').click(function() {
	    $j('.addTicketLinkHoverBox').remove();
		var ticketLinkHTML = "";
		ticketLinkHTML += "<div style='text-align:left;'><h2>Paste A Ticket Link In The Box Below</h2></div>";
		ticketLinkHTML += "<div style='text-align:left;'><input type='text' class='ticketLinkText'></div>";
		ticketLinkHTML += "<div style='text-align:left;margin-top:15px;'>"
		ticketLinkHTML += "<div id='ticketCancel'>Cancel</div>"
		ticketLinkHTML += "<div id='ticketAdd'>Add Link</div>"
		ticketLinkHTML += "</div>"
	    var err = $j('<div>').addClass('addTicketLinkHoverBox')
	                         .html(ticketLinkHTML)
	                         .css('left', $j(this).position().left +30)
							 .css('top', $j(this).position().top - 110);
	    $j(this).after(err);
	    $j(err).fadeIn('slow');
	});
	
	$j('#ticketCancel').live('click', function() {
	    $j('.addTicketLinkHoverBox').fadeOut('fast', function() { $j(this).remove(); });
	});
	
	$j('#ticketAdd').live('click', function(){

     	 var showID = $j('#showinfo').attr("showid");
 		 var ticketLink = $j(".ticketLinkText").val();
  
         $j.ajax({
           url: 'http://localhost:3000/shows/addTicketLink/' + showID + '?ticketLink=' + ticketLink,
           success: function(data) {

           }
         });

		$j('.addTicketLinkHoverBox').fadeOut('fast', function() { $j(this).remove(); });
              
 });
});
