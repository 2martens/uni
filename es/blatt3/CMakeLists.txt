set(ARDUINO_DEFAULT_BOARD diecimila) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyUSB0) # Default Port, when not specified

generate_arduino_firmware(uebung3-1
    SKETCH uebung3-1
    PROGRAMMER usbtinyisp)

generate_arduino_firmware(uebung3-2
    SKETCH uebung3-2
    PROGRAMMER usbtinyisp)

generate_arduino_firmware(uebung3-3
    SKETCH uebung3-3
    PROGRAMMER usbtinyisp)

generate_arduino_firmware(uebung3-4
    SKETCH uebung3-4
    PROGRAMMER usbtinyisp)

generate_arduino_firmware(uebung3-5
    SKETCH uebung3-5
    PROGRAMMER usbtinyisp)
