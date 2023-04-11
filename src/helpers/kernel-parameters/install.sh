#!/usr/bin/env bash

# Set variables with the list of parameters that should be present in GRUB_CMDLINE_LINUX_DEFAULT
REQUIRED_PARAMS="loglevel=0 console=tty2 udev.log_level=0 vt.global_cursor_default=0 mitigations=off nowatchdog msr.allow_writes=on pcie_aspm=force module.sig_unenforce intel_idle.max_cstate=1 cryptomgr.notests initcall_debug intel_iommu=igfx_off no_timer_check noreplace-smp page_alloc.shuffle=1 rcupdate.rcu_expedited=1 tsc=reliable"

# Check if all required parameters are already present in the GRUB_CMDLINE_LINUX_DEFAULT
if grep -q "^GRUB_CMDLINE_LINUX_DEFAULT=.*$REQUIRED_PARAMS.*" /etc/default/grub; then
    echo "All required parameters are already present in /etc/default/grub"
    exit 0
fi

# Append missing parameters to GRUB_CMDLINE_LINUX_DEFAULT
EXISTING_PARAMS=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" /etc/default/grub | sed 's/^GRUB_CMDLINE_LINUX_DEFAULT=//' | tr -d '"')
NEW_PARAMS=$(echo "$REQUIRED_PARAMS" | tr ' ' '\n' | sort -u)
ALL_PARAMS=$(echo "$EXISTING_PARAMS $NEW_PARAMS" | tr ' ' '\n' | sort -u | tr '\n' ' ')
sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/=.*/=\"$ALL_PARAMS\"/" /etc/default/grub

# Update GRUB
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

exit 0
