import 'package:amazon_app/features/product_details/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constant.dart';
import '../../../models/product.dart';
import '../service/home_services.dart';

class CategoryDealScreen extends StatefulWidget {
  static const routeName = '/category-deal-screen';
  const CategoryDealScreen({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;
  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  final HomeService _homeService = HomeService();
  List<Product>? products;
  void fetchCategoryProducts() async {
    products = await _homeService.fetchCategoryProduct(
      context: context,
      category: widget.category,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              'Keep shopping for ${widget.category}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          products != null
              ? products!.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Empty...'),
                    )
                  : SizedBox(
                      height: 170,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailScreen.routeName,
                                arguments: product,
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.network(
                                        product.images[0],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 0,
                                    right: 15,
                                  ),
                                  child: Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
              : Container(
                  alignment: Alignment.center,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
