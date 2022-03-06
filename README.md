## mHide SafetyNet

**Magisk Module**<br>
_Module to help pass SafetyNet on devices that do **not** support hardware attestation._<br>

### Description
This module will
- Generate a list of 'sensitive' properties on the device and set the values to the 'safe' setting(s) during boot.
- Check and adjust some 'sensitive' properties during boot.
- Set Magisk's Denylist to enforcing.
- Add part of PlayServices to the DenyList.

**Requires _Zygisk_ to be enabled in Magisk.**<br>

This module is based on what was [MagiskHide](https://github.com/topjohnwu/Magisk/commit/003fea52b1857015bfc3988de56eb1a6d3049a7f).<br>
_This module includes some sensitive properties that are not always required to be (re)set to pass SafetyNet._<br>

---

### Warning
Disabling and/or removing this module will **not** revert the changes to the Denylist.<br>
- Set Magisk's Denylist to enforcing.
- Add part of PlayServices to the DenyList.

_These change(s) will have to be reverted manually or by another module/script._

---

### Download
Available in the releases tab. [Link](https://github.com/ipdev99/mModule_mhsn/releases)

### Install
- Copy the zip file to the device.
- Open Magisk Manager, select Modules and then Install from storage.
- Reboot device

### This is a Dead Project
- Reference and testing purposes only.
- No plans to maintain this module.

### Recent changes
- Resurrected this unreleased project for reference and testing.
- Cleaned up scripts for sharing (removed a bunch of WIP/personal notes).
- Updated the scripts for Magisk 23017 and newer.
- Added `ro.is_ever_orange` to the sensitive properties list.
- Bumped minimum Magisk version to 24000.

### Notes
- Feel free to use, change, improve, adapt.
- Remember to share.

### Credits
- The Android Community and everyone who has helped me learn through the years.
- John Wu for all things Magisk.
