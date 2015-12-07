require 'rails_helper'

describe 'User Pages' do
  subject { page }
  describe 'Sign Up' do
    before { visit signup_path }
    let(:submit) { 'Create my account!' }

    describe 'with invalid information' do
      it 'does not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      it 'does not create a user with a bad email address' do
        fill_in 'sign_up_username', with: 'Test1'
        fill_in 'sign_up_email', with: 'test'
        fill_in 'sign_up_password', with: 'tester12'
        fill_in 'sign_up_password_confirmation', with: 'tester12'
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'sign_up_username', with: 'Test1'
        fill_in 'sign_up_email', with: 'test1@test.com'
        fill_in 'sign_up_password', with: 'tester12'
        fill_in 'sign_up_password_confirmation', with: 'tester12'
      end

      it 'creates a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    it { is_expected.to have_title('Sign Up') }
    it { is_expected.to have_selector('h2', 'Sign Up') }
  end

  describe 'Sign In' do
    before { visit signin_path }

    it { is_expected.to have_link('Sign Up now!', href: signup_path) }
    it { is_expected.to have_content('Not a User, Sign Up now!') }
  end

  describe 'Edit' do
    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user, username: 'wrong user', email: 'wronguser@wronguser.com') }

    describe 'Correct User' do
      before do
        sign_in(user)
        visit edit_user_path(user)
      end

      describe 'Page' do
        it { is_expected.to have_title('Edit User') }
        it { is_expected.to have_content('Edit Settings') }
      end

      describe 'with invalid information' do
        before { click_button 'Save Settings' }
        it { is_expected.to have_css('.alert.alert-notice') }
      end
    end

    describe 'Wrong user' do
      before do
        sign_in(wrong_user)
        visit edit_user_path(user)
      end

      it { is_expected.not_to have_title('Edit User') }
      it { is_expected.to have_title(wrong_user.username) }
    end
  end

  describe 'Show' do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user, username: 'other user', email: 'other_user@other.com') }

    before do
      FactoryGirl.create(:marathon, user: user)
      sign_in(user)
    end

    describe "User's Page" do
      describe 'Statistics' do
        it { is_expected.to have_content('Average Time') }
        it { is_expected.to have_content('50 State Progress') }
        it { is_expected.to have_content('Personal Record') }
        it { is_expected.to have_content('Total States') }
        it { is_expected.to have_content('Average Pace') }
      end

      it { is_expected.to have_title(user.username) }
      it { is_expected.to have_link('Add a New Marathon!', href: new_user_marathon_path(user)) }
      it { is_expected.not_to have_selector('#matching_states') }
      it { is_expected.to have_selector('table tr') }
      it { is_expected.to have_selector('table th', text: 'Date') }
      it { is_expected.to have_selector('table th', text: 'State') }
      it { is_expected.to have_selector('table th', text: 'City') }
      it { is_expected.to have_selector('table th', text: 'Time') }
      it { is_expected.to have_link('Alabama', href: edit_user_marathon_path(user, 1)) }
    end

    describe "Other User's Page" do
      before do
        visit user_path other_user
      end
      it { is_expected.to have_title(other_user.username) }
      it { is_expected.to have_selector('#matching_states') }
      it { is_expected.not_to have_link('Add a New Marathon!', href: new_user_marathon_path(other_user)) }
    end
  end
end
