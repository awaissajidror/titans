
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

document.addEventListener("DOMContentLoaded", function () {
    const this_month_pie = $('#this_month_pie-container').data('source');
    const typeNames      = this_month_pie.map(obj => obj.type);
    const salesData      = this_month_pie.map(obj => obj.sales);

    // Pie chart
    new Chart(document.getElementById("chartjs-dashboard-pie"), {
        type: "pie",
        data: {
            labels: typeNames,
            datasets: [{
                data: salesData,
                backgroundColor: [
                    window.theme.primary,
                    window.theme.success,
                    window.theme.secondary,
                    window.theme.warning,
                ],
                borderWidth: 5
            }]
        },
        options: {
            responsive: !window.MSInputMethodContext,
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            cutoutPercentage: 75
        }
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const monthly_sales = $('#monthly_sales-container').data('source');
    const monthNames    = monthly_sales.map(obj => obj.month);
    const salesData     = monthly_sales.map(obj => obj.sales);

    // Bar chart
    new Chart(document.getElementById("chartjs-dashboard-bar"), {
        type: "bar",
        data: {
            labels: monthNames,
            datasets: [{
                label: "This year (R)",
                backgroundColor: window.theme.primary,
                borderColor: window.theme.primary,
                hoverBackgroundColor: window.theme.primary,
                hoverBorderColor: window.theme.primary,
                data: salesData,
                barPercentage: .75,
                categoryPercentage: .5
            }]
        },
        options: {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            scales: {
                yAxes: [{
                    gridLines: {
                        display: false
                    },
                    stacked: false,
                    ticks: {
                        stepSize: 20
                    }
                }],
                xAxes: [{
                    stacked: false,
                    gridLines: {
                        color: "transparent"
                    }
                }]
            }
        }
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const markers = [{
        coords: [31.230391, 121.473701],
        name: "Shanghai"
    },
        {
            coords: [28.704060, 77.102493],
            name: "Delhi"
        },
        {
            coords: [6.524379, 3.379206],
            name: "Lagos"
        },
        {
            coords: [35.689487, 139.691711],
            name: "Tokyo"
        },
        {
            coords: [23.129110, 113.264381],
            name: "Guangzhou"
        },
        {
            coords: [40.7127837, -74.0059413],
            name: "New York"
        },
        {
            coords: [34.052235, -118.243683],
            name: "Los Angeles"
        },
        {
            coords: [41.878113, -87.629799],
            name: "Chicago"
        },
        {
            coords: [51.507351, -0.127758],
            name: "London"
        },
        {
            coords: [40.416775, -3.703790],
            name: "Madrid "
        }
    ];
    const map = new jsVectorMap({
        map: "world",
        selector: "#world_map",
        zoomButtons: true,
        markers: markers,
        markerStyle: {
            initial: {
                r: 9,
                strokeWidth: 7,
                stokeOpacity: .4,
                fill: window.theme.primary
            },
            hover: {
                fill: window.theme.primary,
                stroke: window.theme.primary
            }
        },
        zoomOnScroll: false
    });
    window.addEventListener("resize", () => {
        map.updateSize();
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const date = new Date(Date.now() - 5 * 24 * 60 * 60 * 1000);
    const defaultDate = date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + date.getUTCDate();
    document.getElementById("datetimepicker-dashboard").flatpickr({
        inline: true,
        prevArrow: "<span title=\"Previous month\">&laquo;</span>",
        nextArrow: "<span title=\"Next month\">&raquo;</span>",
        defaultDate: defaultDate
    });
});

$(document).ready(function () {
    $('.close-flash-icon').click(function () {
        $('.alert-dismissible').toggle();
    });
});

$(document).ready(function () {
    $('#total-cash, #total-card, #total-eft, #total-refund').on('keyup', function () {
        $('#create-cash-up-btn').prop('disabled', true);
    });

    $('#show-calculations').click(function () {
        // Getting Values

        const totalCash   = $('#total-cash').val();
        const totalCard   = $('#total-card').val();
        const totalEft    = $('#total-eft').val();
        const totalRefund = $('#total-refund').val();

        // Calculations
        const sum      = (parseFloat(totalCash) + parseFloat(totalCard) + parseFloat(totalEft)).toFixed(2)
        const subTotal = `${sum} - ${totalRefund}`;
        const total    = sum - totalRefund;

        // Populate fields
        $('#cash_up_sub_total').attr('value', subTotal);
        $('#cash_up_total').attr('value', total.toFixed(2));

        // Show/Hide functionality
        $('#create-cash-up-btn').prop('disabled', false)
    });
});
