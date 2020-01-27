feature 'Homepage' do
  scenario 'Hompage displays Makers Bnb name' do
    visit '/'
    expect(page).to have_content "Welcome to Makers BnB"
  end
end