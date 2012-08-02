require 'spec_helper'

require 'mobme_support/core_ext/hash'

module MobMESupport::CoreExtensions
  describe "Hash" do
    subject { {"foo" => {"bar" => "baz"}, :already_symbol => "far", 123 => "faz"} }

    describe "recursively_symbolize_keys" do
      it "returns a recursilvely symbolized version of the value" do
        subject.recursively_symbolize_keys.should == {:foo => {:bar => "baz"}, :already_symbol => "far", 123 => "faz"}
      end

      it "does not alter the original object" do
        subject.recursively_symbolize_keys
        subject.should == {"foo" => {"bar" => "baz"}, :already_symbol => "far", 123 => "faz"}
      end

      context "when the modify_nested_arrays flag is set to true" do
        it "recursively symbolizes nested Hashes if they are nested inside an Array" do
          with_hash_inside_array = {"foo" => {"bar" => [{"baz" => [{"qux" => "qar"}, "string"]}]}}
          with_hash_inside_array.recursively_symbolize_keys(true).should == {:foo => {:bar => [{:baz => [{:qux => "qar"}, "string"]}]}}
        end
      end

      context "when the modify_nested_arrays flag is not set" do
        it "does not recursively symbolize nested Hashes if they are nested inside an Array" do
          with_hash_inside_array = {"foo" => {"bar" => [{"baz" => "qux"}]}}
          with_hash_inside_array.recursively_symbolize_keys.should == {:foo => {:bar => [{"baz" => "qux"}]}}
        end
      end

      context "when a Hash or array contains other hashes or arrays" do
        it "does not modify original hashes or arrays" do
          sample_array = [{"foo" => "bar"}]
          sample_hash = {"far" => "bar"}
          hash_to_symbolize = {"array" => sample_array, "hash" => sample_hash}

          hash_to_symbolize.recursively_symbolize_keys(true)

          sample_array.should == [{"foo" => "bar"}]
          sample_hash.should == {"far" => "bar"}
        end
      end
    end

    describe "#recursively_symbolize_keys!" do
      it "replaces itself with the recursively symbolized version" do
        replacement_object = double "Replacement"
        subject.stub recursively_symbolize_keys: replacement_object
        subject.should_receive(:replace).with(replacement_object)
        subject.recursively_symbolize_keys!
      end
    end

    describe "#recursive_symbolize_keys" do
      it "is an alias for #recursively_symbolize_keys" do
        subject.method(:recursive_symbolize_keys).should == subject.method(:recursively_symbolize_keys)
      end
    end

    describe "#recursive_symbolize_keys!" do
      it "is an alias for #recursively_symbolize_keys!" do
        subject.method(:recursive_symbolize_keys!).should == subject.method(:recursively_symbolize_keys!)
      end
    end
  end

  describe "Array" do
    subject { [{"foo" => "bar"}, {"baz" => "qux"}] }

    describe "#recursively_symbolize_keys" do
      it "recursively symbolizes Hash values in the array" do
        subject.recursively_symbolize_keys.should == [{:foo => "bar"}, {:baz => "qux"}]
      end
    end

    describe "#recursively_symbolize_keys!" do
      it "replaces itself with the recursively symbolized version" do
        replacement_object = double "Replacement"
        subject.stub recursively_symbolize_keys: replacement_object
        subject.should_receive(:replace).with(replacement_object)
        subject.recursively_symbolize_keys!
      end
    end
  end
end
