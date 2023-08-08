$(document).ready(function() {
    if(!$('#event-info').length) {
        return;
    }

    if(!$("#external-api-url").text().length) {
        return;
    }

    // show a loader
    $('#loader').text("loading...");

    //request to https://open-meteo.com/
    $.getJSON($("#external-api-url").text()).done(function(data) {
        //get csrf token from meta
        const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
        $.ajaxSetup({
                headers: {'X-CSRF-Token': csrf}
            }
        );
        //hide loader
        $('#loader').text("");
        //send post request to /events/:id/weather_info with weather api response data as params
        $("#weather-info").load($("#weather-url").text(), {data: data});
    })
        .fail(function() {
            //hide loader
            $('#loader').text("");
            //show error message
            $("#weather-info").append("<p>Can't show forecast for this event.</p>");
        })
});
