$(document).ready(function(){
    $("a.fancybox").fancybox();

    $("select.styled").select2({
        minimumResultsForSearch:100
    });

    $('.datepicker').datepicker({
        format: 'yyyy/mm/dd'
    });
})