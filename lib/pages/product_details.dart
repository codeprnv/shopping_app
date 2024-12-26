import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_practice_app/providers/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                widget.product['imageUrl'] as String,
                height: 250,
              ),
            ),
            const Spacer(flex: 2),
            Container(
              height: 250,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(211, 213, 245, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('\$${widget.product['price']}',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            (widget.product['sizes'] as List<int>).length,
                        itemBuilder: (context, index) {
                          final size =
                              (widget.product['sizes'] as List<int>)[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    selectedSize = size;
                                  },
                                );
                              },
                              child: Chip(
                                color: WidgetStatePropertyAll(
                                    selectedSize == size
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                label: Text(
                                  (widget.product['sizes'] as List)[index]
                                      .toString(),
                                  style: TextStyle(
                                      color: selectedSize == size
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        style: ButtonStyle(
                          fixedSize: const WidgetStatePropertyAll(
                            Size(350, 50),
                          ),
                          iconColor: const WidgetStatePropertyAll(Colors.white),
                          foregroundColor:
                              const WidgetStatePropertyAll(Colors.white),
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () {
                          if (selectedSize != 0) {
                            Provider.of<CartProvider>(context, listen: false)
                                .addProduct(
                              {
                                'id': widget.product['id'],
                                'title': widget.product['title'],
                                'price': widget.product['price'],
                                'imageUrl': widget.product['imageUrl'],
                                'company': widget.product['company'],
                                'sizes': selectedSize,
                              },
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(15),
                                      right: Radius.circular(15)),
                                ),
                                backgroundColor:
                                    Theme.of(context).bottomAppBarTheme.color,
                                content: Text(
                                  '${widget.product['title']} added successfully',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(15),
                                      right: Radius.circular(15)),
                                ),
                                backgroundColor:
                                    Theme.of(context).bottomAppBarTheme.color,
                                content: Text(
                                  'Please select a size',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
