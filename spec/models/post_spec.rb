require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:content) }
  end

end
