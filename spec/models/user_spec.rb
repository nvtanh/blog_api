require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('example@domain.com').for(:email) }
  end
end
