$(document).ready(function() {
    if($('#edit_event_form').length) {

        // Check all_day checkbox when page load
        if($("#all_day_checkbox[type='checkbox']").prop('checked')) {
            $('#ends_at_time').hide();
        }

        // Hide ends_at selects when all_day checkbox is checked
        $("#all_day_checkbox[type='checkbox']").on('change', function() {
            if($(this).prop('checked')) {
                $('#ends_at_time select option').removeAttr('selected');
                $('#ends_at_time select').val("");
                $('#ends_at_time').hide();
            } else {
                $('#ends_at_time').show();
            }
        });

        // Check notify_at checkbox when page load
        if(!$("#notify_at_checkbox[type='checkbox']").prop('checked')) {
            $('#notification_time').hide();
        }

        // Hide notify_at selects when notification checkbox is not clicked
        $("#notify_at_checkbox[type='checkbox']").on('change', function() {
            if($(this).prop('checked')) {
                $('#notification_time select').show();
            } else {
                $('#notification_time select option').removeAttr('selected');
                $('#notification_time select').val("");
                $('#notification_time').hide();
            }
        });
    }
});
