require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }

  it { is_expected.to respond_to :username }
  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :remember_token }
  it { is_expected.to respond_to :authenticate }
  it { is_expected.to have_many :marathons }

  describe 'when emails are the same' do
    before do
      @user = User.create(username: 'aaaaaaa', email: 'aaa@aaa.com')
      @user_with_same_email = User.new(username: 'bbbbbb', email: 'aaa@aaa.com')
      @user_with_same_email.save
    end

    it 'is not valid' do
      expect(@user_with_same_email).not_to be_valid
    end
  end

  describe 'remember token' do
    before do
      @user = User.new(username: 'test', email: 'test@test.com', password: 'tester12', password_confirmation: 'tester12')
    end
    before { @user.save }

    describe '#remember_token' do
      subject { super().remember_token }
      it { is_expected.not_to be_blank }
    end
  end
end
