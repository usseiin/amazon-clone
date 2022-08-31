import 'package:amazon_app/features/home/widgets/address_box.dart';
import 'package:amazon_app/features/product_details/screen/product_details_screen.dart';
import 'package:amazon_app/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../widgets/loader.dart';
import '../services/search_services.dart';
import '../../../constants/constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.searchValue}) : super(key: key);
  final String searchValue;

  static const String routeName = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices _searchServices = SearchServices();

  void getSearchedProduct() async {
    products = await _searchServices.fetchSearchProduct(
      context: context,
      searchValue: widget.searchValue,
    );
    setState(() {});
  }

  void navigateToSearchScreen(String searchValue) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchValue,
    );
  }

  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariable.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: (value) =>
                            navigateToSearchScreen(value),
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.search_outlined),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black38, width: 1),
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic),
                )
              ],
            ),
          ),
        ),
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
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
                            child: SearchedProduct(product: product));
                      },
                    ),
                  )
                ],
              ));
  }
}
