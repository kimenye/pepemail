require 'test_helper'

class SmsServiceTest < ActiveSupport::TestCase

  test "It can tell between a kenyan and non kenyan number" do
  	assert_equal true, SmsService.is_kenyan?("254808766353")
  	assert_equal false, SmsService.is_kenyan?("256808766353")
  end

  test "It creates a different request url" do
  	xml = "<?xml version=\"1.0\"?>
      <methodCall>
        <methodName>EAPIGateway.SendSMS</methodName>
        <params>
          <param>
            <value>
              <struct>
                <member>
                  <name>Numbers</name>
                  <value>254705866564</value>
                </member>
                <member>
                  <name>SMSText</name>
                  <value>Hello World</value>
                </member>
                <member>
                  <name>Password</name>
                  <value>#{ENV['PASSWORD']}</value>
                </member>
                <member>
                  <name>Service</name>
                  <value>
                    <int>#{ENV['SERVICE_ID_KE']}</int>
                  </value>
                </member>
                <member>
                  <name>Receipt</name>
                  <value>N</value>
                </member>
                <member>
                  <name>Channel</name>
                  <value>#{ENV['CHANNEL_ID_KE']}</value>
                </member>
                <member>
                  <name>Priority</name>
                  <value>Urgent</value>
                </member>
                <member>
                  <name>MaxSegments</name>
                  <value>
                    <int>2</int>
                  </value>
                </member>
              </struct>
            </value>
          </param>
        </params>
      </methodCall>"
      assert_equal xml, SmsService.create_message("254705866564", "Hello World") 
  end
end