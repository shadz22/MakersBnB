# frozen_string_literal: true

feature 'Creating a listing' do
  scenario 'on create listing page I want to be able to create a new listing and add to database' do
    visit('/listings/new')
    fill_in('create_name', with: 'Bob Jones')
    fill_in('description', with: 'Lovely clean room')
    fill_in('set_price', with: 50)
    click_button('Add Listing')
    expect(page).to have_content 'Bob Jones'
  end
end
