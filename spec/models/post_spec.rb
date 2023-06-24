require 'rails_helper'

describe Post, type: :model do
  let(:user) { User.create(name: 'Matee') }

  subject { Post.new(title: 'Sample', text: 'This is a sample post', author: user) }
  before { subject.save }

  describe 'validations' do
    it 'validates presence of title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'validates maximum length of title' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'validates presence of text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'validates numericality of comments_counter' do
      subject.comments_counter = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'validates comments_counter is greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'validates numericality of likes_counter' do
      subject.likes_counter = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'validates likes_counter is greater than or equal to zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'recent_posts' do
    before(:example) do
      @user = User.create(name: 'Matee Safi', photo: 'https://example.com/test.png', bio: 'lorem ipsum', posts_counter: 0)
      @post = Post.create(title: 'Post', text: 'Lorem ipsum', author: @user, comments_counter: 0, likes_counter: 0)
    end

    let!(:comment1) do
      Comment.create(text: 'Comment 1', author: @user, post: @post)
    end
    let!(:comment2) do
      Comment.create(text: 'Comment 1', author: @user, post: @post)
    end
    let!(:comment3) do
      Comment.create(text: 'Comment 3', author: @user, post: @post)
    end
    let!(:comment4) do
      Comment.create(text: 'Comment 4', author: @user, post: @post)
    end
    let!(:comment5) do
      Comment.create(text: 'Comment 5', author: @user, post: @post)
    end
  end
end
