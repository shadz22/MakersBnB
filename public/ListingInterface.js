$(document).ready(function(){
  var currentListing;
  var listings;

  $("#homepage-create-listing-btn").on("click", function() {
    createListingForm()
   })

   $.get('/listings', function(data) {
    listings = JSON.parse(data)
    showListings(listings)
  })

  $('#homepage-create-listing-btn').hide()
  $('#create-booking-btn').hide()
  $('#view-booking-btn').hide()
  $("#back-btn").on("click", function() {
    $('#show-listings').show()
    $('#homepage-sign-up-btn').show()
    $('#listing-details').hide()
   })
  
  //  function backButton() {

  //  }

   function createListingForm() {
     $("#create-listing-form").html(
      '<form action="/listings" method="post">\
      <input type="text" name="create_name" placeholder="Enter name here:" required>\
      <input type="textarea" id="description" rows="4" cols="50" maxlength="200" name="description" placeholder="Enter description here:" required>\
      <input type="number" name="set_price" placeholder="Enter price: £" required>\
       <input type="date" name="start_date" placeholder="Enter start date here:" required>\
        <input type="date" name="end_date" placeholder="Enter end date here:" required>\
      <input type="submit" value="Add Listing" />\
    </form>'
     )
   }





  // $('#show-listings-btn').one('click', function() {
  //   $.get('/listings', function(data) {
  //     listings = JSON.parse(data)
  //     showListings(listings)
  //   })
  // });



  

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
  }


})
