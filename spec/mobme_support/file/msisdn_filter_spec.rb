require_relative '../../spec_helper'

require 'mobme_support/file/msisdn_filter'

module MobmeSupport::FileOperations
  describe "MSISDNFilter" do
    subject { MSISDNFilter }

    it { should respond_to(:filter).with(1).argument }
    it { should respond_to(:filter).with(2).arguments }

    describe ".filter" do
      before :each do
        MSISDNFilter.stub(:get_file_contents)
      end

      context 'when passed valid path to a file' do
        it 'returns array of filtered numbers' do
          #MSISDNFilter.stub(:get_file_contents).and_return("9876543210\n+919876543210\n00919876543211\n876543210")
          MSISDNFilter.stub(:get_file_contents).and_return(%w(9876543210 9876543210 9876543211))
          expected_output = %w(9876543210 9876543210 9876543211)
          MSISDNFilter.filter('/a/file/that/doesnt/exist').should == expected_output
        end

        context 'when custom country and format are specified' do
          before :each do
            MSISDNFilter.stub(:get_file_contents).and_return(%w(36543210 97336543211 +97336543212 876543210))
          end

          it "returns array of filtered numbers" do
            expected_output_plus_country = ["+97336543210", "+97336543211", "+97336543212"]
            expected_output_international = ["0097336543210", "0097336543211", "0097336543212"]
            options = {
              :country => "BH",
              :format => "plus_country"
            }
            MSISDNFilter.filter("/a/file/that/doesnt/exist", options).should == expected_output_plus_country
            options[:format] = "international"
            MSISDNFilter.filter("/a/file/that/doesnt/exist", options).should == expected_output_international
          end

          context "when an invalid format is specified" do
            it "raises an error" do
              options = {
                :country => "BH",
                :format => "invalid_format"
              }
              expect {
                MSISDNFilter.filter("/a/file/that/doesnt/exist", options)
              }.to raise_error
            end
          end
        end
      end
    end

    describe '.get_file_contents' do
      pending 'needs to be tested with mocked file system'

      #it "returns contents of file at specified path" do
      #  mock_file_contents = double("File contents")
      #  File.stub(:open).and_return(double(File, :read => mock_file_contents, :close => nil))
      #  MSISDNFilter.send(:get_file_contents, "/path/to/non-existent/sample/file").should == mock_file_contents
      #end
    end
  end
end