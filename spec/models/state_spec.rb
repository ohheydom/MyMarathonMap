require 'rails_helper'

describe State do
  it { is_expected.to have_many :marathons }
  it { is_expected.to have_many :users }
  it { is_expected.to respond_to :state_name }
  it { is_expected.to respond_to :state }
end
