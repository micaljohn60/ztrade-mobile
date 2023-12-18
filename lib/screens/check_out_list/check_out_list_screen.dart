import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/providers/check_out_provider/check_out_provider.dart';
import 'package:omni_mobile_app/share/app_style.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.values.first,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Check Out",
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
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<CheckOutProvider>(builder: (_, notifier, __) {
                  final dataList = notifier.cartList;

                  return Container(
                    height: height * 0.6,
                    margin: const EdgeInsets.all(8),
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
                        final price = data.totalPrice.toString();
                        final singlePrice = data.singlePrice.toString();
                        String fullUrl = data.product.productImage
                            .map((e) => e.fullThumbnailLink.toString())
                            .toString();
                        fullUrl =
                            fullUrl.replaceAll('(', '').replaceAll(')', '');
                        CachedNetworkImageProvider imageProvider =
                            CachedNetworkImageProvider(fullUrl);
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
                                    top: 5,
                                  ),
                                  child: SizedBox(
                                    width: width * 0.48,
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
                                        Text(
                                          category,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: appStyle(12, FontWeight.w600,
                                              primaryTextColor),
                                        ),
                                        Text(
                                          "$singlePrice MMK",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(14, FontWeight.w500,
                                              primaryTextColor),
                                        ),
                                        Text(
                                          "Total - $price MMK",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(14, FontWeight.w500,
                                              primaryTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    ' x $quantity',
                                    style: appStyle(
                                        16, FontWeight.w600, primaryTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment ",
                        style: appStyle(20, FontWeight.bold, primaryTextColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(UniconsLine.money_bill),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Cash On Delivery",
                            style:
                                appStyle(15, FontWeight.w500, primaryTextColor),
                          ),
                          const Spacer(),
                          Text(
                            "totalAmount",
                            style:
                                appStyle(15, FontWeight.w500, primaryTextColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CheckOutScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  alignment: Alignment.center,
                  width: width * 0.4,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: primaryButtonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Order ",
                    style: appStyle(20, FontWeight.bold, Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CheckOutScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  alignment: Alignment.center,
                  width: width * 0.4,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: primaryButtonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Order ",
                    style: appStyle(20, FontWeight.bold, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
