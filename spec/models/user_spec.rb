require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Matee Safi',
      photo: 'https://example.com/test.jpg',
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      posts_counter: 0
    )
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'is valid without a photo' do
      subject.photo = ''
      expect(subject).to be_valid
    end

    it 'is not valid when posts_counter is not an integer' do
      subject.posts_counter = 'asdf'
      expect(subject).to_not be_valid
    end

    it 'is not valid when posts_counter is less than 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#recent_posts method check' do
    before do
      5.times do |index|
        Post.create(
          title: "Post #{index}",
          text: "This is the text for post #{index}",
          author: subject,
          comments_counter: 0,
          likes_counter: 0
        )
      end
    end

    it 'should return the most recent 3 posts' do
      expect(subject.recent_posts.length).to eq(3)
    end
  end
end
