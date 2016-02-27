// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    m = checkTime(m);
    h = checkTime(h);
    document.getElementById('timetxt').innerHTML =
        h + ":" + m;
    var t = setTimeout(startTime, 5000);
}

function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}

var locationhttp = new XMLHttpRequest();
var locationurl = "http://freegeoip.net/json/";
var weatherhttp = new XMLHttpRequest();

weatherhttp.onreadystatechange = function () {
  if (weatherhttp.readyState == 4 && weatherhttp.status == 200){
      var myArr = JSON.parse(weatherhttp.responseText);
      setWeather(myArr);
  }
};

locationhttp.onreadystatechange = function() {
    if (locationhttp.readyState == 4 && locationhttp.status == 200) {
        var myArr = JSON.parse(locationhttp.responseText);
        $("#city").innerHTML = myArr.city;
        weatherhttp.open("GET", "https://api.forecast.io/forecast/059e13194aa7a13e2ac742a1bce77edb/" + myArr.latitude + "," + myArr.longitude, true);
        weatherhttp.send();
    }
};

function setWeather(myarr){
    $("#icon").addClass('wi wi-forecast-io-' + myarr.currently.icon);
    $("#sunrise").innerHTML = myarr.daily.data.sunriseTime;
    $("#temp").innerHTML = myarr.currently.temperature;
    $("#desc").innerHTML = myarr.currently.summary;
    $("#sunset").innerHTML = myarr.daily.data.sunsetTime;
}

function startUp(){
    startTime();
    locationhttp.open("GET", locationurl, true);
    locationhttp.send();
}

