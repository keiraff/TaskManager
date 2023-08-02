$(document).ready(function() {
    if(!$('#users_show').length) {
        return;
    }

    if(localStorage["active_tab"]) {
        $(`${localStorage["active_tab"]}`).tab("show");
    }

    $("#today_events_tab, #current_events_tab").on("click", function(event) {
        localStorage["active_tab"] = `#${event.target.id}`;
        $(`${localStorage["active_tab"]}`).tab("show");
    });
});
