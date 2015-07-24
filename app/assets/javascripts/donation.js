$(function() {
  var handler = StripeCheckout.configure({
    key: "pk_test_OK48CUYdxgXKXZBFQGXwjTig",
    token: function(token) {
      $("#donation_card_token").val(token.id);
      $("#donation_email").val(token.email);
      $("#new_donation").submit();
    }
  });

  $('#custom_button').on('click', function(e) {
    e.preventDefault();
    var amount = $("#donation_amount").val();
    // Open Checkout with further options
    handler.open({
      name: 'Donating $' + amount,
      description: 'Thanks for your help!',
      amount: amount * 100
    });
  });
});
