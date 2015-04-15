require 'spec_helper'

describe 'Static Pages' do
  subject { page }
  describe 'Home' do
    before { visit root_path }

    describe 'Authenticated User' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end

      it { should have_title(user.username) }
    end

    it { should have_title('My Marathon Map') }
    it { should have_link('What is this?', href: help_path) }
    it { should have_link('Sign Up', href: signup_path) }
    it { should have_button('Sign In') }
  end

  describe 'Help' do
    before { visit help_path }
    it { should have_title('Help') }
  end
end
