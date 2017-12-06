#!/bin/sh

P12_PASSWORD=$1

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
