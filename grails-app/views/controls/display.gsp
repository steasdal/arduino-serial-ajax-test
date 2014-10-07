<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Controls</title>

    <asset:javascript src="jquery" />
    <asset:javascript src="spring-websocket" />
    <jqui:resources/>

    <script type="text/javascript">
        $(function() {

            var socket = new SockJS("${createLink(uri: '/stomp')}");
            var client = Stomp.over(socket);

            var blinkSubscription, servo01Subscription, servo02Subscription;

            client.connect({}, function() {
                blinkSubscription = client.subscribe("/topic/blink", function(message) {
                   var interval = parseInt(JSON.parse(message.body));

                    $("#blink-slider").slider('value', interval);
                    $("#slidervalue").val(interval);
                });

                servo01Subscription = client.subscribe("/topic/servo01", function(message) {
                    var position = parseInt(JSON.parse(message.body));

                    $("#servo01-slider").slider('value', position);
                    $("#servo01value").val(position);
                });

                servo02Subscription = client.subscribe("/topic/servo02", function(message) {
                    var position = parseInt(JSON.parse(message.body));

                    $("#servo02-slider").slider('value', position);
                    $("#servo02value").val(position);
                });
            });

            $("#slidervalue").val(250);
            $("#blink-slider").slider({
                value:250,
                min: 10,
                max: 2000,
                animate: true,
                slide: function( event, ui ) {
                    var slideval = ui.value;
                    $("#slidervalue").val(ui.value);
                    client.send("/app/blink", {}, JSON.stringify(slideval));
                }
            });

            $("#servo01value").val(90);
            $("#servo01-slider").slider({
                value:90,
                min: 0,
                max: 180,
                animate: true,
                slide: function( event, ui ) {
                    var slideval = ui.value;
                    $("#servo01value").val(ui.value);
                    client.send("/app/servo01", {}, JSON.stringify(slideval));
                }
            });

            $("#servo02value").val(90);
            $("#servo02-slider").slider({
                value:90,
                min: 0,
                max: 180,
                animate: true,
                slide: function( event, ui ) {
                    var slideval = ui.value;
                    $("#servo02value").val(ui.value);
                    client.send("/app/servo02", {}, JSON.stringify(slideval));
                }
            });

            $(window).on('beforeunload', function(){
                blinkSubscription.unsubscribe();
                servo01Subscription.unsubscribe();
                servo02Subscription.unsubscribe();

                // Disconnect the websocket connection
                client.disconnect();
            });
        });
    </script>
</head>

<body>

    <div class="nav" role="navigation">
        <ul>
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        </ul>
    </div>

    <div id="slider-controls" class="content" role="main">
        <label for="slidervalue">Blink Interval:</label>
        <input type="text" id="slidervalue" readonly style="border:0; color:#f6931f; font-weight:bold;">
        <div id="blink-slider"></div>

        <br>

        <label for="servo01value">Servo 01:</label>
        <input type="text" id="servo01value" readonly style="border:0; color:#f6931f; font-weight:bold;">
        <div id="servo01-slider"></div>

        <br>

        <label for="servo02value">Servo 01:</label>
        <input type="text" id="servo02value" readonly style="border:0; color:#f6931f; font-weight:bold;">
        <div id="servo02-slider"></div>

    </div>

</body>
</html>