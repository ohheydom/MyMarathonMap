require_relative '../../lib/time_converter'

describe TimeConverter do
  it { TimeConverter.new(0).seconds_to_s.should eq('00:00:00') }
  it { TimeConverter.new(1204).seconds_to_s.should eq('00:20:04') }
  it { TimeConverter.new(3600).seconds_to_s.should eq('01:00:00') }
  it { TimeConverter.new(3601).seconds_to_s.should eq('01:00:01') }
  it { TimeConverter.new(7200).seconds_to_s.should eq('02:00:00') }
  it { TimeConverter.new(72_000).seconds_to_s.should eq('20:00:00') }
  it { TimeConverter.new(144_000).seconds_to_s.should eq('40:00:00') }
end
