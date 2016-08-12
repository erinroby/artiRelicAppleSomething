// main.js file to use with Parse

var Stripe = require('stripe')('sk_test_PQ2NH73ti7lbZ9Vx9qXYucFz');
// Stripe.initialize('sk_test_PQ2NH73ti7lbZ9Vx9qXYucFz');
console.log("hello from main.js");

Parse.Cloud.define("hello", function(request, response) {
  // console.log(request.body.stripeToken);
  response.success("Hello world!");
});



// call this js function from within out iOS app
// Parse.Cloud.define('finalizePurchase', function(request, response) {
//
//   Stripe.Charges.create({
//     amount: 1225, // $10 expressed in cents
//     currency: 'usd',
//     source: request.params.cardToken // the token id should be sent from the client
//   },
//     {
//       success: function(httpResponse) {
//         response.success("Purchase made!");
//       },
//       error: function(httpResponse) {
//         response.error("Uh oh, something went wrong");
//       }
//     });
// });

Parse.Cloud.define('finalizePurchase', function(request, response) {
  Parse.Promise.as().then(function(purchase){
    var order = new Parse.Object('Order');
    order.set("name", "testPurchase");
    return order.save().then(null, function(error){
      return Parse.Promise.error("Critial error handling");
    });
  }).then(function(order) {
    console.log(request.params.cardToken);
    return Stripe.charges.create({
      amount: 12250,
      currency: 'usd',
      source: request.params.cardToken
    }).then(function() {
      // order.set('charged', true);
      response.success("Success");
    });
  })
});


// THIS WORKS SORT OF ¯\_(ツ)_/¯
// Parse.Cloud.define('finalizePurchase', function(request, response) {
//   Parse.Promise.as().then(function(purchase){
//     var order = new Parse.Object('Order');
//     //  This BELOW DOES NOT WORK! PARAMS _ I HAD A HUNCH
//     // console.log(Stripe);
//     // order.set('stripePaymentID', purchase.id);
//     // order.set('charged', true);
//     // order.set("amount", 1225);
//     // order.set("currency", "usd");
//     order.set("name", "testPurchase");
//     return order.save().then(null, function(error){
//       return Parse.Promise.error("Critial error handling");
//     });
//   }).then(function() {
//     response.success("Success");
//   });
// });
