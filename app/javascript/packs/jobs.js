//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//= require rails-ujs
//= require turbolinks
//= require jquery_ujs
//= require_tree .


$(document).on('turbolinks:load', function() {
    $(window).scroll(sticky_relocate);
    sticky_relocate();

    $('#sortable').sortable({
        connectWith: '#sortable',
        handle: '.row',
        placeholder: 'placeholder ui-corner-all',
        axis: 'y',
        start: function(event, ui){
            $(ui.item).data('old-index', ui.item.index());
        },
        stop: function(event, ui){
            var oldPriority = $(ui.item).data('old-index');
            var newPriority = ui.item.index();
            $.ajax({
                type: 'put',
                url: 'jobs/sort',
                data: {oldPriority: oldPriority, newPriority: newPriority}
            });
        }
    });

    $(this).find('.parts-block').hide();

    $('.job-block')
        .addClass('ui-widget ui-widget-content ui-helper-clearfix ui-corner-all')
        .find('.row')
        .addClass('ui-widget-header ui-corner-all toggle');

    $('.toggle').unbind('click').bind('click', function(){
        var icon = $(this);
        icon.closest('.job-block').find('.parts-block').toggle();
    });
});

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