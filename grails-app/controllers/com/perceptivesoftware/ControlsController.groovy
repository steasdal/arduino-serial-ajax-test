package com.perceptivesoftware

class ControlsController {

    static allowedMethods = [save: "POST"]
    static defaultAction = "display"

    ArduinoControllerService arduinoControllerService

    def display() {
        // initiate the arduino serial command loop
        arduinoControllerService.open()
    }

    def setBlink() {
        if( params?.value ) {
            arduinoControllerService.updateBlink( Integer.parseInt( params?.value?.toString() ) )
        }

        render status: 200
    }

    def setServo01() {
        if( params?.value ) {
            arduinoControllerService.updateServo1( Integer.parseInt( params?.value?.toString() ) )
        }

        render status: 200
    }

    def setServo02() {
        if( params?.value ) {
            arduinoControllerService.updateServo2( Integer.parseInt( params?.value?.toString() ) )
        }

        render status: 200
    }
}
