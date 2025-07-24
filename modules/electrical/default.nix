{
  pkgs,
  ...
}:
{
  services.udev.packages = with pkgs; [
    qmk
    qmk-udev-rules
    qmk_hid
    #arm-trusted-firmware
    (writeTextFile {
      name = "60-openhantek";
      text = ''
        # rules for OpenHantek6022 (DSO program) as well as Hankek6022API (python tools)

        ACTION!="add|change", GOTO="openhantek_rules_end"
        SUBSYSTEM!="usb|usbmisc|usb_device", GOTO="openhantek_rules_end"
        ENV{DEVTYPE}!="usb_device", GOTO="openhantek_rules_end"

        # Hantek DSO-6022BE, without FW, with FW
        ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="6022", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
        ATTRS{idVendor}=="04b5", ATTRS{idProduct}=="6022", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        # Instrustar isds-205b, without FW, with FW
        ATTRS{idVendor}=="d4a2", ATTRS{idProduct}=="5661", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
        ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="1d50", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        # Hantek DSO-6022BL, without FW, with FW
        ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="602a", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
        ATTRS{idVendor}=="04b5", ATTRS{idProduct}=="602a", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        # Voltcraft DSO-2020, without FW (becomes DSO-6022BE when FW is uploaded)
        ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="2020", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        # BUUDAI DDS120, without FW, with FW
        ATTRS{idVendor}=="8102", ATTRS{idProduct}=="8102", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
        ATTRS{idVendor}=="04b5", ATTRS{idProduct}=="0120", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        # Hantek DSO-6021, without FW, with FW
        ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="6021", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
        ATTRS{idVendor}=="04b5", ATTRS{idProduct}=="6021", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        # YiXingDianZiKeJi MDSO, without FW, with FW
        ATTRS{idVendor}=="d4a2", ATTRS{idProduct}=="5660", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
        ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="608e", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"

        LABEL="openhantek_rules_end"
         
      '';

      destination = "/etc/udev/rules.d/60-openhantek.rules";
    })
    # (writeTextFile {
    #   name = "50-8bitdo-kbd";
    #   text = ''
    #
    #     # Place in /etc/udev/rules.d/
    #
    #     # ACTION!="add|change", GOTO="openhantek_rules_end"
    #     # SUBSYSTEM!="usb|usbmisc|usb_device", GOTO="openhantek_rules_end"
    #     # ENV{DEVTYPE}!="usb_device", GOTO="openhantek_rules_end"
    #
    #     # Allow logged in users to read/write the device
    #     SUBSYSTEM=="usb", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="5200", MODE="0660", TAG+="uaccess"
    #
    #     # Unbind usbhid from interface #2 so that python can use the interface
    #     ACTION=="bind", SUBSYSTEM=="usb", ATTR{bInterfaceNumber}=="02", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="5200", RUN+="/usr/bin/sh -c 'echo $kernel > /sys/bus/usb/drivers/usbhid/unbind'"
    #
    #     # If you want to hack these rules using `udevadm info -a` will be useful. Example:
    #     # udevadm info -a -n /dev/hidraw3
    #     #
    #     # It may be useful to use the following for debugging in the unbind rule:
    #     # PROGRAM="/usr/bin/sh -c 'logger -p user.info usb matched! kernel=$kernel, number=$number, devpath=$devpath, id=$id, driver=$driver, major=$major, minor=$minor, result=$result, parent=$parent, name=$name, links=$links, root=$root, sys=$sys, devnode=$devnode'"
    #     # LABEL="8bitdo-kbd_rules_end"
    #
    #   '';
    #
    #   destination = "/etc/udev/rules.d/50-8bitdo-kbd.rules";
    # })
    (writeTextFile {
      name = "71-8bitdo-controller";
      text = ''

        # 8BitDo Generic Device
        ## This rule applies to many 8BitDo devices.
        SUBSYSTEM=="usb", ATTR{idProduct}=="3106", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo F30 P1
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo F30 P2
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 II", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo N30
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo SF30
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SFC30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo SN30
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SNES30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo F30 Pro
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo N30 Pro
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo SF30 Pro
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SF30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo SN30 Pro
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SN30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo SN30 Pro+; Bluetooth; USB
        SUBSYSTEM=="input", ATTRS{name}=="8BitDo SN30 Pro+", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SF30 Pro   8BitDo SN30 Pro+", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo F30 Arcade
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo Joy", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo N30 Arcade
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 Arcade", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo ZERO
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo Zero GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Retro-Bit xRB8-64
        SUBSYSTEM=="input", ATTRS{name}=="8Bitdo N64 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Pro 2; Bluetooth; USB
        SUBSYSTEM=="input", ATTRS{name}=="8BitDo Pro 2", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
        SUBSYSTEM=="input", ATTR{id/vendor}=="2dc8", ATTR{id/product}=="6006", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
        SUBSYSTEM=="input", ATTR{id/vendor}=="2dc8", ATTR{id/product}=="6003", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Pro 2 Wired; USB
        # X-mode uses the 8BitDo Generic Device rule
        # B-Mode
        SUBSYSTEM=="usb", ATTR{idProduct}=="3010", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
        SUBSYSTEMS=="input", ATTRS{id/product}=="3010", ATTRS{id/vendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Ultimate Wired Controller for Xbox; USB
        SUBSYSTEM=="usb", ATTR{idProduct}=="2003", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Ultimate 2.4G Wireless  Controller; USB/2.4GHz
        # X-mode uses the 8BitDo Generic Device rule
        # D-mode
        SUBSYSTEM=="usb", ATTR{idProduct}=="3012", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Ultimate 2C Wireless Controller; USB/2.4GHz
        SUBSYSTEM=="usb", ATTR{idProduct}=="310a", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Arcade Stick; Bluetooth (X-mode)
        SUBSYSTEM=="input", ATTRS{name}=="8BitDo Arcade Stick", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        # 8BitDo Ultimate 2 Wireless; Bluetooth; USB/2.4GHz
        SUBSYSTEM=="input", ATTRS{name}=="8BitDo Ultimate 2 Wireless", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTR{idProduct}=="310b", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"

        #LABEL="8bitdo-controller_rules_end" 

      '';
      destination = "/etc/udev/rules.d/71-8bitdo-controller.rules";
    })
  ];
}
