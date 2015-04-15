require 'spec_helper'

describe Marathon do
  let(:marathon) { FactoryGirl.create(:marathon) }
  subject { marathon }

  it { should belong_to :state }
  it { should belong_to :user }
  it { should respond_to :time }
  it { should respond_to :city }
  it { should respond_to :date_of_marathon }
end
