require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe '#update_post_counter' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, author: user) }

    it 'updates the posts_counter attribute of the associated user' do
      post.update_post_counter
      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end

  describe '#recent_comments' do
    let(:post) { create(:post) }
    let!(:recent_comments) { create_list(:comment, 5, post: post) }

    it 'returns the specified number of most recent comments for the post' do
      expect(post.recent_comments(3)).to eq(recent_comments.reverse.take(3))
    end
  end
end
