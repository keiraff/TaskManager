$(document).ready(function () {
    if ($('#new_event_form').length) {

        // Check all_day checkbox when page load
        if ($("#all_day_checkbox[type='checkbox']").prop('checked')) {
            $('#ends_at_time').hide();
        }

        // Disable ends_at selects when all_day checkbox is clicked
        $("#all_day_checkbox[type='checkbox']").on('change', function () {
            if ($(this).prop('checked')) {
                $('#ends_at_time select').val(null);
                // Set starts_at time selects to 00:00
                $('#event_starts_at_4i').val("00");
                $('#event_starts_at_5i').val("00");
                $('#ends_at_time').hide();
            } else {
                $('#ends_at_time').show();
            }
        });

        // Disable notify_at selects when page load
        $('#notification_time').hide();

        // Enable notify_at selects when notification checkbox is clicked
        $("#notify_at_checkbox[type='checkbox']").on('change', function () {
            if ($(this).prop('checked')) {
                $('#notification_time').show();
            } else {
                $('#notification_time select').val(null);
                $('#notification_time').hide();
            }
        });
    }
});
