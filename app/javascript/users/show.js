$(document).ready(function() {
    if($('#users_show').length) {

        $("#today_events_tab").on("click", function(event) {
            $("#current_events_tab, #current_events").removeClass("active");
            $("#today_events_tab, #today_events").addClass("active");
        });

        $("#current_events_tab").on("click", function(event) {
            $("#today_events_tab, #today_events").removeClass("active");
            $("#current_events_tab, #current_events").addClass("active");
        });
    }
});
