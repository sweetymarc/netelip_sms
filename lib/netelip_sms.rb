require 'phone'
require 'net/http'

module NetelipSms

  PhoneFormat = "00%c%a%n"
  APIUri = URI.parse("http://sms.netelip.com/api.php")

  class << self

    @@login = ""
    @@password = ""
    @@from = ""

    def login=(username)
      @@login = username
    end

    def password=(secret)
      @@password = secret
    end

    def from=(sender)
      @@from = sender
    end

    # Send a petition to Netelip SMS gateway
    # 
    # Example:
    #   >> NetelipSms.send_sms(:login => "netelip\_login",
    #                          :password => "netelip\_password", 
    #                          :from => "Max 11chars",
    #                          :destination => "0034999999999",
    #                          :message => "Message with 140 chars maximum")
    def send_sms(options = {})
      # Check for login
      login = options[:login] || @@login
      raise ArgumentError, "Login must be present" unless login and not login.blank?

      # Check for password
      password = options[:password] || @@password
      raise ArgumentError, "Password must be present" unless password and not password.blank?

      from = options[:from] || @@from
      raise ArgumentError, "Sender must be present (from)" unless password and not from.blank?
      raise ArgumentError, "Sender length 11 characters maximum" if (from.size > 11)

      raise ArgumentError, "Recipient must be a telephone number with international format" unless Phoner::Phone.valid?(options[:destination].to_s)
      destination = Phoner::Phone.parse(options[:destination].to_s).format(PhoneFormat)

      message = options[:message].to_s
      raise ArgumentError, "Message must be present" if message.blank?
      raise ArgumentError, "Message is 140 chars maximum" if message.size > 140

      res = Net::HTTP.post_form(APIUri, 'login' => login,
                                        'password' => password,
                                        'from' => from,
                                        'destination' => destination,
                                        'message' => message)

      if res.code == "200"
        return true
      else
        return res.code
      end
    end

  end
end
