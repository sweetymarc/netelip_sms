Netelip SMS
===========

Provides a gateway to use Netelip SMS service over HTTPS POST

Usage
-----

    NetelipSms.send_sms(token: "netelip\_token",
                        from: "Max 11chars",
                        destination: "+34999999999",
                        message: "Message with 160 chars maximum")

- __Token__: supplied by Netelip.
- __From__: source SMS. Maximum 11 characters. Could be your company's name or source telephone number.
- __Destination__: destination number, international format.
- __Message__: Message to send, maximum 160 characters.

If message is sent correctly, it will return true. Otherwise, error code is returned.

More information
----------------

For more information, check Netelip API doc at:

https://static.netelip.com/downloads/manuales/netelip_api_sms.pdf

- This repository is licensed under the terms of the GNU General Public License v3.0 (gpl-3.0)
