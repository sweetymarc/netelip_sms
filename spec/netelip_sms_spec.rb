require 'spec_helper'

describe NetelipSms do
  it "should return true when sending correctly a message" do
    response = Object.new
    response.stub!(:code).and_return("200")
    Net::HTTP.should_receive(:post_form).with(NetelipSms::APIUri, anything).and_return(response)
    NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "0034666666666", :message => "Lore ipsum", :from => "12345").should == true
  end

  it "should return response code when message was not sent (code != 200)" do
    response = Object.new
    response.stub!(:code).and_return("401")
    Net::HTTP.should_receive(:post_form).with(NetelipSms::APIUri, anything).and_return(response)
    NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "0034666666666", :message => "Lore ipsum", :from => "12345").should == "401"
  end

  it "should raise an ArgumentError if no login present" do
    proc { NetelipSms.send_sms(:password => "bar", :destination => "0034666666666", :message => "Lore ipsum", :from => "12345") }.should raise_exception(ArgumentError, "Login must be present")
  end

  it "should raise an ArgumentError if no password present" do
    proc { NetelipSms.send_sms(:login => "foo", :destination => "0034666666666", :message => "Lore ipsum", :from => "12345") }.should raise_exception(ArgumentError, "Password must be present")
  end

  it "should raise an ArgumentError if no sender present" do
    proc { NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "0034666666666", :message => "Lore ipsum") }.should raise_exception(ArgumentError, "Sender must be present (from)")
  end

  it "should raise an ArgumentError if sender is more than 11 characters" do
    proc { NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "0034666666666", :message => "Lore ipsum", :from => "012345678901") }.should raise_exception(ArgumentError, "Sender length 11 characters maximum")
  end

  it "should raise an ArgumentError if destination is not a valid international number" do
    proc { NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "666666666", :message => "Lore ipsum", :from => "12345") }.should raise_exception(ArgumentError, "Recipient must be a telephone number with international format")
  end

  it "should raise an ArgumentError if no message present" do
    proc { NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "0034666666666", :from => "12345") }.should raise_exception(ArgumentError, "Message must be present")
  end

  it "should raise an ArgumentError if message is more than 140 characters" do
    proc { NetelipSms.send_sms(:login => "foo", :password => "bar", :destination => "0034666666666", :message => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas commodo mattis ligula vitae malesuada. Vestibulum vulputate eros et lacus condimentum suscipit. Nulla cursus orci ac mauris ullamcorper gravida. Nullam neque lacus, facilisis ac tellus eget, congue consectetur turpis. Sed fringilla, dui nec facilisis lobortis, turpis neque volutpat leo, in ultrices orci lacus vel lacus. Sed dapibus tortor sit amet leo vulputate, sit amet facilisis felis fringilla. Nunc ultricies pulvinar nisi, non iaculis nibh condimentum at. In urna ipsum, condimentum quis purus ac, mollis pharetra mi.", :from => "12345") }.should raise_exception(ArgumentError, "Message is 140 chars maximum")
  end

  it "should accept login, password, sender for module configuration" do
    # Establish NetelipSms configuration
    NetelipSms.login = "foo"
    NetelipSms.password = "bar"
    NetelipSms.from = "12345"

    response = Object.new
    response.stub!(:code).and_return("200")
    Net::HTTP.should_receive(:post_form).with(NetelipSms::APIUri, anything).and_return(response)

    proc { NetelipSms.send_sms(:message => "Lorem Ipsum", :destination => "0034666666666").should == true }.should_not raise_exception(ArgumentError)
  end
end
