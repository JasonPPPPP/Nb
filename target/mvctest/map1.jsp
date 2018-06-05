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

<script>
    //地图地址
    var url = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw';
    var attr = ' Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, &copy; <a href="http://cartodb.com/attributions">CartoDB</a>';

    var leafletMap = L.map('mapDiv').setView([39.74739, -105], 13);

    L.tileLayer(url, {
        maxZoom: 18,
        attribution: attr,
        id: 'mapbox.light'
    }).addTo(leafletMap);

    //注册图标
    var iconUrl = "http://leafletjs.com/examples/geojson/baseball-marker.png";
    var baseballIcon = L.icon({
        iconUrl: iconUrl,
        iconSize: [32, 37],
        iconAnchor: [16, 37],
        popupAnchor: [0, -28]
    });

    //例1
    //geoJson 地址：http://geojson.org/geojson-spec.html
    //Feature类型geoJson对象
    //必须有properties对象
    //geometry对象，是几何对象
    var geojsonFeature = {
        "type": "Feature",
        "properties": {
            "name": "Coors Field",
            "amenity": "Baseball Stadium",
            "popupContent": "This is where the Rockies play!"
        },
        "geometry": {
            "type": "Point",
            "coordinates": [-104.94404, 39.75621]
        }
    };
    //加入到map中
    L.geoJSON(geojsonFeature).addTo(leafletMap);

    //例2
    //LineString类型geoJson对象
    var myLines = [{
        "type": "LineString",
        "coordinates": [
            [-104.7, 39.6],
            [-104.8, 39.7],
            [-104.9, 39.8]
        ]
    }, {
        "type": "LineString",
        "coordinates": [
            [-104.8, 39.6],
            [-104.9, 39.7],
            [-105.0, 39.8]
        ]
    }];
    var myLayer = L.geoJSON().addTo(leafletMap);
    myLayer.addData(myLines);

    //例3 style
    //LineString类型geoJson对象
    var myLines = [{
        "type": "LineString",
        "coordinates": [
            [-104.9, 39.6],
            [-105.0, 39.7],
            [-105.1, 39.8]
        ]
    }, {
        "type": "LineString",
        "coordinates": [
            [-105.0, 39.6],
            [-105.1, 39.7],
            [-105.2, 39.8]
        ]
    }];
    //style风格
    var myStyle = {
        "color": "#ff7800",
        "weight": 5,
        "opacity": 0.65
    };

    L.geoJSON(myLines, {
        style: myStyle
    }).addTo(leafletMap);

    //例4 style根据属性改变
    //共和党，民主党区域
    //Feature类型geoJson对象，里边两个多边形。
    var states = [{
        "type": "Feature",
        "properties": {
            "party": "Republican" //党：共和党
        },
        "geometry": {
            "type": "Polygon",
            "coordinates": [
                [
                    [-104.85, 39.59],
                    [-104.72, 39.58],
                    [-104.72, 39.79],
                    [-104.83, 39.79],
                    [-104.95, 39.59]
                ]
            ]
        }
    }, {
        "type": "Feature",
        "properties": {
            "party": "Democrat" //民主党
        },
        "geometry": {
            "type": "Polygon",
            "coordinates": [
                [
                    [-104.96, 40.00],
                    [-104.76, 39.99],
                    [-104.73, 39.49],
                    [-104.96, 39.49],
                    [-104.96, 40.00]
                ]
            ]
        }
    }];
    //style风格 根据feature.properties.party属性来确定颜色
    L.geoJSON(states, {
        style: function(feature) {
            switch(feature.properties.party) {
                case 'Republican':
                    return {
                        color: "#ff0000"
                    };
                case 'Democrat':
                    return {
                        color: "#0000ff"
                    };
            }
        }
    }).addTo(leafletMap);

    //加载geoJson数据（campus:（大学）校园,BicycleRental ：自行车租赁处 两个多边形，以及n个点)
    //设置样式风格，onEachFeature事件效果以及pointToLayer点渲染并加入到map中
    L.geoJSON([bicycleRental, campus], {
        //a && b : 将a, b转换为Boolean类型, 再执行逻辑与, true返回b, false返回a
        //a || b : 将a, b转换为Boolean类型, 再执行逻辑或, true返回a, false返回b
        //风格：获取feature对象的properties变量的style属性
        style: function(feature) {
            return feature.properties && feature.properties.style;
        },
        onEachFeature: onEachFeature,
        pointToLayer: pointToLayerByCircleMarker
    }).addTo(leafletMap);

    //加载geoJson数据（ 免费公交车: 免费公交车,3条线)
    //设置onEachFeature事件效果以及过滤器并加入到map中
    L.geoJSON(freeBus, {
        filter: filter,
        onEachFeature: onEachFeature
    }).addTo(leafletMap);

    //加载geoJson数据(一个点) 加了一个图标呢
    //设置onEachFeature事件效果以及pointToLayer点渲染并加入到map中
    var coorsLayer = L.geoJSON(coorsField, {
        pointToLayer: pointToLayerByMarker,
        onEachFeature: onEachFeature
    }).addTo(leafletMap);

    //pointToLayer 对Point类型对象的每个坐标设置标记选项
    function pointToLayerByMarker(feature, latlng) {
        return L.marker(latlng, {
            icon: baseballIcon
        });
    }

    //pointToLayer 对Point类型对象的每个坐标设置标记选项
    function pointToLayerByCircleMarker(feature, latlng) {
        return L.circleMarker(latlng, circleMarkerOptions); //对坐标加载标记选项配置
    }

    //geojson标记选项
    var circleMarkerOptions = {
        radius: 10, //半径像素
        color: "#00ff00", //边框颜色
        weight: 10, //边框宽度像素
        opacity: 0.5, //边框不透明度
        fillColor: "#ff7800", //填充颜色
        fillOpacity: 0.8 //填充不透明度
    };

    //每个Feature对象，附加事件和弹出功能。默认是与新创建的图层做什么：
    function onEachFeature(feature, layer) {
        var popupContent = "<p>I started out as a GeoJSON " +
                feature.geometry.type + ", but now 1I'm a Leaflet vector!</p>";

        if(feature.properties && feature.properties.popupContent) {
            popupContent += feature.properties.popupContent;
        }

        layer.bindPopup(popupContent);
    }

    //过滤器
    //顾虑掉建造中的，施工中的
    function filter(feature, layer) {
        if(feature.properties) {
            // If the property "underConstruction" exists and is true, return false (don't render features under construction)
            return feature.properties.underConstruction !== undefined ? !feature.properties.underConstruction : true;
        }
        return false;
    };
</script>

</html>