import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String productImage;
  final double productPrice;
  final Color backgroundColor;
  const ProductCard({
    super.key,
    required this.title,
    required this.productImage,
    required this.productPrice,
    required this.backgroundColor,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: Theme.of(context).colorScheme.secondary,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      color: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        // side: BorderSide(
        //     color: Theme.of(context).colorScheme.secondary, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: favorite == true ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      favorite = !favorite;
                      debugPrint('favorite : $favorite');
                    });
                  },
                ),
              ],
            ),
            Text(
              '\$${widget.productPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Image.asset(
                widget.productImage,
                width: 250,
                height: 160,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
