set(ARDUINO_DEFAULT_BOARD diecimila) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyUSB0) # Default Port, when not specified

generate_arduino_firmware(uebung1-11
    SKETCH uebung1-11
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)
    
generate_arduino_firmware(uebung1-12
    SKETCH uebung1-12
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)

generate_arduino_firmware(uebung1-13
    SKETCH uebung1-13
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)

generate_arduino_firmware(uebung1-14
    SKETCH uebung1-14
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)

generate_arduino_firmware(uebung1-15a
    SKETCH uebung1-15a
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)

generate_arduino_firmware(uebung1-15b
    SKETCH uebung1-15b
    PROGRAMMER usbtinyisp
    NO_AUTOLIBS)