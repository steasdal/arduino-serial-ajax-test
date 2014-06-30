<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Controls</title>

    <jqui:resources/>

    <script>
        $(document).ready(function(){

            $("#blink-slider").slider({
                value:250,
                min: 10,
                max: 2000,
                slide: function( event, ui ) {
                    var slideval = ui.value;
                    $("#slidervalue").val(ui.value);
                    <g:remoteFunction action="setBlink" params="{value:slideval}"/>
                }
            });

            $("#slidervalue").val(250);

            $("#servo01-slider").slider({
                value:90,
                min: 0,
                max: 180,
                slide: function( event, ui ) {
                    var slideval = ui.value;
                    $("#servo01value").val(ui.value);
                    <g:remoteFunction action="setServo01" params="{value:slideval}"/>
                }
            });

            $("#servo01value").val(90);

            $("#servo02-slider").slider({
                value:90,
                min: 0,
                max: 180,
                slide: function( event, ui ) {
                    var slideval = ui.value;
                    $("#servo02value").val(ui.value);
                    <g:remoteFunction action="setServo02" params="{value:slideval}"/>
                }
            });

            $("#servo02value").val(90);

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