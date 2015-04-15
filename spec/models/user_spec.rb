require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }

  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :remember_token }
  it { should respond_to :authenticate }
  it { should have_many :marathons }
  it { should have_many :states }

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

    its(:remember_token) { should_not be_blank }
  end
end
