require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Creating a new post', type: :feature do
  before do
    # Set up any necessary data or login as a user
    @user = User.create(username: 'testuser', email: 'test@example.com', password: 'password')
    login_as(@user, scope: :user)
  end

  scenario 'User creates a new post' do
    visit new_post_path

    fill_in 'Title', with: 'My First Post'
    fill_in 'Text', with: 'This is the content of my first post'
    click_button 'Create Post'

    expect(page).to have_content 'Post was successfully created.'
    expect(page).to have_content 'My First Post'
    expect(page).to have_content 'This is the content of my first post'
  end
end
