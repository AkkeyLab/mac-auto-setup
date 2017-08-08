# mac-auto-setup
Auto setup system for macOS.

## macOS version
macOS Sierra 10.12.3

## Downloads
To get started please run:
```
git clone https://github.com/AkkeyLab/mac-auto-setup.git ~/mac-auto-setup
```

## Installation
To get started please run:
```
~/mac-auto-setup/setup.sh
```
Install GUI apps:
```
~/mac-auto-setup/app.sh
```
Install App Store apps:
```
~/mac-auto-setup/appstore.sh
```
Update apps and settings:
```
~/mac-auto-setup/update.sh
```

## Apps config file
| Apps | Config | Remarks |
|:----------:|:-----------|:-------------|
|Mail|`~/Library/Mail/V2`<br>`~/Library/Mail/V3`<br>`~/Library/Containers/com.apple.mail`|No save password|
|keychain Access|`~/Library/Keychains/*.keychain`<br>or iCloud|keychain password is login password|
|AddressBook|`~/Library/Application Support/AddressBook/*`<br>or iCloud|-|
|Cyberduck|`~/Library/Application Support/Cyberduck/*`|-|
|SourceTree|`~/Library/Application Support/SourceTree/*`|-|
|SSH|`~/.ssh/config`<br>`~/.ssh/[Key file]`|-|
|VMware Horizon View Client|`~/Library/Preferences/com.vmware.horizon.plist`|-|
|Xcode|`Preference > Fonts & Colors > Dusk`<br>`Preference > Accounts import *.developerprofile`|-|
|Slack|`~/Library/Containers/com.tinyspeck.slackmacgap/Data/Library/Application Support/Slack/storage/*`|-|
