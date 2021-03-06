require 'rails_helper'

describe 'Authentication' do
  subject { page }

  describe 'Sign In' do
    before { visit signin_path }

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end

      it { is_expected.to have_title(user.username) }
      it { is_expected.to have_link('Profile', href: user_path(user)) }
      it { is_expected.to have_link('Sign Out', href: signout_path) }
      it { is_expected.not_to have_link('Sign In', href: signin_path) }
    end

    describe 'with invalid information' do
      before { click_button 'sign_in_sign_in' }

      it { is_expected.to have_title('Sign In') }
      it { is_expected.to have_selector('div.alert.alert-error') }
    end

    it { is_expected.to have_title('Sign In') }
    it { is_expected.to have_content('Sign In') }
  end

  describe 'Authorization' do
    describe 'as incorrect user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrongperson@wrong.com', username: 'wronguser') }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to Wrong user's Edit", type: :request do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match('Edit User') }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
