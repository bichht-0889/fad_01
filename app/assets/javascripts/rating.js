$(function () {
  var ratings = $(".rate_point").text();
  var rating = $(".rating_point").text();
  $(".rateyo").rateYo();
  $(".rateyo-readonly-widg").rateYo({
    rating: ratings,
    readOnly: true
  })
  $(".rateyo-user_rating").rateYo({
    rating: 0
  })
  $(".rateyo-readonly-user").rateYo({
    rating: rating,
    readOnly: true
  })
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
