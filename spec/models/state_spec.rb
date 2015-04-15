require 'spec_helper'

describe State do
  it { should have_many :marathons }
  it { should have_many :users }
  it { should respond_to :state_name }
  it { should respond_to :state }
end
