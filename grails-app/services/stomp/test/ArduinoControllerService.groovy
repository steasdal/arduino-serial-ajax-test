package stomp.test

import org.teasdale.api.ArduinoSerialConfig
import org.teasdale.api.ArduinoSerialConnection
import org.teasdale.api.ArduinoSerialFactory
import org.teasdale.api.ArduinoSerialListener

class ArduinoControllerService {

    static ArduinoSerialConfig arduinoSerialConfig
    static ArduinoSerialConnection arduinoSerialConnection

    private static void doConfig() {
        if( !arduinoSerialConfig ) {
            arduinoSerialConfig = ArduinoSerialFactory.getInstance().getArduinoSerialConfig()

            arduinoSerialConfig.setBaudrate(ArduinoSerialConfig.Baudrate.BAUDRATE_19200)
            arduinoSerialConfig.setPortname("COM4")
            arduinoSerialConfig.setUpdateFrequency(20)       // twenty updates per second
            arduinoSerialConfig.setMissedUpdatesAllowed(20)  // one second's worth

            arduinoSerialConfig.registerCommand("BLINK", 3000)
            arduinoSerialConfig.registerCommand("SRV1", 90)
            arduinoSerialConfig.registerCommand("SRV2", 90)

            arduinoSerialConfig.registerListener(new SerialListener())
        }
    }

    private static void doOpen() {
        if( !arduinoSerialConnection ) {
            arduinoSerialConnection = ArduinoSerialFactory.getInstance().getArduinoSerialConnection(arduinoSerialConfig)
            arduinoSerialConnection.open()
        }
    }

    private static void doClose() {
        if( arduinoSerialConnection ) {
            arduinoSerialConnection.close()
            arduinoSerialConnection = null;
        }
    }

    private static void doUpdateCommand(String command, int interval) {
        doConfig()
        doOpen()
        arduinoSerialConnection.updateCommand(command, interval)
    }

    def open() {
        doConfig()
        doOpen()
    }

    def close() {
        doClose()
    }

    def updateBlink(int interval) { doUpdateCommand("BLINK", interval) }
    def updateServo1(int position) { doUpdateCommand("SRV1", position) }
    def updateServo2(int position) { doUpdateCommand("SRV2", position) }

    /* ***************************************************************************************** */

    // This listener will simply print out any serial
    // strings received from the arduino to stdout.
    static private class SerialListener implements ArduinoSerialListener {
        @Override
        void stringReceived(String string) {
            println string
        }
    }
}
