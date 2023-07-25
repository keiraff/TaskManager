
$(function () {

    //show it when the checkbox is clicked
    $('input[type="checkbox"][id="event_all_day"]').on('change', function () {
        if ($(this).prop('checked')) {
            $('div[id="endsAtTime"] > select').prop('disabled', true);
        } else {
            $('div[id="endsAtTime"] > select').prop('disabled', false);
        }
    });

    $('div[id="notificationTime"] > select').prop('disabled', true);

    $('input[type="checkbox"][id="event_notify_at_checkbox"]').on('change', function () {
        if ($(this).prop('checked')) {
            $('div[id="notificationTime"] > select').prop('disabled', false);
        } else {
            $('div[id="notificationTime"] > select').prop('disabled', true);
        }
    });
});
