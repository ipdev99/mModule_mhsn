#!/system/bin/sh

# mHide SafetyNet
#
# Set device sensitive properties to help pass SafetyNet.
# ipdev @ xda-developers

# Set functions

add_prop() {
    if [[ $(getprop $1) ]]; then
        echo $1"="$2 >>$MODPATH/system.prop
    fi
}

adjust_prop() {
    if [[ $(getprop $1) ]]; then
        if [[ $(getprop $1) = $2 ]]; then
            echo $1"="$3 >>$MODPATH/system.prop
        fi
    fi
}

check_deny_list() {
    magisk --denylist status 2> /dev/null
    if [ $? -ne 0 ]; then
        ui_print " "
        ui_print " The Denylist is not enforced."
        ui_print "   Setting the Denylist to enforced."
        magisk --denylist enable
        magisk --denylist status 2> /dev/null
        if [ $? -ne 0 ]; then
            ui_print " "
            ui_print " The Denylist can not be set to enforced."
            ui_print " "
            ui_print " Please make sure to enable Zygisk in Magisk."
            ui_print "  Then enable Enforce DenyList in Magisk."
            ui_print " "
        else
            ui_print " "
            ui_print " The Denylist is now enforced."
        fi
    else
        ui_print " "
        ui_print " The Denylist is enforced."
    fi
}

set_default_list() {
    magisk --denylist add com.google.android.gms com.google.android.gms.unstable
    if [[ $(magisk --path) != /sbin ]]; then
        magisk --denylist add com.google.android.gms com.google.android.gms
    fi
}


# Check Magisk version.
if [[ $MAGISK_VER_CODE -lt 24000 ]]; then
    ui_print " "
    ui_print " Requires Magisk v24+ to be installed and active."
    ui_print "  Installed version is "$MAGISK_VER_CODE
    exit 1
fi

# Create a new 'system.prop' file.
echo "# Device sensitive properties" >$MODPATH/system.prop
echo "" >>$MODPATH/system.prop

ui_print " "
ui_print " Generating a list of 'sensitive' device properties."

# Check for sensitive [secure] device properties.
add_prop ro.adb.secure 1
adjust_prop ro.boot.hwc CN GLOBAL
adjust_prop ro.boot.hwcountry China GLOBAL
add_prop ro.boot.selinux enforcing
add_prop ro.boot.vbmeta.device_state locked
add_prop ro.boot.verifiedbootstate green
add_prop ro.boot.veritymode enforcing
add_prop ro.boot.warranty_bit 0
## __ Do Not include__ # add_prop ro.build.selinux 1
add_prop ro.build.tags release-keys
add_prop ro.build.type user
add_prop ro.debuggable 0
add_prop ro.is_ever_orange 0
add_prop ro.odm.build.tags release-keys
add_prop ro.odm.build.type user
## __ Do Not include__ # add_prop ro.oem_unlock_supported 1
add_prop ro.product.build.tags release-keys
add_prop ro.product.build.type user
add_prop ro.system.build.tags release-keys
add_prop ro.system.build.type user
add_prop ro.vendor.boot.warranty_bit 0
add_prop ro.vendor.build.tags release-keys
add_prop ro.vendor.build.type user
add_prop ro.vendor.warranty_bit 0
add_prop ro.warranty_bit 0
## __ Do Not include__ # add_prop sys.oem_unlock_allowed 1
add_prop vendor.boot.vbmeta.device_state locked

# Check the Denylist status and try to enforce if needed.
ui_print " "
ui_print " Checking the Denylist. "
check_deny_list

# Add SafetyNet by default.
ui_print " "
ui_print " Adding required Google Play services to the DenyList."
set_default_list
