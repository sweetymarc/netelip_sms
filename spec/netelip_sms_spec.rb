require 'spec_helper'

describe NetelipSms do
  it "should return true when sending correctly a message" do
    expect(Net::HTTP).to receive(:post_form).with(NetelipSms::APIUri, anything) { double("response", code: 200) }
    expect(NetelipSms.send_sms(:token => "foo", :destination => "+34666666666", :message => "Lore ipsum", :from => "12345")).to be true
  end

  it "should return response code when message was not sent (code != 200)" do
    expect(Net::HTTP).to receive(:post_form).with(NetelipSms::APIUri, anything) { double("response", code: 401) }
    expect(NetelipSms.send_sms(:token => "foo", :destination => "+34666666666", :message => "Lore ipsum", :from => "12345")).to eq("401")
  end

  it "should raise an ArgumentError if no token present" do
    expect( proc {  NetelipSms.send_sms(:destination => "+34666666666", :message => "Lore ipsum", :from => "12345") }).to raise_error(ArgumentError, "Token must be present")
  end

  it "should raise an ArgumentError if no sender present" do
    expect( proc { NetelipSms.send_sms(:token => "foo",  :destination => "+34666666666", :message => "Lore ipsum") }).to raise_error(ArgumentError, "Sender must be present (from)")
  end

  it "should raise an ArgumentError if sender is more than 11 characters" do
    allow(Net::HTTP).to receive(:post_form).with(NetelipSms::APIUri, anything) { double("response", code: 200) }
    expect(NetelipSms).to receive(:warn).with("Sender length 11 characters exceded: <hidden> will appear")
    NetelipSms.send_sms(:token => "foo",  :destination => "+34666666666", :message => "Lore ipsum", :from => "012345678901") 
  end

  it "should raise an ArgumentError if destination is not a valid international number" do
    expect( proc { NetelipSms.send_sms(:token => "foo",  :destination => "666666666", :message => "Lore ipsum", :from => "12345") }).to raise_error(ArgumentError, "Recipient must be a telephone number with international format")
  end

  it "should raise an ArgumentError if no message present" do
    expect( proc { NetelipSms.send_sms(:token => "foo",  :destination => "+34666666666", :from => "12345") }).to raise_error(ArgumentError, "Message must be present")
  end

  it "should raise an ArgumentError if message is more than 160 characters" do
    expect( proc { NetelipSms.send_sms(:token => "foo",  :destination => "+34666666666", :message => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas commodo mattis ligula vitae malesuada. Vestibulum vulputate eros et lacus condimentum suscipit. Nulla cursus orci ac mauris ullamcorper gravida. Nullam neque lacus, facilisis ac tellus eget, congue consectetur turpis. Sed fringilla, dui nec facilisis lobortis, turpis neque volutpat leo, in ultrices orci lacus vel lacus. Sed dapibus tortor sit amet leo vulputate, sit amet facilisis felis fringilla. Nunc ultricies pulvinar nisi, non iaculis nibh condimentum at. In urna ipsum, condimentum quis purus ac, mollis pharetra mi.", :from => "12345") }).to raise_error(ArgumentError, "Message is 160 chars maximum")
  end

  it "should accept token for module configuration" do
    # Establish NetelipSms configuration
    NetelipSms.token = "foo"
    NetelipSms.from = "12345"

    expect(Net::HTTP).to receive(:post_form).with(NetelipSms::APIUri, anything) { double("response", code: 200) }

    expect( proc { expect(NetelipSms.send_sms(:message => "Lorem Ipsum", :destination => "+34666666666")).to be true }).not_to raise_error
  end
end
