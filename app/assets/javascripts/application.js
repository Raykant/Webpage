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
    var hour = today.getHours();
    var m = today.getMinutes();
    m = checkTime(m);
    hour = checkTime(hour);
    document.getElementById('timetxt').innerHTML = hour + ":" + m;
    var t = setTimeout(startTime, 5000);
}

function welcomeMsg(){
    var today = new Date();
    var hour = today.getHours();
    var msg = "";
<<<<<<< HEAD
    if(hour < 2 || hour >= 22) msg = "Getting tired, Ellie?";
    else if(hour >= 2 && hour < 6) msg = "Can't sleep, Ellie?";
    else if(hour >= 6 && hour < 10) msg = "Good morning, Ellie.";
    else if(hour >= 10 && hour < 12) msg = "How are you, Ellie?";
    else if(hour >= 12 && hour < 17) msg = "Good afternoon, Ellie.";
    else if(hour >= 17 && hour < 22) msg = "Good evening, Ellie.";
=======
    if(hour < 2 || hour >= 22) msg = "Getting tired, Pieter?";
    else if(hour >= 2 && hour < 6) msg = "Can't sleep, Pieter?";
    else if(hour >= 6 && hour < 10) msg = "Good morning, Pieter.";
    else if(hour >= 10 && hour < 12) msg = "How are you, Pieter?";
    else if(hour >= 12 && hour < 17) msg = "Good afternoon, Pieter.";
    else if(hour >= 17 && hour < 22) msg = "Good evening, Pieter.";
>>>>>>> 06fe587bddb9f423e4602a93f14071422d6793bf

    document.getElementById('welcometxt').innerHTML = msg;
    var t = setTimeout(welcomeMsg, 60000);
}

function setTodos(){
    $.ajax({
        url: "/todolist"
    }).done(function(html) {
        $("#todos").append(html);
    });
}

function setWelcome(){
    $.ajax({
        url: "/welcome"
    }).done(function(html) {
        $("#welcome").append(html);
        startTime();
        welcomeMsg();
    });
}

function setTodoMsg(){
    $.ajax({
        url: "/todomsg"
    }).done(function(html) {
        document.getElementById('todomessage').innerHTML = html;
    });
}

function setBackground(){
    $.ajax({
        url: "/background"
    }).done(function(html) {
        var img = new Image();
        img.onload = function() {
            $("body").css('backgroundImage', "url(" + img.src + ")");
            //the callback function call here
            console.log("Image loaded.");
            $("body").fadeIn(2000);
        };
        console.log("Found path: " + html);
        img.src = html;
    });
}

function getWeather() {
<<<<<<< HEAD
    $.ajax({
        url: "/weather"
    }).done(function(html) {
        $(".weather").html = html;
=======
    navigator.geolocation.getCurrentPosition(function(position) {
        loadWeather(position.coords.latitude+','+position.coords.longitude); //load weather using your lat/lng coordinates
    });
}

function loadWeather(location, woeid) {
    $.simpleWeather({
        location: location,
        woeid: woeid,
        unit: 'f',
        success: function(weather) {
            html = '<h2><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp+'</h2>';
            html += '<h3>'+weather.city+', '+weather.region+'</h3>';

            $("#weather").html(html);
        },
        error: function(error) {
            $("#weather").html('<p>'+error+'</p>');
        }
>>>>>>> 06fe587bddb9f423e4602a93f14071422d6793bf
    });
}

function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}

function startUp(){
    setWelcome();
    getWeather();
    setTodos();
    setBackground();
}