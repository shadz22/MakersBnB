feature 'Homepage' do
  scenario 'Hompage displays Makers Bnb name' do
    visit '/'
    expect(page).to have_content "Welcome to Makers BnB"
  end

  scenario 'Homepage has the sign up button' do
    visit '/'
    expect(page).to have_button "Sign Up"
  end
end

