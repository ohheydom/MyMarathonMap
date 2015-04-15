require 'spec_helper'

describe 'Marathon Pages' do
  subject { page }
  describe 'New' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit new_user_marathon_path(user)
    end

    it { should have_title('Add Marathon') }
    it { should have_select('marathon_state_id', with_options: ['Alaska', 'New Jersey', 'California']) }
  end

  describe 'Edit' do
    let(:user) { FactoryGirl.create(:user) }
    let(:marathon) { FactoryGirl.create(:marathon, user: user) }
    before do
      sign_in user
      visit edit_user_marathon_path(user.id, marathon)
    end

    it { should have_title('Edit Marathon') }
    it { should have_content('Edit Marathon') }
    it { should have_button('Remove') }

    describe 'delete button' do
      it 'deletes the marathon' do
        expect { click_button('Remove') }.to change(Marathon, :count).by(-1)
      end
    end

    describe 'save button' do
      let(:new_city) { 'new city' }
      before do
        fill_in 'City', with: new_city
        click_button 'Save'
      end

      it 'updates the marathon' do
        expect(marathon.reload.city).to eq(new_city)
      end
    end
  end
end
