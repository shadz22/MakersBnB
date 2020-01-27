feature 'User account page' do
  scenario 'has create listing button' do
    visit '/users'
    expect(page).to have_button 'Create Listing'
  end
end