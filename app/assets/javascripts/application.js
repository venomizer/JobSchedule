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


function sticky_relocate() {
    var window_top = $(window).scrollTop();
    var div_top = $('#sticky-anchor').offset().top;
    if (window_top > div_top) {
        $('#sticky').addClass('stick');
        $('#sticky-anchor').height($('#sticky').outerHeight());
    } else {
        $('#sticky').removeClass('stick');
        $('#sticky-anchor').height(0);
    }
}

$(function() {
    $(window).scroll(sticky_relocate);
    sticky_relocate();

    $(this).find('.parts-block').hide();

    $('#sortable').sortable({
        axis: 'y',
        start: function(event, ui){
            $(ui.item).data('old-index', ui.item.index());
        },
        update: function(event, ui){
            var oldPriority = $(ui.item).data('old-index');
            var newPriority = ui.item.index();
            $.ajax({
                type: 'put',
                url: 'jobs/sort',
                data: {oldPriority: oldPriority, newPriority: newPriority}
            });
        }
    });

    $('.job-block')
        .addClass('ui-widget ui-widget-content ui-helper-clearfix ui-corner-all')
        .find('.row').addClass('ui-widget-header').end().find('.parts-block');

    $('.row').click(function(){
        $(this).parents('.job-block:first').find('.parts-block').toggle('fade', 'fast');
    });

});

