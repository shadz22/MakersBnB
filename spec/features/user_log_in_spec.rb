feature 'User Log In' do
  scenario 'a user can log it' do
    User.create(name: "Shadi", email: "shadi@email.com", password: "password1")
    visit '/sessions/new'
    fill_in(:email, with: 'shadi@email.com')
    fill_in(:password, with: 'password1')
    click_button('Sign Up')

    expect(page).to have_content 'Welcome to Makers Bnb shadi@email.com'
  end

end