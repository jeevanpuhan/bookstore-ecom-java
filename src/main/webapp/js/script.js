function addToCart(productId, productName, productPrice) {
  let cart = localStorage.getItem("cart");
  if (cart == null) {
    // no cart yet
    let products = [];
    let product = {
      productId,
      productName,
      productQuantity: 1,
      productPrice,
    };

    products.push(product);
    localStorage.setItem("cart", JSON.stringify(products));

    // console.log("Product is added for the first time!");
    showToast("Item added to cart");

  } else {
    // cart is already present
    let pcart = JSON.parse(cart);

    let oldProduct = pcart.find((item) => item.productId == productId);
    if (oldProduct) {
      // if we already have the product in cart, we just have to increment the quantity
      oldProduct.productQuantity += 1;
      pcart.map((item) => {
        if (item.productId == oldProduct.productId) {
          item.productQuantity = oldProduct.productQuantity;
        }
      });

      localStorage.setItem("cart", JSON.stringify(pcart));

    //   console.log("Product quantity is incremented!");
      showToast("Item quantity increased");

    } else {
      // if we don't have the product in cart, we have to add the new product
      let product = {
        productId,
        productName,
        productQuantity: 1,
        productPrice,
      };
      pcart.push(product);
      localStorage.setItem("cart", JSON.stringify(pcart));

    //   console.log("Product added to existing cart!");
    showToast("New item added to cart");
    }
  }

  updateCart();
}

// update cart

function updateCart() {
  let cartString = localStorage.getItem("cart");
  let cart = JSON.parse(cartString);

  if (cart == null || cart.length == 0) {

    console.log("Cart is empty!");
    $(".cart-items").html("( 0 )");
    $(".cart-body").html("<h4>No items in your cart!</h4>");
    $(".checkout-btn").addClass("disabled");

  } else {
    // there is something in cart
    console.log(cart);

    $(".cart-items").html(`(${cart.length})`);
    let table = `
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th>
                </tr>
            </thead>
        
        `;
    
        let totalPrice = 0;

    cart.map((item) => {

        table += `
            <tr>
                <td>${item.productName}</td>
                <td>&#8377 ${item.productPrice}</td>
                <td class="text-center">${item.productQuantity}</td>
                <td>&#8377 ${item.productQuantity*item.productPrice}</td>
                <td><button class="btn btn-danger btn-sm" onclick='deleteItemFromCart(${item.productId})' >Remove</button></td>
            </tr>
        
        `;

        totalPrice += item.productPrice*item.productQuantity;
    })

    table += `<tr><td colspan='5' class="text-right font-weight-bold m-5">Total Price: &nbsp &#8377 ${totalPrice}</td></tr> </table>`;
    $(".cart-body").html(table);

  }
}

// delete item using product id
function deleteItemFromCart(productId) {
    let cart = JSON.parse(localStorage.getItem("cart"));
    let newCart = cart.filter((item) => item.productId != productId);
    localStorage.setItem("cart",JSON.stringify(newCart));
    updateCart();

    showToast("Item removed from cart");
}

$(document).ready(function () {
  updateCart();
});


// toast message function
function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    },2000);
}