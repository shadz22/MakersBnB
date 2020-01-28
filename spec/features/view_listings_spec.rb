feature 'View Listings' do

  scenario 'Listings displayed on page' do
    visit '/listings/new'
    fill_in 'create_name', with: 'Listing Name'
    fill_in 'description', with: 'Listing Description'
    fill_in 'set_price', with: 500
    click_button 'Add Listing'
    expect(page).to have_content 'Listing Description'
  end
end