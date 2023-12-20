import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/model/vo/data_vo/data_vo.dart';
import 'package:omni_mobile_app/providers/check_out_provider/check_out_provider.dart';
import 'package:omni_mobile_app/share/app_style.dart';
import 'package:omni_mobile_app/share/flutter_toast/flutter_toast.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import '../../providers/add_to_cart/add_to_cart_provider.dart';
import '../../services/secure_storage/custom_secure_storage.dart';
import '../check_out_list/check_out_list_screen.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _token = "";

  CustomSecureStorage css = CustomSecureStorage();
  Future<void> readToken() async {
    final String token = await css.readValue();
    setState(() {
      _token = token;
    });
    final provider = Provider.of<AddToCartNotifier>(context, listen: false);
    provider.getCartsFromAPI(_token);
  }

  @override
  void initState() {
    readToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addToCartNotifier = Provider.of<AddToCartNotifier>(context);
    debugPrint("build called from cart screen");
    print(addToCartNotifier.cartDataList);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget loadingUI() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 30,
              ),
              Text("Loading...."),
            ],
          ),
        );
    Widget bodyUI(List<Datum> dataList) => Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Cart",
                        style: appStyle(28, FontWeight.bold, primaryTextColor),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        iconSize: 30.0,
                        color: primaryButtonColor,
                        icon: const Icon(UniconsLine.times),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height * 0.68,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(14),
                        ),
                        color: Colors.grey.shade200),
                    child: ListView.builder(
                      itemCount: dataList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final cartId = dataList[index].id;
                        final data = dataList[index];
                        final name = data.product.name.toString();
                        int quantity = data.quantity.toInt();
                        final category = data.product.category.name.toString();
                        int price = data.singlePrice;
                        String fullUrl = data.product.productImage
                            .map((e) => e.fullThumbnailLink.toString())
                            .toString();
                        fullUrl =
                            fullUrl.replaceAll('(', '').replaceAll(')', '');
                        CachedNetworkImageProvider imageProvider =
                            CachedNetworkImageProvider(fullUrl);
                        String formattedNumber =
                            NumberFormat('#,###').format(price);
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            height: height * 0.12,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(2, 2),
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(-2, -2),
                                  ),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: Colors.grey.shade100,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                            offset: Offset(2, 2),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                            offset: Offset(-1, -1),
                                          ),
                                        ]),
                                    child: Image(
                                        fit: BoxFit.contain,
                                        image: imageProvider,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                        errorBuilder:
                                            (context, exception, stackTrace) {
                                          return const Icon(
                                              UniconsLine.exclamation);
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: SizedBox(
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(18, FontWeight.bold,
                                              primaryTextColor),
                                          maxLines: 1,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          category,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: appStyle(12, FontWeight.w600,
                                              primaryTextColor),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          " $formattedNumber MMK",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(14, FontWeight.w500,
                                              primaryTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Consumer<AddToCartNotifier>(
                                  builder: (_, notifier, __) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 16,
                                        top: 6,
                                        bottom: 6,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (dataList[index].quantity >
                                                  0) {
                                                setState(() {
                                                  dataList[index].quantity--;
                                                });

                                                notifier.reduceQuantityToSever(
                                                    cartId, _token);
                                              }
                                              if (dataList[index].quantity ==
                                                  0) {
                                                notifier.removeCart(index);

                                                notifier.deleteCartFromSever(
                                                    cartId, _token);
                                                showToastMessage(
                                                    "$name is successfully delete from cart");
                                              }
                                            },
                                            child: const Icon(
                                              UniconsLine.minus_circle,
                                              size: 25,
                                              color: primaryButtonColor,
                                            ),
                                          ),
                                          Text(
                                            "$quantity",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                dataList[index].quantity++;
                                              });
                                              notifier.addQuantityToSever(
                                                  cartId, _token);
                                            },
                                            child: const Icon(
                                              UniconsLine.plus_circle,
                                              size: 25,
                                              color: primaryButtonColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      final provider =
                          Provider.of<CheckOutProvider>(context, listen: false);
                      provider.getAddress(_token);

                      if (dataList.isNotEmpty && provider.address != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CheckOutScreen(
                                cartDataList: dataList, token: _token),
                          ),
                        );
                      } else if (dataList.isEmpty) {
                        showToastMessage("You Have Nothing To Check Out");
                      } else {
                        const Center(
                          child: CircularProgressIndicator(
                            color: primaryBackgroundColor,
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      alignment: Alignment.center,
                      width: width * 0.9,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: primaryButtonColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Check Out",
                        style: appStyle(20, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

    return Scaffold(
        body: (addToCartNotifier.isLoading && addToCartNotifier.error.isEmpty)
            ? loadingUI()
            : Consumer<AddToCartNotifier>(
                builder: (_, notifier, __) {
                  return bodyUI(notifier.cartDataList);
                },
              ));
  }
}
