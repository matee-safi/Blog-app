require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    let(:user) { create(:user) }
    let!(:recent_posts) { create_list(:post, 5, author: user) }

    it 'returns the specified number of most recent posts for the user' do
      expect(user.recent_posts(3)).to eq(recent_posts.reverse.take(3))
    end
  end
end