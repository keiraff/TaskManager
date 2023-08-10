$(document).ready(function() {
    if(!$('#edit_settings_form').length) {
        return;
    }

    // Check if country select is changed
    $('#country_select').on("change", function() {
        var country = $(this).val();

        // Send ajax request with country info
        $.ajax({
            url: "/settings/1/edit",
            method: "GET",
            dataType: "json",
            data: {country: country},
            error: function(xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function(response) {
                var states = response["states"];

                // Check if states has any values
                if(jQuery.isEmptyObject(states)) {
                    // Disable state and city selects
                    $("#state_select").empty().append('<option value>Select State</option>').prop('disabled', true);
                    $("#city_select").empty().append('<option value>Select City</option>').prop('disabled', true);

                    // Show error message
                    $("#state_select_errors").text("No states found.");
                } else {
                    // Enable state and city selects, delete previous options and set default options to selects
                    $("#state_select").prop('disabled', false).empty().append('<option value>Select State</optionvalue>');
                    $("#city_select").prop('disabled', false).empty().append('<option value>Select City</option>');

                    // Hide error message
                    $("#state_select_errors").text("");

                    // Append options to state select with values from ajax response
                    $.each(states, function(key, value) {
                        $("#state_select").append('<option value="' + key + '">' + value + '</option>');
                    });
                }
            }
        });
    });

    // Check if state select is changed
    $('#state_select').on("change", function() {
        var country = $('#country_select').val();
        var state = $(this).val();

        // Send ajax request with state info
        $.ajax({
            url: "/settings/1/edit",
            method: "GET",
            dataType: "json",
            data: {state: state, country: country},
            error: function(xhr, status, error) {
                console.error('AJAX Error: ' + status + error);
            },
            success: function(response) {
                var cities = response["cities"];

                // Check if cities has any values
                if(jQuery.isEmptyObject(cities)) {
                    // Disable city select
                    $("#city_select").empty().append('<option value>Select City</option>').prop('disabled', true);

                    // Show error message
                    $("#city_select_errors").text("No cities found.");
                } else {
                    // Enable city select, delete previous options and set default option to select
                    $("#city_select").prop('disabled', false).empty().append('<option value>Select City</option>');

                    // Hide error message
                    $("#city_select_errors").text("");

                    // Append options to city select with values from ajax response
                    for (var i = 0; i < cities.length; i++) {
                        $("#city_select").append('<option value="' + cities[i] + '">' + cities[i] + '</option>');
                    }
                }
            }
        });
    });

});
