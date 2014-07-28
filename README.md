Netelip SMS
===========

Provides a gateway to use Netelip SMS service over HTTP POST

Usage
-----

    NetelipSms.send_sms(:login => "netelip\_login",
                        :password => "netelip\_password", 
                        :from => "Max 11chars",
                        :destination => "+34999999999",
                        :message => "Message with 140 chars maximum")

- __Login__: supplied by Netelip.
- __Password__: supplied by Netelip.
- __From__: source SMS. Maximum 11 characters. Could be your company's name or source telephone number.
- __Destination__: destination number, international format.
- __Message__: Message to send, maximum 140 characters.

If message is sent correctly, it will return true. Otherwise, error code is returned.

More information
----------------

For more information, check Netelip API doc at:
http://netelip.es/downloads/manuales/netelip_api_sms.pdf

- Copyright (c) 2013 Angel García Pérez
