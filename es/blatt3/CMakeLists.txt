set(ARDUINO_DEFAULT_BOARD diecimila) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyUSB0) # Default Port, when not specified

generate_arduino_firmware(uebung3-1
    SKETCH uebung3-1
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)

generate_arduino_firmware(uebung3-2
    SKETCH uebung3-2
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)
