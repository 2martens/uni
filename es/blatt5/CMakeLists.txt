set(ARDUINO_DEFAULT_BOARD diecimila) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyUSB0) # Default Port, when not specified

generate_arduino_firmware(uebung5-1
    SKETCH uebung5-1
    PROGRAMMER usbtinyisp)

generate_arduino_firmware(uebung5-2
    SKETCH uebung5-2
    PROGRAMMER usbtinyisp)

generate_arduino_firmware(uebung5-3
    SKETCH uebung5-3
    PROGRAMMER usbtinyisp)
