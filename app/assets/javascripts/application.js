// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require rails-ujs
//= require turbolinks
//= require jquery_ujs
//= require_tree .

$(document).on('turbolinks:load', function() {
    $('#job_poDate').addClass('ui-widget-header ui-helper-clearfix ui-corner-all').datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'yy-mm-dd'
    });

    $('.job-input-form').hide();

    $('.job-report-block')
        .addClass('ui widget ui-widget-content ui-helper-clearfix ui-corner-all')
        .find('.job-input')
        .addClass('ui-widget-header ui-corner-all toggle');

    $('.toggle').unbind('click').bind('click', function(){
        var id = $(this).attr('id');
        var icon = $('.job-input');
        if (id === 'job_sum') {
            console.log('I am the job_sum')
            icon.closest('#job-sum-block').find('.job-input-form').toggle();
        } else if (id === 'job_bom'){
            console.log('I am the job_bom')
            icon.closest('#job-bom-block').find('.job-input-form').toggle();
        }
    });

    $('#report-link').on('click', function(){
        var jobNum = $('#job_jobNum option:selected').val();
        window.load('/reports/job_summary?jobNum=' + jobNum);
    });
});