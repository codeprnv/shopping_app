import 'package:flutter/material.dart';
import 'package:shopping_practice_app/utils/global_variables.dart';
import 'package:shopping_practice_app/widgets/product_card.dart';
import 'package:shopping_practice_app/pages/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Puma',
  ];
  late String selectedFilter;
  @override
  void initState() {
    selectedFilter = filters[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(40),
      ),
    );
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                // width: double.infinity,
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filters.length,
                  itemBuilder: (BuildContext context, int index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              selectedFilter = filter;
                              debugPrint(selectedFilter);
                            },
                          );
                        },
                        child: Chip(
                          backgroundColor: selectedFilter == filter
                              ? colorscheme.inversePrimary
                              : const Color.fromRGBO(245, 247, 249, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          label: Text(
                            filter,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1080) {
                    return GridView.builder(
                      itemCount: products.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.75,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetails(product: product);
                                },
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String,
                            productImage: product['imageUrl'] as String,
                            productPrice: product['price'] as double,
                            backgroundColor: index.isEven
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.inversePrimary,
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetails(product: product);
                                },
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String,
                            productImage: product['imageUrl'] as String,
                            productPrice: product['price'] as double,
                            backgroundColor: index.isEven
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.inversePrimary,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
