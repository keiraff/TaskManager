$(document).ready(function() {
    if(!($('#events_new_form')||$('#events_edit_form'))) return;

    if($("#all_day_checkbox[type='checkbox']").prop('checked')) {
        $('#ends_at_time select').prop('disabled', true);
    }

    // Disable ends_at selects when all_day checkbox is clicked
    $("#all_day_checkbox[type='checkbox']").on('change', function() {
        if($(this).prop('checked')) {
            $('#ends_at_time select').prop('disabled', true);
        } else {
            $('#ends_at_time select').prop('disabled', false);
        }
    });

    if($("#notify_at_checkbox[type='checkbox']").prop('checked')) {
        $('#notification_time select').prop('disabled', false);
    }
    else {
        $('#notification_time select').prop('disabled', true);
    }

    // Enable notify_at selects when notification checkbox is clicked
    $("#notify_at_checkbox[type='checkbox']").on('change', function() {
        if($(this).prop('checked')) {
            $('#notification_time select').prop('disabled', false);
        } else {
            $('#notification_time select').prop('disabled', true);
        }
    });
});
