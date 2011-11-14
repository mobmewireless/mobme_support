require 'spec_helper'

require 'mobme/infrastructure/utilities/core_ext/hash'

module MobME::Infrastructure::Utilities::CoreExtensions
  describe "Hash" do
    subject { {"foo" => {"bar" => "baz"}} }

    describe "#recursive_symbolize_keys!" do
      it "calls recursively_symbolize_keys!, and returns its return" do
        mock_return = double("Recursively Symbolized Hash")
        subject.stub(:recursively_symbolize_keys!).and_return(mock_return)
        subject.should_receive(:recursively_symbolize_keys!)
        subject.recursive_symbolize_keys!.should == mock_return
      end
    end

    describe "#recursively_symbolize_keys!" do
      it "recursively symbolizes keys in the hash" do
        subject.recursively_symbolize_keys!
        subject.should == {:foo => {:bar => "baz"}}
        new_hash = {"test_2" => {:another => :hash, 123 => "456"}}
        new_hash.recursively_symbolize_keys!
        new_hash.should == {:test_2 => {:another => :hash, 123 => "456"}}
      end
    end
  end
end