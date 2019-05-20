$(function () {
  var rating = $(".rate_point").text();
  $(".rateyo").rateYo();
  $(".rateyo-readonly-widg").rateYo({
    rating: rating,
    numStars: 5,
    precision: 2,
    minValue: 1,
    maxValue: 5
  })
});

$(document).ready(function() {
   $('.change_quantity').onchange(function(event){
     this.form.submit();
  });
