require 'spec_helper'

require 'mobme/infrastructure/utilities/core_ext/hash'

module MobME::Infrastructure::Utilities::CoreExtensions
  describe "Hash" do
    subject { {"foo" => {"bar" => "baz"}} }

    shared_examples_for "recursive key symbolization method" do
      it "recursively symbolizes keys in the hash" do
        subject.should == {:foo => {:bar => "baz"}}
        new_hash = {"test_2" => {:another => :hash, 123 => "456"}}
        new_hash.recursively_symbolize_keys!
        new_hash.should == {:test_2 => {:another => :hash, 123 => "456"}}
      end
    end

    describe "#recursive_symbolize_keys!" do
      before(:each) { subject.recursive_symbolize_keys! }

      it_should_behave_like "recursive key symbolization method"
    end

    describe "#recursively_symbolize_keys!" do
      before(:each) { subject.recursively_symbolize_keys! }

      it_should_behave_like "recursive key symbolization method"
    end
  end
end