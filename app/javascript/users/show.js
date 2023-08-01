$(document).ready(function() {
    if($('#users_show').length) {

        if(localStorage["active_tab"]) {
            var activeTab = localStorage["active_tab"];
            $(`${activeTab}_tab, ${activeTab}`).addClass("active");
        }

        $("#today_events_tab").on("click", function(event) {
            $("#current_events_tab, #current_events").removeClass("active");
            $("#today_events_tab, #today_events").addClass("active");
            localStorage["active_tab"] = "#today_events";
        });

        $("#current_events_tab").on("click", function(event) {
            $("#today_events_tab, #today_events").removeClass("active");
            $("#current_events_tab, #current_events").addClass("active");
            localStorage["active_tab"] = "#current_events";
        });
    }
});
