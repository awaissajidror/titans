// Custom JS
$(document).ready(function () {
    // Show/hide Search Content
    $("#generate-report").click(function() {
        if ($('#search-content').hasClass('hide')) {
            $("#search-content").removeClass('hide');
        } else {
            $("#search-content").addClass('hide');
        }
    });

    // Close Flash Message Bar
    $('.close-flash-icon').click(function () {
        $('.alert-dismissible').toggle();
    });

    // Showing Calculations Div
    $('#show-calculations').click(function () {
        // Getting Values

        const totalCash   = $('#total-cash').val();
        const totalCard   = $('#total-card').val();
        const totalEft    = $('#total-eft').val();
        const totalRefund = $('#total-refund').val();

        // Calculations
        const sum     = (parseFloat(totalCash) + parseFloat(totalCard) + parseFloat(totalEft)).toFixed(2)
        const subTotal= `${sum} - ${totalRefund}`;
        const total = sum - totalRefund;

        // Populate fields
        $('#cash_up_sub_total').attr('value', subTotal);
        $('#cash_up_total').attr('value', total.toFixed(2));

        // Show/Hide functionality
        $('#create-cash-up-btn').prop('disabled', false)
    });

    // Toggle Report Checkboxes
    $('#cb-spr-report').change(function() {
        if ($(this).is(':checked')) {
            $('#cb-csv-report').prop('checked', false);
        }
    });

    $('#cb-csv-report').change(function() {
        if ($(this).is(':checked')) {
            $('#cb-spr-report').prop('checked', false);
        }
    });

    // Mark Attendance
    $('.mark-attendance').on('change', function() {
        const checkbox = $(this);
        const day      = checkbox.attr('id').split('-')[0];
        const month    = checkbox.attr('id').split('-')[1];
        const year     = checkbox.attr('id').split('-')[2];
        const status   = checkbox.attr('id').split('-')[3];
        const user_id  = checkbox.attr('id').split('-')[4];
        const date = day + '-' + month + '-' + year;
        debugger;

        $.ajax({
            url: '/mark_attendance',
            type: 'POST',
            data: {
                attendance_date: date,
                status:          status,
                user_id:         user_id,
                checked:         checkbox.prop('checked')
            },
            success: function(response) {
                console.log('Attendance updated successfully');
            },
            error: function(xhr, status, error) {
                console.log('Error updating attendance:', error);
            }
        });
    });

    // Total Cash Calculations
    $('#total-cash, #total-card, #total-eft, #total-refund').on('keyup', function () {
        $('#create-cash-up-btn').prop('disabled', true);
    });

    // Handle phone input
    $(document).on('keypress keyup blur', '.sa-phone-input', function (event) {
        // Allow only numeric characters, spaces, and a plus sign at the beginning
        $(this).val($(this).val().replace(/[^+\d\s]+/g, ""));

        if (
            (event.which < 48 || event.which > 57) && // Numeric characters
            event.which !== 32 && // Space
            event.which !== 43 // Plus sign
        ) {
            event.preventDefault();
        }
    });

    // South African phone formatting
    $(".sa-phone-input").on('focus', function () {
        const inputValue = $(this).val().replace(/\D/g, "").substring(0, 11);

        if (inputValue === "") {
            $(this).val("+27 ");
        }
    }).on('input', function () {
        const inputValue = $(this).val().replace(/\D/g, "").substring(0, 11);
        const countryCode = "+27";
        const areaCode = inputValue.substring(2, 4);
        const middle = inputValue.substring(4, 7);
        const last = inputValue.substring(7, 11);

        if (inputValue.length > 7) {
            $(this).val(countryCode + " " + areaCode + " " + middle + " " + last);
        } else if (inputValue.length > 4) {
            $(this).val(countryCode + " " + areaCode + " " + middle);
        } else if (inputValue.length > 2) {
            $(this).val(countryCode + " " + areaCode);
        } else if (inputValue.length > 0) {
            $(this).val(countryCode);
        }
    });
});

// Chart JS
document.addEventListener("DOMContentLoaded", function () {
    const ctx             = document.getElementById("chartjs-dashboard-line").getContext("2d");
    const recent_movement = $('#recent_movement-container').data('source');
    const monthNames      = recent_movement.map(obj => obj.month);
    const salesData       = recent_movement.map(obj => obj.sales);
    const gradient        = ctx.createLinearGradient(0, 0, 0, 225);

    gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
    gradient.addColorStop(1, "rgba(215, 227, 244, 0)");

    // Line chart
    new Chart(document.getElementById("chartjs-dashboard-line"), {
        type: "line",
        data: {
            labels: monthNames,
            datasets: [{
                label: "Sales (R)",
                fill: true,
                backgroundColor: gradient,
                borderColor: window.theme.primary,
                data: salesData
            }]
        },
        options: {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                intersect: false
            },
            hover: {
                intersect: true
            },
            plugins: {
                filler: {
                    propagate: false
                }
            },
            scales: {
                xAxes: [{
                    reverse: true,
                    gridLines: {
                        color: "rgba(0,0,0,0.0)"
                    }
                }],
                yAxes: [{
                    ticks: {
                        stepSize: 1000
                    },
                    display: true,
                    borderDash: [3, 3],
                    gridLines: {
                        color: "rgba(0,0,0,0.0)"
                    }
                }]
            }
        }
    });
});