$(document).ready(function() {

  var user = new User();
  var listing = new Listing();

  $("#create-booking-btn").on("click", function() {
    createBooking()
  })

  // $('#view-booking-btn').on('click', function() {
  //   $.get(`/bookings/dates/${listing.id}`, function(data) {
  //     var dates = (data.match(/.{10}/g));
  //      var unavailableDates = [dates]
      
  //   })
  // });


  function displayListing() {
  $("#create-listing-display").html(
    '<h1>Listing Name:' + listing.name + '</h1>\
    <h1>Listing Description:' + listing.description + '</h1>\
    <h1>Listing Price:' + listing.price + '</h1>\
    <h1>Listing Start-date:' +listing.start_date + '</h1>\
    <h1>Listing End-date:' + listing.end_date + '</h1>'
  )}

  function createBooking(){
    $('#booking').html(
      '<form action="../bookings" method="post">\
      <label for="from">From</label>\
      <input type="text" id="start_date" name="start_date">\
      <label for="to">to</label>\
      <input type="text" id="end_date" name="end_date">\
      <input type="hidden" name="user_id" value='+ user.id +'> \
      <input type="hidden" name="listing_id" value=' + listing.id+ '>\
      <input type=submit id="dates" value="Create Dates"></form>'
      
    )
    $.get(`/bookings/dates/${listing.id}`, function(data) {
      var dates = (data.match(/.{10}/g));
      var unavailableDates = dates
      function unavailable(date) {
        ymd = date.getFullYear() + "-" + ((date.getMonth()) < 9 ? ("0" + (date.getMonth() + 1)) : (date.getMonth() + 1)) + "-" + ( date.getDate() < 10 ? ("0" + date.getDate()) : (date.getDate()) );
          if (jQuery.inArray(ymd, unavailableDates) == -1) {
              return [true, ""];
          } else {
              return [false, "", "Unavailable"];
          }
      }
      
  $(function() {

    $( "#start_date" ).datepicker({
      minDate: "2020-01-05", 
      maxDate: "2020-09-30",
      defaultDate: "+1w",
      changeMonth: true,
      beforeShowDay: unavailable,
      numberOfMonths: 1,
      dateFormat: 'yy-mm-dd',
      onClose: function( selectedDate ) {
        $( "#end_date" ).datepicker( "option", "minDate", selectedDate );
        }
    });

    $( "#end_date" ).datepicker({
      minDate: "2020-01-05", 
      maxDate: "2020-09-30",
      defaultDate: "+1w",
      changeMonth: true,
      beforeShowDay: unavailable,
      numberOfMonths: 1,
      dateFormat: 'yy-mm-dd',
      onClose: function( selectedDate ) {
        $( "#start_date" ).datepicker( "option", "maxDate", selectedDate );
        }
      });
    });
  })
  }





})