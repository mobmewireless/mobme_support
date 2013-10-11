require_relative '../../../spec_helper'

require 'mobme_support/core_ext/string/msisdn'

module MobmeSupport
  describe 'MSISDN' do
    subject { '9946759680' }

    it { should respond_to(:msisdn).with(1).argument }
    it { should respond_to(:msisdn?).with(1).argument }

    describe '#msisdn' do
      it 'removes whitespace from self' do
        msisdn_with_whitespace = '  9846819066  '
        msisdn_with_whitespace.msisdn.should == '9846819066'
      end

      context 'when a valid MSISDN is passed' do
        it 'returns the MSISDN in 10-digit form' do
          '9946759680'.msisdn.should == '9946759680'
          '919946759680'.msisdn.should == '9946759680'
          '+919946759680'.msisdn.should == '9946759680'
          '00919946759680'.msisdn.should == '9946759680'
        end
      end

      context 'when an invalid MSISDN is passed' do
        it 'returns nil' do
          '994675680'.msisdn.should == nil
          '+00919946759680'.msisdn.should == nil
        end
      end

      context 'when a custom country is passed' do
        it "returns the MSISDN in that country's local form" do
          '33280686'.msisdn('country' => 'BH').should == '33280686'
          '97333280686'.msisdn(country: 'BH').should == '33280686'
          '+97333280686'.msisdn(country: 'BH').should == '33280686'
          '0097333280686'.msisdn(country: 'BH').should == '33280686'
        end
      end

      context 'when a custom format is passed' do
        it 'returns the MSISDN in the requested format' do
          '9946759680'.msisdn(format: 'plus_country').should == '+919946759680'
          '33280686'.msisdn(country: 'BH', 'format' => 'international').should == '0097333280686'
          '0097333280686'.msisdn('country' => 'BH', format: 'country').should == '97333280686'
          '919946759680'.msisdn(format: 'local').should == '9946759680'
        end
      end
    end

    describe '#msisdn?' do
      context 'for valid msisdn' do
        it 'returns true' do
          '9946759680'.msisdn?.should == true
        end
      end

      context 'for invalid msisdn' do
        it 'returns false' do
          ' '.msisdn?.should == false
        end
      end

      context 'when passed custom options' do
        pending
      end
    end
  end
end
