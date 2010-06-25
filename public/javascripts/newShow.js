
var $j = jQuery.noConflict();

var NumberOfBandsShown = 0;

var bandsHighlighted = false;
var venueHighlighted = false;
var priceHighlighted = false;
var dateHighlighted = false;
var doorsHighlighted = false;
var ageHighlighted = false;
var descriptionHighlighted = false;
var ticketHighlighted = false;
	
$j(document).ready(function()
{
	//start with the first and second band shown on the screen
	DisplayInitialBands();
	
	//Display Initial Price if the money option is selected
	DisplayInitialPrice();
	
	//display advanced price if it exists
	DisplayAdvancedPriceIfExists();
	
	//on error, highlight the error-ed part of the form
	DisplayErroredSectionOfForm();
	
	//populate list of venues
	PopulateListOfVenues()
	
	$j(".AddABand").click( function() {  AddABand(); } );
	
	$j(".SpecifyAdvance").click(function() {
		$j(".AdvanceTicketPrice").css("display","block");
		$j(this).css("display", "none");
	});
	
	$j("#band1").focus(function(){ hightlightBands(); });
	$j("#band2").focus(function(){ hightlightBands(); });
	$j("#band3").focus(function(){ hightlightBands(); });
	$j("#band4").focus(function(){ hightlightBands(); });
	$j("#band5").focus(function(){ hightlightBands(); });
	$j("#band6").focus(function(){ hightlightBands(); });
	$j("#band7").focus(function(){ hightlightBands(); });
	$j("#band8").focus(function(){ hightlightBands(); });
	$j("#band9").focus(function(){ hightlightBands(); });
	$j("#band10").focus(function(){ hightlightBands(); });
	
	$j("#VenueContainer input").focus(function() { highlightVenue(); });
	
	$j("#PriceContainer").click(function() { highlightPrice();  });
	
	$j("#TicketContainer").click(function(){ highlightTicket() });
	
	$j(".DoorTicketPrice input").focus(function() { highlightPrice(); });
	$j(".AdvanceTicketPrice input").focus(function() { highlightPrice(); });
	
	$j("#show_date_1i").focus(function() { highlightDate(); });
	$j("#show_date_2i").focus(function() { highlightDate(); });
	$j("#show_date_3i").focus(function() { highlightDate(); });
	
	$j("#DoorContainer").click(function(){ highlightShowTime(); }).find("#show_time").focus(function(){ highlightShowTime(); });
	
	$j("#AgeContainer").click(function() { highlightAgeRestrictions() });
	
	$j("#show_additional_info").click(function(){ highlightShowDescription(); });
	
	$j("#yes").click(function(){
		$j("#name_of_venue").attr("value",$j("#possibleVenue").html());
		$j("#errorExplanation").fadeOut();
	});
	
	$j("#CreateANewVenue").click(function(){  
		window.location = "/venues/new";
	});
	
	$j("#show_price_option").change(function(){ price_option_changed(); });

});

function PopulateListOfVenues()
{
		$j("#name_of_venue").autocomplete({
			serviceUrl:'/venues',
			width:480
		});	
}

function DisplayErroredSectionOfForm()
{
	areaToHighlight = $j("#highlight").attr("value");
	if(areaToHighlight == "venue") highlightVenue();
	if(areaToHighlight == "bands") hightlightBands();
	if(areaToHighlight == "time") highlightShowTime();;
    if(areaToHighlight == "price") highlightPrice();
		
}

function DisplayInitialPrice()
{
	var selectedText = $j("#show_price_option :selected").text();
	if(selectedText == "This Show Costs Money ($$)")
	{
		$j(".DoorTicketPrice").show();
		$j(".AdvanceTicketPrice").show();
	
	}
	
}

function price_option_changed()
{
	var selectedText = $j("#show_price_option :selected").text();
	if(selectedText == "This Show Costs Money ($$)")
	{
		$j(".DoorTicketPrice").fadeIn();
		$j(".AdvanceTicketPrice").fadeIn();
	
	}else{
		
		$j(".DoorTicketPrice").fadeOut();
		$j(".AdvanceTicketPrice").fadeOut();
	}
}

function DisplayAdvancedPriceIfExists()
{
	var advancePrice = $j(".AdvanceTicketPrice input").val();
	if(advancePrice != "")
	{
		$j(".AdvanceTicketPrice").css("display","block");
		$j(".SpecifyAdvance").css("display", "none");
	}
}

function DisplayInitialBands()
{
	$j("div.Bands:eq(0)").css("display", "block");
	NumberOfBandsShown++;
	
	for(i = 1; i < 10; i++)
	{
		var Selector = 	$j("div.Bands:eq("+i+")");
		if(Selector.find("input").val() != "")
		{
			Selector.css("display", "block");
			NumberOfBandsShown++;
		}
	}
}

function unselectAllInputBoxes()
{
	$j("input").each(function(){
		$j(this).blur();
	});
}

function dehighlightAll()
{
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	dehighlightTicket();
}

function highlightShowDescription()
{
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightTicket();
	
	if(descriptionHighlighted == false)
	{
		$j("#descriptionLabel").css("background-color","#F90887").css("color", "white").find("label").css("font-size", "120%");
		descriptionHighlighted = true;
	}
}

function dehighlightShowDescription()
{
	if(descriptionHighlighted == true)
	{
		$j("#descriptionLabel").css("background-color","white").css("color", "black").find("label").css("font-size", "100%");
		descriptionHighlighted = false;
	}
}

function highlightTicket()
{
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	
	if(ticketHighlighted == false)
	{
			var ticketContainer = $j("#TicketContainer");
			ticketContainer.css("color", "white").css("background-color", "#F90887").css("font-size", "120%");
			ticketHighlighted = true;
	}	
}

function dehighlightTicket()
{	
	if(ticketHighlighted == true)
	{
			var ticketContainer = $j("#TicketContainer");
			ticketContainer.css("color", "black").css("background-color", "white").css("font-size", "100%");
			ticketHighlighted = false;
	}
}

function highlightAgeRestrictions()
{
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightShowDescription();
	dehighlightTicket();
	
	$j("#21plus").css("background-color", "#F90887").css("color", "white");
	$j("#AllAges").css("background-color", "#F90887").css("color", "white");
	$j("#Unknown").css("background-color", "#F90887").css("color", "white");
	
	if(ageHighlighted == false)
	{
		$j("#AgeContainer").css("background-color","#F90887").css("color", "white").find("label").css("font-size", "120%");
									
		ageHighlighted = true;
	}
	
	if($j("#show_allowed_in_21").is(":checked"))  $j("#21plus").css("background-color", "#FFFF01").css("color", "black");
	if($j("#show_allowed_in_all_ages").is(":checked")) $j("#AllAges").css("background-color", "#FFFF01").css("color", "black");
	if($j("#show_allowed_in_unknown").is(":checked")) $j("#Unknown").css("background-color", "#FFFF01").css("color", "black");
	
}

function dehighlightAgeRestrictions()
{
	if(ageHighlighted == true)
	{
		$j("#AgeContainer").css("background-color","white").css("color", "black").find("label").css("font-size", "100%");
		$j("#21plus").css("background-color", "white").css("color", "black");
		$j("#AllAges").css("background-color", "white").css("color", "black");
		$j("#Unknown").css("background-color", "white").css("color", "black");
		ageHighlighted = false;
	}
	
}

function highlightShowTime()
{
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightDate();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	dehighlightTicket();
	
	if(doorsHighlighted == false)
	{
		$j("#DoorContainer").css("background-color", "#F90887").css("color", "white").find("label").css("font-size", "120%");
		doorsHighlighted = true;
	}
	
}

function dehighlightShowTime()
{
	if(doorsHighlighted == true)
	{
			var timeSelector = $j("#DoorContainer");
			timeSelector.css("background-color", "white").css("color", "black").find("label").css("font-size", "100%");
			doorsHighlighted = false;
	}
}

function highlightDate()
{
	
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	dehighlightTicket();
	
	if(dateHighlighted == false)
	{
		var DateSelector = $j("#DateContainer");
		DateSelector.css("background-color", "#F90887").css("color", "white");
		DateSelector.find("label").css("font-size", "120%");
		
		dateHighlighted = true;
	}
	
}

function dehighlightDate()
{
	if(dateHighlighted == true)
	{
		var DateSelector = $j("#DateContainer");
		DateSelector.css("background-color", "white").css("color", "black");
		DateSelector.find("label").css("font-size", "100%");
		
		dateHighlighted = false;
		
	}
}

function dehighlightPrice()
{
	if(priceHighlighted == true)
	{
		
		var PriceContainer = $j("#PriceContainer");
		PriceContainer.css("background-color", "white").css("color", "black");
		PriceContainer.find(".PriceLabel").css("color", "black").css("font-size", "100%");
		PriceContainer.find(".SpecifyAdvance a").css("color", "#7C0343").html("Advanced Ticket Price?");
		
		priceHighlighted = false;
		
	}
}


function highlightPrice()
{
	dehighlightVenue(); 
	dehighlightBands();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	dehighlightTicket();
	
	if(priceHighlighted == false)
	{
		var PriceContainer = $j("#PriceContainer");
		PriceContainer.css("background-color", "#F90887").css("color", "white");
		PriceContainer.find(".PriceLabel").css("color", "white").css("font-size", "120%");
		PriceContainer.find(".SpecifyAdvance a").css("color", "white").html("(Advanced Ticket Price?)");
		
		priceHighlighted = true;
	}
}

function hightlightBands()
{
	dehighlightVenue(); 
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	dehighlightTicket();
	
	if(bandsHighlighted == false)
	{
		$j("#BandsContainer").css("background-color", "#F90887");
		$j("#BandHeader").css("color", "white").css("font-size", "120%");
		$j(".AddABand a").css("color", "black");
		bandsHighlighted = true;
	}
}

function dehighlightBands()
{
	if(bandsHighlighted == true)
	{
		$j("#BandsContainer").css("background-color", "white");
		$j("#BandHeader").css("color", "black").css("font-size", "100%");
		bandsHighlighted = false;
	}
}

function highlightVenue()
{
	dehighlightBands(); 
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	dehighlightAgeRestrictions();
	dehighlightShowDescription();
	dehighlightTicket();
	
	if(venueHighlighted == false)
	{
		var venueContainer = $j("#VenueContainer");
		venueContainer.css("color", "white").css("background-color", "#F90887").css("font-size", "120%");
		venueHighlighted = true;
	}
}

function dehighlightVenue()
{
	if(venueHighlighted == true)
	{
			var venueContainer = $j("#VenueContainer");
			venueContainer.css("color", "black").css("background-color", "white").css("font-size", "100%");
			venueHighlighted = false;
	}
	
}

function AddABandByNumber(number)
{
	var BandClass = "div.Bands:eq(" + number + ")"
	$j(BandClass).css("display", "block");
	NumberOfBandsShown++;
}

function AddABand()
{
	var BandClass = "div.Bands:eq(" + NumberOfBandsShown + ")"
	$j(BandClass).css("display", "block");
	NumberOfBandsShown++;
	
	FocusOnLastEmptyBandInput();
}

function FocusOnLastEmptyBandInput()
{
	
	for(BandInput = 0; BandInput < NumberOfBandsShown; BandInput++)
	{
		var BandSelector = $j("div.Bands:eq(" + BandInput + ")");
	 	var ValueOfInput = BandSelector.find("input").val();
		if(ValueOfInput == "") 
		{
			BandSelector.find("input").focus();
			return;
		}
	}
}
