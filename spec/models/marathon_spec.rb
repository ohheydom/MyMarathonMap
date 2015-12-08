require 'rails_helper'

describe Marathon do
  let(:marathon) { FactoryGirl.create(:marathon) }
  subject { marathon }

  it { is_expected.to belong_to :user }
  it { is_expected.to respond_to :time }
  it { is_expected.to respond_to :city }
  it { is_expected.to respond_to :date_of_marathon }
end
