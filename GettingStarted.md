
# Apple Provisioning Overview

Before doing any work with Apple's Provisioning system, please watch the first two sections of this Pluralsight course.
This process is very confusing and complicated. The course provides both background and explicit steps on how to get started.

https://app.pluralsight.com/library/courses/deploying-ios-apps/table-of-contents


## Certificates


## Application ids:
Uniquely identify each application
Uniquely associated with a single iOS developer team
com.drivetime.publicmobile

Bundle Identifiers:
AppIds are related to bundle identifiers
ApplicationId can match one or several Bundle Identifiers
Are the reverse-DNS style identifiers configured in the XCode project

Can use a WildcardId to match your applications
BUT cannot use if your app uses Push Notification

## Device Ids
UDID - uniquiely identifies a device

## Provisioning Profiles
Tie together:
 - Certificates - who is installing the software, are they are registered iOS developer
 - Application Identifiers - what software is allowed to be installed
 - Device Identifiers - what devices the software can be installed on
Provisioning profiles **do expire** and need to be renewed through the portal

## Team Provisioning Profiles
Profiles managed exclusively by XCode, cannot be edited in portal.

## Apple Web Sites

* Dev Center - Documentation, Downloads, Beta Software
https://developer.apple.com/develop/

* Member Center - Manage Apple Developer Membership
https://developer.apple.com/account

* Provisioning Portal - Manage Cryptographic Information
https://developer.apple.com/account/ios/certificate/







# Provisioning Steps

## Create 'Development' Certificate

Overview:
1) Create 'Certificate Signing Request' (CSR)
2) Submit the CSR to Apple to generate a certificate
3) Download and install certificate

Steps:

**IMPORTANT: Lock your Keychain before running the Certificate Signing Assistant**
1) Go to https://developer.apple.com/account/ios/certificate/development/create
2) Go to Certificates > Development, select the "iOS App Development" option
3) NOTE: on the Certificates page, if your Mac is new you may need to download the 'Worldwide Developer Relations Certificate Authority" cert, so that the cert you create is based off theirs
4) Follow directions on how to create a 'Certificate Signing Request'
  a) In the Applications folder on your Mac, open the Utilities folder and launch Keychain Access.
  b) Within the Keychain Access drop down menu, select Keychain Access > Certificate Assistant > Request a Certificate from a Certificate Authority.
  c) In the Certificate Information window, enter the following information:
  d) In the User Email Address field, enter your email address.
  e) In the Common Name field, create a name for your private key (e.g., John Doe Dev Key).
  f) The CA Email Address field should be left empty.
  g) In the "Request is" group, select the "Saved to disk" option.
  h) Click Continue within Keychain Access to complete the CSR generating process.
  i) Download 'CertificateSigningRequest.certSigningRequest' file (This is a temporary file you won't need to hand onto)
6) In "Generate your certificate", upload signing request
7) Certificate is created. Download 'ios_development.cer' file

#### Generating a .p12 File (Optional)

A .p12 file may be helpful when other systems are building your app, or you need to use your cert on another machine.

1) In 'Keychain Access', right click the cert
2) Select 'Export...'
3) Provide a name for the file
4) Provide a password to protect the p12 file

## Register Devices

### Get Device UDID

Need to get the UDID, there are several ways to do this. (Follow these directions: http://whatsmyudid.com/)

#### XCode

1) Connect your device
2) Go to XCode > Window > Devices and Simulators
3) Select device from the list
4) Find "Identifier" and copy the value

#### iTunes

1) Plug iPhone into computer with iTunes
2) Open iTunes
3) In top left find iPhone symbol, click
4) In the summary, find "Serial Number", click on it
5) "Serial Number" will change to "UDID", right click on the number and click copy

### Register Development Device

1) Go to https://developer.apple.com/account/ios/device/iphone
2) Register the device, add Name and UDID
3) Confirm


## Create Application Ids

This is used if you are creating a new application.

1) Go to Identifiers > App IDs
2) Add an App ID Description - This is the 'english' name so others understand what this App is
3) The App ID Prefix will match your 'Team Prefix Id' (No change needed)
4) In "Explicit App Id", put in the full Bundle ID you want to match - which is the AppId you use in your app
5) Add any other capabilities like Push Notifications


## Create Development Provisioning Profile

This will tie a certificate, to an app, to a physical device.

1) Go to 'Provisoning Profiles' https://developer.apple.com/account/ios/profile/limited
2) Click the '+' to add a new profile
2) Under 'Development' select 'iOS App Development'
3) In 'App Id', select the specific Application ID created earlier
4) Select certificate previously created
5) Select devices
6) Provide a name for the profile
7) Download the Provisioning Profile file 'Greg_Berns_Dev_Profile.mobileprovision'




## Signing on VSTS CI/CD

This should get the signing information to build the iOS project

Directions found here:
https://docs.microsoft.com/en-us/vsts/build-release/apps/mobile/secure-certs#iosinstall

1) Get the 'signing identity' with the following terminal command `security find-identity -v -p codesigning`
2) Get the UUID for the Mobile Provisioning Profile (Do a Google Search to find out how. Hint: the files are stored here with the GUID/UUID in the file name `./Library/MobileDevice/Provisioning Profiles/`)
3) In VSTS Cordova plugin's 'iOS' section, set the 'Overrode Signing Using' setting to 'Identifiers', set the 'Signing Identity' and 'Provisioning Profile UUID'



## Problems

**"Unable to log in with account"**

Error:
```
Code Signing Error: The operation couldn’t be completed. Unable to log in with account 'greg.berns@silverrockinc.com'. The login details for account 'greg.berns@silverrockinc.com' were rejected.
```

Resolution:

Go to "Preferences" -> "Accounts", where it turned out my Apple ID had timed-out.

https://stackoverflow.com/questions/41515021/xcode-8-signing-errors-cant-login-with-account-and-no-provisioning-profile

