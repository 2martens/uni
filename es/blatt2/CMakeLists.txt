set(ARDUINO_DEFAULT_BOARD diecimila) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyUSB0) # Default Port, when not specified

generate_arduino_firmware(uebung2-1
    SKETCH uebung2-1
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)

generate_arduino_firmware(uebung2-3
    SKETCH uebung2-3
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)
