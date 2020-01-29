$(document).ready(function() {

  $("#homepage-sign-up-btn").on("click", function() {
   signUpForm()
  })
  
  function signUpForm() {
    $("#sign-up-form").html(
      "<form id='sign-up' action='../users' method='post'>\
      Name: <input type=text id='name' name='name'><br>\
      Email: <input type=text id='email' name='email'><br>\
      Password: <input type=text id='password' name='password'><br>\
    <input type=submit value='Sign Up'/>\
    </form>"
    )
  }
})
