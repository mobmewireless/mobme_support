require 'bundler/setup'

require 'rspec'
require 'spec_helper'

require 'mobme-infrastructure-utilities/msisdn'

module MobME::Infrastructure::Utilities

  describe 'MSISDN' do
    subject { '9946759680' }

    it { should respond_to(:msisdn) }
    it { should respond_to(:msisdn?) }

    describe "#msisdn" do

      it "removes whitespace from self" do
        msisdn_with_whitespace = '  9846819066  '
        msisdn_with_whitespace.msisdn.should == '9846819066'
      end

      context "when a valid MSISDN is passed" do
        it "returns the MSISDN in 10-digit form" do
          '9946759680'.msisdn.should == '9946759680'
          '919946759680'.msisdn.should == '9946759680'
          '+919946759680'.msisdn.should == '9946759680'
          '00919946759680'.msisdn.should == '9946759680'
        end
      end

      context "when an invalid MSISDN is passed" do
        it "returns nil" do
          '994675680'.msisdn.should == nil
          '+00919946759680'.msisdn.should == nil
        end
      end
    end

    describe "#msisdn?" do
      it "calls #msisdn" do
        subject.should_receive(:msisdn)
        subject.msisdn?
      end

      context "if #msisdn returns anything" do
        it "returns true" do
          subject.stub(:msisdn).and_return('9946759680')
          subject.msisdn?.should == true
        end
      end

      context "if #msisdn returns nothing" do
        it "returns false" do
          subject.stub(:msisdn).and_return(nil)
          subject.msisdn?.should == false
        end
      end
    end
  end
end