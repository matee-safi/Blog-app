require 'rails_helper'

describe 'Users Show', type: :feature do
  let :user do
    User.create(name: 'Akai321', photo: 'https://Akaiiii.jpg', bio: 'Martial Artist')
  end

  let! :post1 do
    Post.create(author_id: user.id, title: 'The way of the Water',
                text: 'In martial arts, the way of the water is the way of the soft and yielding')
  end

  let! :post2 do
    Post.create(author_id: user.id, title: 'Amaterasu',
                text: 'Amaterasu is the goddess of the sun and the universe, the ultimate source of all life')
  end

  let! :post3 do
    Post.create(author_id: user.id, title: 'Legacy', text: 'The legacy of the righteous is a blessing')
  end

  let! :comment1 do
    Comment.create(user_id: user.id, post_id: post1.id, text: 'I like this post')
  end

  before { visit user_path(user) }

  scenario "I can see the user's profile picture" do
    expect(page).to have_css("img[src*='https://Akaiiii.jpg']")
  end

  scenario "I can see the user's username" do
    expect(page).to have_content('Akai321')
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content('Number of posts: 3')
  end

  scenario "I can see the user's bio" do
    expect(page).to have_content('Martial Artist')
  end

  scenario "I can see the user's first 3 posts" do
    expect(page).to have_content('The way of the Water')
    expect(page).to have_content('Amaterasu')
    expect(page).to have_content('Legacy')
  end

  scenario "When I click a user's post, it redirects me to that post's show page" do
    click_link 'The way of the Water'
    expect(page).to have_current_path(user_post_path(user, post1))
  end

  scenario 'Checks recent_posts method' do
    expect(user.recent_posts).to eq([post3, post2, post1])
  end
end
