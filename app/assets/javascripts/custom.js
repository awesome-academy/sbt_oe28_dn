$(document).ready(function(){
  $('body').on('click', '.showreply', function(){
    $(this).siblings('.form-comment').toggle(300);
  });
  $('.rating-tour').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });
  $('.average-tour-rating').raty({
      readOnly: true,
      path: '/assets/',
      score: function() {
        return $(this).attr('data-score')
      }
  });
  $('#rating-form').raty({
    path: '/assets',
    score: 1,
    scoreName: 'rating[rating_value]'
  });
  $('.datepicker').datepicker({
    dateFormat: 'yy-mm-dd'
  });
});
