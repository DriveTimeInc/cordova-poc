#!/bin/sh

echo "Start Cert Install"

P12_PASSWORD=$1


## ENCRIPT
# openssl des3 -in ./builds/GregBernsCert.cer -out ./builds/GregBernsCert.cer.enc
# openssl des3 -in ./builds/GregBernsPem.p12 -out ./builds/GregBernsPem.p12.enc
# openssl des3 -in ./builds/profile/Greg_Berns_DriveTime_Public_Mobile_Development.mobileprovision -out ./builds/profile/Greg_Berns_DriveTime_Public_Mobile_Development.mobileprovision.enc

# Decript Certs
openssl des3 -d -in ./builds/GregBernsCert.cer.enc -out ./builds/GregBernsCert.cer -k $P12_PASSWORD
openssl des3 -d -in ./builds/GregBernsPem.p12.enc -out ./builds/GregBernsPem.p12 -k $P12_PASSWORD
openssl des3 -d -in ./builds/profile/Greg_Berns_DriveTime_Public_Mobile_Development.mobileprovision.enc -out ./builds/profile/Greg_Berns_DriveTime_Public_Mobile_Development.mobileprovision -k $P12_PASSWORD

#echo $P12_PASSWORD

security create-keychain -p 'tempPassword' ios-build.keychain
security import ./builds/AppleWWDRCA.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./builds/GregBernsCert.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./builds/GregBernsPem.p12 -k ~/Library/Keychains/ios-build.keychain -P "$P12_PASSWORD" -T /usr/bin/codesign
security list-keychain -s ~/Library/Keychains/ios-build.keychain
security unlock-keychain -p 'tempPassword' ~/Library/Keychains/ios-build.keychain

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./builds/profile/* ~/Library/MobileDevice/Provisioning\ Profiles/

#sudo mkdir -p ./platforms/ios/cordova/
#sudo cp ./builds/build-release.xcconfig ./platforms/ios/cordova/build-release.xcconfig

echo "End Cert Install"
