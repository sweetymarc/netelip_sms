require 'active_support'
require 'active_support/core_ext'
require 'global_phone'
require 'net/http'
require 'net/https'

module NetelipSms

  APIUri = URI.parse("https://apps.netelip.com/sms/api.php")

  class << self

    @@token = ""
    @@from = ""

    def token=(token)
      @@token = token
    end

    def from=(sender)
      @@from = sender
    end

    # Send a petition to Netelip SMS gateway
    # 
    # Example:
    #   >> NetelipSms.send_sms(token: "netelip\_token",
    #                          from: "Max 11chars",
    #                          destination: "0034999999999",
    #                          message: "Message with 160 chars maximum")
    def send_sms(options = {})
      # Check for token
      token = options[:token] || @@token
      raise ArgumentError, "Token must be present" unless token and not token.blank?

      from = options[:from] || @@from
      raise ArgumentError, "Sender must be present (from)" unless from and not from.blank?
      warn "Sender length 11 characters exceded: <hidden> will appear" if (from.size > 11)

      raise ArgumentError, "Recipient must be a telephone number with international format" unless parsed = GlobalPhone.parse(options[:destination].to_s)
      destination = parsed.international_string.gsub("+", "00")

      message = options[:message].to_s
      raise ArgumentError, "Message must be present" if message.blank?
      raise ArgumentError, "Message is 160 chars maximum" if message.size > 160

      res = Net::HTTP.post_form(APIUri, 'token' => token,
                                        'from' => from,
                                        'destination' => destination,
                                        'message' => message)

      if res.code.to_s == "200"
        return true
      else
        return res.code.to_s
      end
    end

  end
end
