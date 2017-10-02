/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')

$(document).ready( function() {
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