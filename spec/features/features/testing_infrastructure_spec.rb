# frozen_string_literal: true

feature 'Testing Infrastructure' do
  scenario 'it says Hello World' do
    visit('/')
    expect(page).to have_content 'Bookmark Manager'
  end
end
