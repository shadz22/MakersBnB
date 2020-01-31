
feature 'authentication' do
  it 'a user can log in' do
    
    User.create(name: 'Shadi', email: 'shadi@example.com', password: 'password123')

    visit '/sessions/new'
    fill_in(:email, with: 'shadi@example.com')
    fill_in(:password, with: 'password123')
    click_button('Log in')

    expect(page).to have_content 'Shadi'
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.create(email: 'test@example.com', password: 'password123')

    visit '/sessions/new'
    fill_in(:email, with: 'nottherightemail@me.com')
    fill_in(:password, with: 'password123')
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password.'
  end
end