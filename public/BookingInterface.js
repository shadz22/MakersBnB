$(document).ready(function() {

var user = new User();
var listing = new Listing();

$("#create-booking-btn").on("click", function() {
  createBooking()
 })

 function createBooking(){
  $('#booking').html(
  )
 }

function displayListing() {
$("#create-listing-display").html(
  '<h1>Listing Name:' + listing.name + '</h1>\
  <h1>Listing Description:' + listing.description + '</h1>\
  <h1>Listing Price:' + listing.price + '</h1>\
  <h1>Listing Start-date:' +listing.start_date + '</h1>\
  <h1>Listing End-date:' + listing.end_date + '</h1>'
)}

  var startDate = listing.start_date
  var endDate = listing.end_date
  var unavailableDates = ["2020-2-1", "2020-2-2", "2020-2-3", "2020-2-4", "2020-2-5"]
  function unavailable(date) {
     ymd = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
      if (jQuery.inArray(ymd, unavailableDates) == -1) {
          return [true, ""];
      } else {
          return [false, "", "Unavailable"];
      }
  }
  
  $(function() {

    var bookedDates = []

      $( "#from" ).datepicker({
          minDate: "2020-01-05", 
          maxDate: "2020-04-05",
          defaultDate: "+1w",
          changeMonth: true,
          beforeShowDay: unavailable,
          numberOfMonths: 1,
          dateFormat: 'yy-mm-dd',
          onClose: function( selectedDate ) {
            $( "#to" ).datepicker( "option", "minDate", selectedDate );
          }
      });

      $("#from").on("change",function(){
          var selectedFrom = $(this).val();
          // bookedDates.pop(selectedFrom)
          console.log(selectedFrom)
      });

      $( "#to" ).datepicker({
          minDate: "2020-01-05", 
          maxDate: "2020-04-05",
          defaultDate: "+1w",
          changeMonth: true,
          beforeShowDay: unavailable,
          numberOfMonths: 1,
          dateFormat: 'yy-mm-dd',
          onClose: function( selectedDate ) {
              $( "#from" ).datepicker( "option", "maxDate", selectedDate );
          }
      });

      $("#to").on("change",function(){
          var selectedTo = $(this).val();
          // bookedDates.pop(selectedTo)
          console.log(selectedTo)
      });

    $("#dates").on("click", function() {
     })

  });

})