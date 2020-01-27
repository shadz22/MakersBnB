feature 'User Sign Up' do
  scenario 'User signs up using form' do
    # visit '/'
    # click_button 'Sign Up'

    visit '/users/new'
    fill_in 'name', :with => 'name1'
    fill_in 'email', :with => 'name1@email.com'
    fill_in 'password', :with => 'password'
    click_button 'Sign Up'
    expect(page).to have_content 'name1'
  end

end