// function initialize() {
//     var map = new BMap.Map('map');
//     map.centerAndZoom(new BMap.Point(121.491, 31.233), 11);
//     var opts = { offset: new BMap.Size(150, 5) }
//     map.addControl(new BMap.ScaleControl(opts));
//     var opts2 = { type: BMAP_NAVIGATION_CONTROL_SMALL }
//     map.addControl(new BMap.NavigationControl(opts2));
//     map.addControl(new BMap.OverviewMapControl());
//     map.addControl(new BMap.MapTypeControl());
//     map.addControl(new BMap.GeolocationControl());
// }

// // var local = new BMap.LocalSearch(map, {
// //     renderOptions: { map: map }
// // });
// // local.search("天安门");

// function loadScript() {
//     var script = document.createElement("script");
//     script.src = "http://api.map.baidu.com/api?v=2.0&ak=您的密钥&callback=initialize"; //此为v2.0版本的引用方式  
//     // http://api.map.baidu.com/api?v=1.4&ak=您的密钥&callback=initialize"; //此为v1.4版本及以前版本的引用方式  
//     document.body.appendChild(script);
// }

// window.onload = loadScript;