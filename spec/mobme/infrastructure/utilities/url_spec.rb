require 'spec_helper'

require 'mobme-infrastructure-utilities/url'

module MobME::Infrastructure::Utilities

  describe 'URL' do
    subject { 'http://www.google.com' }

    it { should respond_to(:url) }
    it { should respond_to(:url?) }

    describe "#url" do
      it "removes whitespace from self" do
        "   http://google.com   ".url.should == "http://google.com"
      end

      context "when a valid URL is passed" do
        it "returns a properly formatted URL" do
          "google.com".url.should == "http://google.com"
          "https://www.facebook.com".url.should == "https://www.facebook.com"
          "127.0.0.12".url.should == "http://127.0.0.12"
          "file:///home/mobme/test".url.should == "file:///home/mobme/test"
          "scp://mobme@localhost:/home/mobme/test".url.should == "scp://mobme@localhost:/home/mobme/test"
          "scp://mobme@localhost:~/test".url.should == "scp://mobme@localhost:~/test"
          "scp://mobme@127.0.0.1:~/test".url.should == "scp://mobme@127.0.0.1:~/test"
          "scp://mobme@somewhere.com:~/test".url.should == "scp://mobme@somewhere.com:~/test"
          "scp://mobme@somewhere.ca:/home/mobme/test".url.should == "scp://mobme@somewhere.ca:/home/mobme/test"
        end
      end

      context "when an invalid URL is passed" do
        it "returns nil" do
          "google.c".url.should == nil
          "http//www.facebook.com".url.should == nil
          "127.0.0.1234".url.should == nil
          "file:/home/mobme/test".url.should == nil
          "scp//mobme@localhost/test".url.should == nil
          "scp://mobme:/test".url.should == nil
          "scp://mobme@somewhere.c:/test".url.should == nil
        end
      end
    end

    describe "#url?" do
      it "calls #url" do
        subject.should_receive(:url)
        subject.url?
      end

      context "if #url returns anything" do
        it "returns true" do
          subject.url?.should == true
        end
      end

      context "if #url returns nil" do
        it "returns false" do
          subject.stub(:url).and_return(nil)
          subject.url?.should == false
        end
      end
    end
  end
end