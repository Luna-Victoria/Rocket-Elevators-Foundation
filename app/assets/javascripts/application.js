//= require jquery
//= require jquery-3.3.1.min
//= require scripts
//= require main
//= require main-quote
//= require jquery.themepunch.tools.min
//= require jquery.themepunch.revolution.min
//= require demo.revolution_slider
//= require owl.carousel
//= require owl.carousel.min
//= require Chart

$(function col() {
    $("select#intervention_column_id").on("change", function col() {
        $.ajax({
            url:  "/filter_elevators_by_column",
            type: "GET",
            data: { selected_column: $("select#intervention_column_id").val() }
        });
    });
});

$(function bat() {
    $("select#intervention_battery_id").on("change", function bat() {
        $.ajax({
            url:  "/filter_columns_by_battery",
            type: "GET",
            data: { selected_battery: $("select#intervention_battery_id").val() }
        });
    });
});

$(function build() {
    $("select#intervention_building_id").on("change", function build() {
        $.ajax({
            url:  "/filter_batteries_by_building",
            type: "GET",
            data: { selected_building: $("select#intervention_building_id").val() }
        });
    });
});

$(function cus() {
    $("select#intervention_customer_id").on("change", function cus() {
        $.ajax({
            url:  "/filter_buildings_by_customer",
            type: "GET",
            data: { selected_customer: $("select#intervention_customer_id").val() }
        });
    });
});


