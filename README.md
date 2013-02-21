CKPhoneLib
==========

Objective-C phone number library


Reason
------

For whatever reason, you might want to extract the country code from the phone numbers provided by the addressbook.
These numbers are usually in various formats, and it's not always obvious which part is the country code, and which part is the phone number.

This library normalizes the phone numbers and uses [this table](http://www.itu.int/dms_pub/itu-t/opb/sp/T-SP-E.164D-2009-PDF-E.pdf) to parse and extract the country code.


Usage
-----

Include the two files `CKPhoneLib.h` and `CKPhoneLib.m` in your project, and import the .h file.

	#import "CKPhoneLib.h"

	....

	CKPhoneLib * phoneLib = [CKPhoneLib sharedClient];

	phoneLib.fallbackCountryCode = @"+961"; // Define a fallback country code for numbers that do not have a country code in them.

	NSDictionary * components = [phoneLib extractPhoneComponents:@"+1 (555) 123-4567"];

	NSLog(@"Country Code: %@ - Phone Number: %@", [components objectForKey:@"countryCode"], [components objectForKey:@"phoneNumber"]  );


