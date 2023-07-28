$(document).ready(function () {
    if (!$('#new_event_form')) return;

    // Disable ends_at selects when all_day checkbox is clicked
    $("#all_day_checkbox[type='checkbox']").on('change', function () {
        if ($(this).prop('checked')) {
            $('#ends_at_time select').val(null).prop('disabled', true);
            // Set starts_at time selects to 00:00
            $('#event_starts_at_4i').val("00");
            $('#event_starts_at_5i').val("00");
        } else {
            $('#ends_at_time select').prop('disabled', false);
        }
    });

    // Disable notify_at selects when page load
    $('#notification_time select').prop('disabled', true);

    // Enable notify_at selects when notification checkbox is clicked
    $("#notify_at_checkbox[type='checkbox']").on('change', function () {
        if ($(this).prop('checked')) {
            $('#notification_time select').prop('disabled', false);
        } else {
            $('#notification_time select').val(null).prop('disabled', true);
        }
    });
});
