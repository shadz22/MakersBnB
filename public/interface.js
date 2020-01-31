$(document).ready(function(){
  var listings;
  var user_id;
  var currentListing;
  var allListings;
  /// check if user has signed in
  checkUser()

  /// GET ALL LISTINGS
   $.get('/listings', function(data) {
    listings = JSON.parse(data)
    showListings(listings)
    getCurrentListing(listings)
  })
  

  /// hide/show buttons on page load
  $('#homepage-create-listing-btn').hide()
  $('#homepage-create-booking-btn').hide()
  $('#view-booking-btn').hide()
  $("#back-btn").hide()
  $("#back-btn").on("click", function() {
    checkUser()
    $('#show-listings').show()
    $('#listing-details').hide()
    $('#sign-up-form').hide()
    $('#log-in-form').hide()
    $('#create-listing-form').hide()
    $("#back-btn").hide()
    $('#booking').hide()
   })

  /// CREATE LISTING
  $("#homepage-create-listing-btn").on("click", function() {
    createListingForm()
    $('#create-listing-form').show()
    $("#homepage-create-listing-btn").hide()
    $('#show-listings').hide()
    $("#back-btn").show()
  })
  
  function createListingForm() {
    $("#create-listing-form").html(
      '<form action="/listings" method="post">\
      <input type="text" name="create_name" placeholder="Enter name here:" required>\
      <input type="textarea" id="description" rows="4" cols="50" maxlength="200" name="description" placeholder="Enter description here:" required>\
      <input type="number" name="set_price" placeholder="Enter price: £" required>\
      <input type="date" name="start_date" placeholder="Enter start date here:" required>\
      <input type="date" name="end_date" placeholder="Enter end date here:" required>\
      <input type="submit" id="create-listing-btn" value="Add Listing" />\
      </form>'
    )
  }


  /// SHOW LISTINGS
  $('#show-listings').on('click', '#listing-links', function() {
    showListingDetails($(this).val())
  })

  function showListings(listings) {
    for (var key in listings) {    
      const listingLink = document.createElement('BUTTON');
      listingLink.innerHTML = listings[key].name
      listingLink.id = 'listing-links'
      listingLink.value = listings[key].id
      currentListing = listings[key]
      $('#show-listings').append(listingLink)
    }
  }

  function showListingDetails(listing_id) {
    $('#listing-details').hide()
    
    $('#listing-details').empty().append(
      `Name: ${listings[listing_id].name}<br>
      price: ${listings[listing_id].price}<br>
      Description: ${listings[listing_id].description}<br>
      Start Date: ${listings[listing_id].start_date}<br>
      End Date: ${listings[listing_id].end_date}`
      )

    $('#listing-details').show('puff')
    $('#homepage-create-booking-btn').show()
    $('#back-btn').show()
    $('#booking').show()
    currentListing = listings[listing_id].id
    createBooking(listings[listing_id].id)
  }

  /// USER SIGN UP
  $("#homepage-sign-up-btn").on("click", function() {
    signUpForm()
    $('#show-listings').hide()
    $('#homepage-sign-up-btn').hide()
    $('#listing-details').hide()
    $('#sign-up-form').show()
    $("#back-btn").show()
    $("#homepage-log-in-btn").hide()
    $("#booking").hide()
   })

   ///USER LOG IN
   $("#homepage-log-in-btn").on("click", function() {
    logInForm()
    $('#show-listings').hide()
    $('#homepage-sign-up-btn').hide()
    $('#listing-details').hide()
    $('#log-in-form').show()
    $("#homepage-log-in-btn").hide()
    $("#back-btn").show()
   })

   function signUpForm() {
     $("#sign-up-form").html(
       "<form id='sign-up' action='../users' method='post'>\
       Name: <input type=text id='name' name='name'><br>\
       Email: <input type=text id='email' name='email'><br>\
       Password: <input type=text id='password' name='password'><br>\
      <input type=submit id='sign-up-btn' value='Sign Up'/>\
      </form>"
     )
   }


   function logInForm() {
    $("#log-in-form").html(
      "<form id='log-in' action='../sessions' method='post'>\
      Email: <input type=text id='email' name='email'><br>\
      Password: <input type=text id='password' name='password'><br>\
     <input type=submit id='log-in-btn' value='Log in'/>\
     </form>"
    )
  }

   /// check user function
  function checkUser() {
    $.get('/users', function(data) {
      if (data != "") {
        user_id = data
        $('#homepage-sign-up-btn').hide()
        $('#homepage-log-in-btn').hide()
        $('#homepage-create-listing-btn').show()
      } else {
        user_id = 1
        $('#homepage-sign-up-btn').show()
        $('#homepage-log-in-btn').show()
        $('#homepage-create-listing-btn').hide()
      }
    })
  }

 
  //// BOOKINGS

  function getCurrentListing(listings) {
    allListings = listings
  }

  function todaysDate() {
    var today = new Date()
    var yyyy = today.getFullYear()
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var dd = String(today.getDate() + 1).padStart(2, '0');
    today = yyyy + "-" + mm + "-" + dd
    return today
  }

  function createBooking(id){
    $('#booking').html(
      '<form action="../bookings" method="post">\
      <label for="from">Check In</label>\
      <input type="text" id="start_date" name="start_date">\
      <label for="to">Check Out</label>\
      <input type="text" id="end_date" name="end_date">\
      <input type="hidden" name="user_id" value='+ user_id +'> \
      <input type="hidden" name="listing_id" value=' + allListings[id].id + '>\
      <input type=submit id="dates" value="Book Now >"></form>'
    
    )
    $.get(`/bookings/dates/${allListings[id].id}`, function(data) {
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
      minDate: allListings[id].start_date, 
      maxDate: allListings[id].end_date,
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
      minDate: allListings[id].start_date, 
      maxDate: allListings[id].end_date,
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
