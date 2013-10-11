require_relative '../../spec_helper'

require 'mobme_support/file/msisdn_filter'

module MobmeSupport::FileOperations
  describe 'MSISDNFilter' do
    include FakeFS::SpecHelpers

    subject { MSISDNFilter }

    before :each do
      FakeFS.activate!
    end

    after :each do
      FakeFS.deactivate!
    end

    describe '.filter' do
      context 'when passed valid path to a file' do
        before :each do
          File.open('/line_separated_numbers.txt', 'w') do |f|
            f.write %w(+919876543210 +919876543211 +919876543212).join "\n"
          end
        end

        it 'returns array of filtered numbers' do
          subject.filter('/line_separated_numbers.txt').should == %w(9876543210 9876543211 9876543212)
        end

        context 'when format is specified' do
          it 'returns array of filtered numbers with custom format' do
            subject.filter('/line_separated_numbers.txt', format: 'international').should == %w(00919876543210 00919876543211 00919876543212)
          end

          context 'when an invalid format is specified' do
            it 'raises an error' do
              expect {
                subject.filter('/line_separated_numbers.txt', format: 'unknown_format')
              }.to raise_error(StandardError)
            end
          end
        end
        context 'when custom country is specified' do
          before :each do
            File.open('/line_separated_numbers.txt', 'w') do |f|
              f.write %w(9876543210 +358401234560 +919876543212 00358401234561 401234562).join "\n"
            end
          end

          it 'returns array of filtered numbers for specified country' do
            subject.filter('/line_separated_numbers.txt', country: 'FI', format: 'plus_country').should == %w(+358401234560 +358401234561 +358401234562)
          end

          context 'when unknown country code is specified' do
            it 'raises an error' do
              expect {
                subject.filter('/line_separated_numbers.txt', country: 'XX')
              }.to raise_error(StandardError)
            end
          end
        end
      end

      context 'when passed invalid file path' do
        it 'raises an error' do
          expect {
            subject.filter('/non_existent_file.txt')
          }.to raise_error(StandardError)
        end
      end
    end
  end
end