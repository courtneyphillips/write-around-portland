$(function() {
  $(".quantity").on("change keyup paste", function() {
    var publication_id = $(this).attr("id");
    var quantity       = $(this).val();
    if (quantity) {
      $.ajax({
        method: "PATCH",
        url: "/update_cart",
        dataType: "json",
        data: { publication_id: publication_id,
          quantity:       quantity }
        }).then(function(response) {
          $("#total").text(response.total);
        });
      }
    });

  var handler = StripeCheckout.configure({
    key: "pk_test_OK48CUYdxgXKXZBFQGXwjTig",
    token: function(token) {
      $("#card_token").val(token.id);
      $("#email").val(token.email);
      $("#new_order").submit();
    }
  });

  $('#custom_button').on('click', function(e) {
    e.preventDefault();
    var total = $("#total").text();
    var amount = parseFloat(total.slice(1));
    // Open Checkout with further options
    handler.open({
      name: 'Total ' + total,
      description: 'Thanks for your purchase!',
      amount: amount * 100
    });
  });
});
