$(document).ready(function(){
  var listings;
  /// check if user has signed in
  checkUser()

  /// GET ALL LISTINGS
   $.get('/listings', function(data) {
    listings = JSON.parse(data)
    showListings(listings)
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
      $('#show-listings').append(listingLink)
    }
  }

  function showListingDetails(listing_id) {
   $('#listing-details').empty().append(
     `Name: ${listings[listing_id].name}<br>
     price: ${listings[listing_id].price}<br>
     Description: ${listings[listing_id].description}<br>
     Start Date: ${listings[listing_id].start_date}<br>
     End Date: ${listings[listing_id].end_date}`
     )
   $('#homepage-sign-up-btn').hide()
   $('#show-listings').hide()
   $('#listing-details').show()
   $("#homepage-create-listing-btn").hide()
   $("#back-btn").show()
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
        $('#homepage-sign-up-btn').hide()
        $('#homepage-log-in-btn').hide()
        $('#homepage-create-listing-btn').show()
      } else {
        $('#homepage-sign-up-btn').show()
        $('#homepage-log-in-btn').show()
        $('#homepage-create-listing-btn').hide()
      }


    })
  }
 

})
