require File.expand_path(File.dirname(File.dirname(__FILE__)) + '/spec_helper')

describe FacebookShare do
  include FacebookShare

  describe "building params" do
    before(:all) do
      @options = {
        :app_id => "123123123",

        :selector => "#some_fancy > .selector",
        :display => "popup",
        :link => "http://railslove.com/",
        :caption => "Railslove",
        
        :status => "true",
        :xfbml => "true",
        :cookie => "false"
      }
    end
    context "when not for_init" do
      subject { build_params(@options) }

      it { should_not match(/app_id/) }
      it { should_not match(/cookies/) }
      it { should_not match(/xfbml/) }

      it { should match(/display: "popup"/) }
      it { should match(/link: "http:\/\/railslove.com\/"/) }
      it { should match(/caption: "Railslove"/) }

      it { should_not match(/selector: "/) }
    end

    context "when for_init" do
      subject { build_params(@options, true) }

      it { should_not match(/app_id/) }
      it { should match(/cookie: "false"/) }
      it { should match(/xfbml: "true"/) }

      it { should_not match(/display: "popup"/) }
      it { should_not match(/link: "http:\/\/railslove.com\/"/) }
      it { should_not match(/caption: "Railslove"/) }

      it { should_not match(/selector: "/) }
    end
  end

  describe "creating init script" do
    context "when vanilla locale" do
      subject { facebook_connect_js_tag( :locale => "en_US" ) }
      
      it { should match(/\/en_US\/all\.js/) }
      it { should_not match(/\/en\/all\.js/) }
    end

    context "when shortened locale" do
      subject { facebook_connect_js_tag( :locale => "en" ) }
      
      it { should match(/\/en_EN\/all\.js/) }
      it { should_not match(/\/en\/all\.js/) }
    end

    context "when shortened locale 2" do
      subject { facebook_connect_js_tag( :locale => "pl" ) }
      
      it { should match(/\/pl_PL\/all\.js/) }
      it { should_not match(/\/pl\/all\.js/) }
    end
  end
end