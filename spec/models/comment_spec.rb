require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  describe 'Associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:content) }
  end
end
