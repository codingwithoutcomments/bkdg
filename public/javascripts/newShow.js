
var $j = jQuery.noConflict();

var NumberOfBandsShown = 0;

var bandsHighlighted = false;
var venueHighlighted = false;
var priceHighlighted = false;
var dateHighlighted = false;
var doorsHighlighted = false;
var ageHighlighted = false;
	
$j(document).ready(function()
{
	//start with the first and second band shown on the screen
	DisplayInitialBands();
	
	//display advanced price if it exists
	DisplayAdvancedPriceIfExists();
	
	$j(".AddABand").click( function() {  AddABand(); } );
	
	$j(".SpecifyAdvance").click(function() {
		$j(".AdvanceTicketPrice").css("display","block");
		$j(this).css("display", "none");
	});
	
	$j("#band1").focus(function(){ hightlightBands(); AddABandByNumber(1); });
	$j("#band2").focus(function(){ hightlightBands(); AddABandByNumber(2); });
	$j("#band3").focus(function(){ hightlightBands(); AddABandByNumber(3); });
	$j("#band4").focus(function(){ hightlightBands(); AddABandByNumber(4); });
	$j("#band5").focus(function(){ hightlightBands(); AddABandByNumber(5); });
	$j("#band6").focus(function(){ hightlightBands(); AddABandByNumber(6); });
	$j("#band7").focus(function(){ hightlightBands(); AddABandByNumber(7); });
	$j("#band8").focus(function(){ hightlightBands(); AddABandByNumber(8); });
	$j("#band9").focus(function(){ hightlightBands(); AddABandByNumber(9);});
	$j("#band10").focus(function(){ hightlightBands(); });
	
	$j("#VenueContainer input").focus(function() { highlightVenue(); });
	
	$j(".DoorTicketPrice input").focus(function() { highlightPrice(); });
	$j(".AdvanceTicketPrice input").focus(function() { highlightPrice(); });
	
	$j("#show_date_1i").focus(function() { highlightDate(); });
	$j("#show_date_2i").focus(function() { highlightDate(); });
	$j("#show_date_3i").focus(function() { highlightDate(); });
	
	$j("#DoorContainer").click(function(){ highlightShowTime(); }).find("#show_time").focus(function(){ highlightShowTime(); });
	
	$j("#AgeContainer").click(function() { highlightAgeRestrictions() });

});

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
}

function highlightAgeRestrictions()
{
	dehighlightBands();
	dehighlightVenue();
	dehighlightPrice();
	dehighlightDate();
	dehighlightShowTime();
	
	if(ageHighlighted == false)
	{
		$j("#AgeContainer").css("background-color","#F90887").css("color", "white").find("label").css("font-size", "120%");
		$j("#21plus").css("background-color", "#FFFF01").css("color", "black");
		$j("#AllAges").css("background-color", "#FFFF01").css("color", "black");
		ageHighlighted = true;
	}
}

function dehighlightAgeRestrictions()
{
	if(ageHighlighted == true)
	{
		$j("#AgeContainer").css("background-color","white").css("color", "black").find("label").css("font-size", "100%");
		$j("#21plus").css("background-color", "white");
		$j("#AllAges").css("background-color", "white");
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
