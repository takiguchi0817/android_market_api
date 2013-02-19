# -*- coding: utf-8 -*-
require 'spec_helper'

describe AndroidMarketApi::Util do

  describe "#sanitize" do
    subject { AndroidMarketApi::Util.sanitize(str) }

    let(:str) { "aaa<br>bbb<br/>ccc<p>ddd</p>eee<br />" }

    it "should sanitize" do
      should == <<EOS
aaa
bbb
ccc ddd eee
EOS
    end
  end

  describe "#get_content" do
    subject{ AndroidMarketApi::Util.get_content(url, headers) }

    let(:url) { "https://github.com/" }
    let(:headers) { { "User-Agent" => "ruby"} }

    it{ should be_an_instance_of String }
    it{ should_not be_empty }
  end

end