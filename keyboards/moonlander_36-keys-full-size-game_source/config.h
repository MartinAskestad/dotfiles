/*
  Set any config.h overrides for your specific keymap here.
  See config.h options at https://docs.qmk.fm/#/config_options?id=the-configh-file
*/
#define ORYX_CONFIGURATOR
#undef TAPPING_TERM
#define TAPPING_TERM 171

#undef RGB_DISABLE_TIMEOUT
#define RGB_DISABLE_TIMEOUT 60000

#define USB_SUSPEND_WAKEUP_DELAY 0
#define CAPS_LOCK_STATUS
#define RGB_MATRIX_STARTUP_SPD 60