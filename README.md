Netelip SMS
===========

Provides a gateway to use Netelip SMS service over HTTP POST

Usage
-----

    NetelipSms.send_sms(:login => "netelip\_login",
                        :password => "netelip\_password", 
                        :from => "Max 11chars",
                        :destination => "0034999999999",
                        :message => "Message with 140 chars maximum")

_Login_: supplied by Netelip
_Password_: supplied by Netelip
_From_: source SMS. Maximum 11 characters. Could be your company's name or source telephone number
_Destination_: destination number, international format.
_Message_: Message to send, maximum 140 characters.

If message is sent correctly, it will return true. Otherwise, error code is returned.

More information
----------------

For more information, check Netelip API doc at:
http://netelip.es/downloads/manuales/netelip\_api\_sms.pdf

- Copyright (c) 2013 Angel García Pérez
