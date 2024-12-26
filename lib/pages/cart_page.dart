import 'package:flutter/material.dart';
import 'package:shopping_practice_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    debugPrint('Cart : $cart');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: cart.length,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final cartItem = cart[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
              ),
              title: Text(
                cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text(
                'Size: ${cartItem['sizes']} ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              splashColor: Theme.of(context).colorScheme.secondary,
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      useSafeArea: true,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Product',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          content: const Text(
                              'Are you sure you want to remove the product from cart?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .removeProduct(cartItem);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15),
                                          right: Radius.circular(15)),
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .bottomAppBarTheme
                                        .color,
                                    content: Text(
                                      '${cartItem['title']} removed successfully',
                                      style: Theme.of(context)
                                          .appBarTheme
                                          .titleTextStyle
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromRGBO(159, 0, 0, 1),
                  )),
            );
          },
        ),
      ),
    );
  }
}
