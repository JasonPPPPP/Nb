<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/leaflet.css"/>
    <script type="text/javascript" src="js/main.js"></script>
    <meta charset="UTF-8"/>
    <style TYPE="text/css">
        body {
            margin: 0px;
            padding: 0px;
        }

        /**
         * 单独设置mapid为100%不显示，可能float坍塌
         */

        html,
        body,
        #mapDiv {
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>
<div id="mapDiv"></div>
</body>
<script>
    //地图地址
    var url = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw';
    var attr = ' Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, &copy; <a href="http://cartodb.com/attributions">CartoDB</a>';

    var leafletMap = L.map('mapDiv').setView([51.505, -0.09], 13);
    //图层
    L.tileLayer(url, {
        maxZoom: 18,
        attribution: attr,
        id: 'mapbox.streets'
    }).addTo(leafletMap);
    //标记点
    L.marker([51.5, -0.09]).addTo(leafletMap)
            .bindPopup("<b>Hello world!</b><br />I am a popup.").openPopup();
    //圆
    L.circle([51.508, -0.11], 500, {
        color: 'red',
        fillColor: '#f03',
        fillOpacity: 0.5
    }).addTo(leafletMap).bindPopup("I am a circle.");
    //多边形
    L.polygon([
        [51.509, -0.08],
        [51.503, -0.06],
        [51.51, -0.047]
    ]).addTo(leafletMap).bindPopup("I am a polygon.");
    //多边形
    L.polygon([
        [51.48288, -0.065403],
        [51.469943, -0.065403],
        [51.469836, -0.039482],
        [51.484269, -0.037937]
    ]).addTo(leafletMap).bindPopup("I am a polygon.");

    //多边形
    L.polygon([
        [51.499019, -0.073128],
        [51.489935, -0.078621],
        [51.479779, -0.079823],
        [51.477534, -0.061626],
        [51.4894, -0.059395],
        [51.498271, -0.05785]
    ]).addTo(leafletMap).bindPopup("You made me, see?");
    //弹出面板
    var popup = L.popup();

    function onMapClick(e) {
        popup
                .setLatLng(e.latlng)
                .setContent("You clicked the map at " + e.latlng.toString())
                .openOn(leafletMap);
    }
    //添加click时间
    leafletMap.on('click', onMapClick);
</script>
</html>
