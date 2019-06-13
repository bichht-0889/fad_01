$(function () {
  var ratings = $(".rate_point").text();
  var rating = $(".rating_point").text();
  var avg = $(".avg_point").text();
  $(".rateyo").rateYo();
  $(".rateyo-small").rateYo({
    readOnly: true
  })
  $(".rateyo-readonly-widg").rateYo({
    rating: ratings,
    readOnly: true
  });
  $(".rateyo-user_rating").rateYo({
    rating: 0
  });
  $(".rateyo-readonly-user").rateYo({
    rating: rating,
    readOnly: true
  });
  $('.change_quantity').onchange(function(event){
    this.form.submit();
 });
});

function set(id) {
  for (var i = 1; i <= 5; i++)
    document.getElementById(i).style.color = '#333';
  for (var i = 1; i <= id; i++)
    document.getElementById(i).style.color = 'yellow';
  document.getElementById('rate_rating').value = id;
}

$(document).on("turbolinks:load", function(){
  var h = $(window).height();
    var h_footer = $(".footer-widget").height();
    var height = $(".main_layout").height();
    if (height < h - h_footer) {
      height = $(".main_layout").height(h - 2 * h_footer);
    }
});
