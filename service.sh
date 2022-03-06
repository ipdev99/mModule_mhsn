#!/system/bin/sh

# mHide SafetyNet
#
# Adjust sensitive properties to help pass SafetyNet.
# ipdev @ xda-developers


# Set functions

remove_prop() {
	if [[ $(getprop $1) ]]; then
		resetprop --delete $1
	fi
}

reset_prop() {
    if [[ $(getprop $1) ]]; then
        if [[ $(getprop $1) = $2 ]]; then
            resetprop $1 $3
        fi
    fi
}

set_prop() {
    if [[ $(getprop $1) ]]; then
        if [[ $(getprop $1) != $2 ]]; then
            resetprop $1 $2
        fi
    fi
}


# __ Check and correct sensitive properties as needed. __

# Hide that we booted from recovery when magisk is in recovery mode.
reset_prop ro.boot.mode recovery unknown
reset_prop ro.bootmode recovery unknown
reset_prop vendor.boot.mode recovery unknown

# Remove properties.
remove_prop ro.build.selinux

# If SELinux is permissive adjust the file permissions.
if [[ $(cat /sys/fs/selinux/enforce) -eq 0 ]]; then
    chmod 0640 /sys/fs/selinux/enforce
    chmod 0440 /sys/fs/selinux/policy
fi

# Properties that need to be reset after boot_completed.
{
	until [[ $(getprop sys.boot_completed) -eq 1 ]]; do 
		date +%N > /dev/null
	done

    # Set late start properties.
    set_prop vendor.boot.verifiedbootstate green
    set_prop ro.boot.flash.locked 1
    set_prop ro.secure 1
}&
