package com.perceptivesoftware

import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo

class ControlsController {

    static allowedMethods = [save: "POST"]
    static defaultAction = "display"

    ArduinoControllerService arduinoControllerService

    def display() {
        // initiate the arduino serial command loop
        arduinoControllerService.open()
    }

    @MessageMapping("/blink")
    @SendTo("/topic/blink")
    protected String wsSetBlink(String interval) {
        arduinoControllerService.updateBlink( Integer.parseInt(interval) )
        return interval
    }

    @MessageMapping("/servo01")
    @SendTo("/topic/servo01")
    protected String wsSetServo01(String position) {
        arduinoControllerService.updateServo1( Integer.parseInt(position) )
        return position
    }

    @MessageMapping("/servo02")
    @SendTo("/topic/servo02")
    protected String wsSetServo02(String position) {
        arduinoControllerService.updateServo2( Integer.parseInt(position) )
        return position
    }
}
