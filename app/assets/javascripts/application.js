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
    if(hour < 2 || hour >= 22) msg = "Getting tired, Pieter?";
    else if(hour >= 2 && hour < 6) msg = "Can't sleep, Pieter?";
    else if(hour >= 6 && hour < 10) msg = "Good morning, Pieter.";
    else if(hour >= 10 && hour < 12) msg = "How are you, Pieter?";
    else if(hour >= 12 && hour < 17) msg = "Good afternoon, Pieter.";
    else if(hour >= 17 && hour < 22) msg = "Good evening, Pieter.";

    document.getElementById('welcometxt').innerHTML = msg;
    var t = setTimeout(welcomeMsg, 60000);
}

function setWeather(){
    $.ajax({
        url: "/weather"
    }).done(function(html) {
        $(".weather").append(html);
    });
}

function setTodo(){
    $.ajax({
        url: "/todolist"
    }).done(function(html) {
        $(".todo").append(html);
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
        document.body.background = html;
    });
}

function setLinks(){
    $.ajax({
        url: "/links"
    }).done(function(html) {
        document.getElementById('links').innerHTML = html;
    });
}

function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}

function startUp(){
    setWelcome();
    setWeather();
    setTodo();
    setLinks();
    setBackground();
}