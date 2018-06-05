<!DOCTYPE html>
<html>

<head>
    <title>Leaflet4</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/leaflet.css"/>
    <script type="text/javascript" src="js/main.js"></script>
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
<div id="mapDiv">
</div>
</body>

<script type="text/javascript" src="http://leafletjs.com/examples/geojson/sample-geojson.js"></script>
<script type="text/javascript">
    var startDate = new Date();
    startDate.setUTCHours(0, 0, 0, 0);

    var map = L.map('map', {
        zoom: 12,
        fullscreenControl: true,
        center: [39.3, 4]
    });

    // start of TimeDimension manual instantiation
    var timeDimension = new L.TimeDimension({
        period: "PT5M",
    });
    // helper to share the timeDimension object between all layers
    map.timeDimension = timeDimension;
    // otherwise you have to set the 'timeDimension' option on all layers.

    var player        = new L.TimeDimension.Player({
        transitionTime: 100,
        loop: false,
        startOver:true
    }, timeDimension);

    var timeDimensionControlOptions = {
        player:        player,
        timeDimension: timeDimension,
        position:      'bottomleft',
        autoPlay:      true,
        minSpeed:      1,
        speedStep:     0.5,
        maxSpeed:      15,
        timeSliderDragUpdate: true
    };

    var timeDimensionControl = new L.Control.TimeDimension(timeDimensionControlOptions);
    map.addControl(timeDimensionControl);

    var icon = L.icon({
        iconUrl: 'img/running.png',
        iconSize: [22, 22],
        iconAnchor: [5, 25]
    });

    var customLayer = L.geoJson(null, {
        pointToLayer: function (feature, latLng) {
            if (feature.properties.hasOwnProperty('last')) {
                return new L.Marker(latLng, {
                    icon: icon
                });
            }
            return L.circleMarker(latLng);
        }
    });

    var gpxLayer = omnivore.gpx('data/running_mallorca.gpx', null, customLayer).on('ready', function() {
        map.fitBounds(gpxLayer.getBounds(), {
            paddingBottomRight: [40, 40]
        });
    });

    var gpxTimeLayer = L.timeDimension.layer.geoJson(gpxLayer, {
        updateTimeDimension: true,
        addlastPoint: true,
        waitForReady: true
    });

    var kmlLayer = omnivore.kml('data/easy_currents_track.kml');
    var kmlTimeLayer = L.timeDimension.layer.geoJson(kmlLayer, {
        updateTimeDimension: true,
        addlastPoint: true,
        waitForReady: true
    });


    var overlayMaps = {
        "GPX Layer": gpxTimeLayer,
        "KML Layer": kmlTimeLayer
    };
    var baseLayers = getCommonBaseLayers(map); // see baselayers.js
    L.control.layers(baseLayers, overlayMaps).addTo(map);
    gpxTimeLayer.addTo(map);

    var a = "不懂英文，多么痛的领悟";
</script>
</html>