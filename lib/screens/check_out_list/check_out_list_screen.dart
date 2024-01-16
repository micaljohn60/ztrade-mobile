import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/model/vo/data_vo/data_vo.dart';
import 'package:omni_mobile_app/providers/check_out_provider/check_out_provider.dart';
import 'package:omni_mobile_app/screens/home/home.dart';
import 'package:omni_mobile_app/share/app_style.dart';
import 'package:omni_mobile_app/share/flutter_toast/flutter_toast.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key key, this.cartDataList, this.token})
      : super(key: key);
  final List<Datum> cartDataList;
  final String token;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final instance = Provider.of<CheckOutProvider>(context, listen: false);
    instance.getAddress(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final checkOut = Provider.of<CheckOutProvider>(context);
    int totalPrice = widget.cartDataList
        .map((e) => e.totalPrice)
        .fold(0, (previousValue, element) => previousValue + element);
    String formattedNumber = NumberFormat('#,###').format(totalPrice);
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
    return Scaffold(
        body: (checkOut.isLoading && checkOut.address != null)
            ? loadingUI()
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Check Out",
                                style: appStyle(
                                    28, FontWeight.bold, primaryTextColor),
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
                        Consumer<CheckOutProvider>(
                          builder: (_, notifier, __) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (checkOut.isLoading)
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              barrierColor: Colors.white54,
                                              builder: (context) =>
                                                  SingleChildScrollView(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        primaryBackgroundColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      topRight:
                                                          Radius.circular(12),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            "Input Your Location",
                                                            style: appStyle(
                                                                18,
                                                                FontWeight.bold,
                                                                Colors.white),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          12)),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              validator: (text) =>
                                                                  text.isEmpty
                                                                      ? "Need to Input Street"
                                                                      : null,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              autofocus: false,
                                                              controller: notifier
                                                                  .streetController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Street',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                focusColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                filled: true,
                                                                enabled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hoverColor:
                                                                    Colors
                                                                        .yellow,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          12)),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              validator: (text) =>
                                                                  text.isEmpty
                                                                      ? "Need to Input City"
                                                                      : null,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              autofocus: false,
                                                              controller: notifier
                                                                  .cityController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'City',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                focusColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                filled: true,
                                                                enabled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hoverColor:
                                                                    Colors
                                                                        .yellow,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          12)),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              validator: (text) =>
                                                                  text.isEmpty
                                                                      ? "Need to Input State"
                                                                      : null,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              autofocus: false,
                                                              controller: notifier
                                                                  .stateController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'State',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                focusColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                filled: true,
                                                                enabled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hoverColor:
                                                                    Colors
                                                                        .yellow,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          12)),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              validator: (text) =>
                                                                  text.isEmpty
                                                                      ? "Need to Input Country"
                                                                      : null,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              autofocus: false,
                                                              controller: notifier
                                                                  .countryController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Country',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                focusColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                filled: true,
                                                                enabled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hoverColor:
                                                                    Colors
                                                                        .yellow,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          12)),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              validator: (text) =>
                                                                  (text.isEmpty &&
                                                                          text.length <
                                                                              6)
                                                                      ? "Need to Input Postal Code"
                                                                      : null,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              autofocus: false,
                                                              controller: notifier
                                                                  .postalCodeController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Postal Code',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                focusColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                filled: true,
                                                                enabled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hoverColor:
                                                                    Colors
                                                                        .yellow,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          12)),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              validator: (text) => (text
                                                                          .isEmpty ||
                                                                      text.startsWith(
                                                                          "09"))
                                                                  ? "Need to Input Phone Number and It should be start with 09xxxxxxxxx"
                                                                  : null,
                                                              controller: notifier
                                                                  .phoneController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .phone,
                                                              autofocus: false,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Phone Number',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                focusColor:
                                                                    Colors
                                                                        .white,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                filled: true,
                                                                enabled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hoverColor:
                                                                    Colors
                                                                        .yellow,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(12),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          12),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    "Close ",
                                                                    style: appStyle(
                                                                        16,
                                                                        FontWeight
                                                                            .bold,
                                                                        primaryTextColor),
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (_formKey
                                                                      .currentState
                                                                      .validate()) {
                                                                    notifier.addAddress(
                                                                        widget
                                                                            .token);
                                                                    notifier.getAddress(
                                                                        widget
                                                                            .token);
                                                                    _formKey
                                                                        .currentState
                                                                        .save();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  } else {
                                                                    showToastMessage(
                                                                        "You need to add your location");
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(12),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          12),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    "Confirm ",
                                                                    style: appStyle(
                                                                        16,
                                                                        FontWeight
                                                                            .bold,
                                                                        primaryTextColor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            UniconsLine.edit,
                                            size: 18.0,
                                            color: primaryButtonColor,
                                          ),
                                        ),
                                  const SizedBox(width: 10),
                                  Consumer<CheckOutProvider>(
                                    builder: (context, notifier, child) {
                                      final street =
                                          notifier.address.data.street;
                                      final state = notifier.address.data.state;
                                      final city = notifier.address.data.city;
                                      final postalCode =
                                          notifier.address.data.postalCode;
                                      final country =
                                          notifier.address.data.country;
                                      return Flexible(
                                        child: Text(
                                          notifier.address.data == null
                                              ? "Choose Location"
                                              : '$street - $state - $city - $country - $postalCode',
                                          style: appStyle(13, FontWeight.w500,
                                              primaryTextColor),
                                          // overflow: TextOverflow.ellipsis,

                                          maxLines: 2,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Consumer<CheckOutProvider>(
                          builder: (_, notifier, __) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    UniconsLine.phone,
                                    size: 18.0,
                                    color: primaryButtonColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                      notifier.address.data.phone ??
                                          "Your Phone Number",
                                      style: appStyle(14, FontWeight.w500,
                                          primaryTextColor)),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: height * 0.55,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(14),
                              ),
                              color: Colors.grey.shade200),
                          child: ListView.builder(
                            itemCount: widget.cartDataList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              // final cartId = widget.cartDataList[index].id;
                              final data = widget.cartDataList[index];
                              final name = data.product.name.toString();
                              int quantity = data.quantity.toInt();
                              final category =
                                  data.product.category.name.toString();
                              int price = data.totalPrice;
                              int singlePrice = data.singlePrice;
                              String fullUrl = data.product.productImage
                                  .map((e) => e.fullThumbnailLink.toString())
                                  .toString();
                              fullUrl = fullUrl
                                  .replaceAll('(', '')
                                  .replaceAll(')', '');
                              CachedNetworkImageProvider imageProvider =
                                  CachedNetworkImageProvider(fullUrl);
                              String singleFormattedNumber =
                                  NumberFormat('#,###').format(singlePrice);
                              String priceFormattedNumber =
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
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                              },
                                              errorBuilder: (context, exception,
                                                  stackTrace) {
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
                                                style: appStyle(
                                                    18,
                                                    FontWeight.bold,
                                                    primaryTextColor),
                                                maxLines: 1,
                                              ),
                                              Text(
                                                category,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: appStyle(
                                                    12,
                                                    FontWeight.w600,
                                                    primaryTextColor),
                                              ),
                                              Text(
                                                "$singleFormattedNumber MMK",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: appStyle(
                                                    14,
                                                    FontWeight.w500,
                                                    primaryTextColor),
                                              ),
                                              Text(
                                                "Total - $priceFormattedNumber MMK",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: appStyle(
                                                    14,
                                                    FontWeight.w500,
                                                    primaryTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          ' x $quantity',
                                          style: appStyle(16, FontWeight.w600,
                                              primaryTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment",
                                style: appStyle(
                                    20, FontWeight.bold, primaryTextColor),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(UniconsLine.money_bill),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Cash On Delivery",
                                    style: appStyle(
                                        15, FontWeight.w500, primaryTextColor),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "$formattedNumber MMK",
                                    style: appStyle(
                                        15, FontWeight.w500, primaryTextColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<CheckOutProvider>(
                      builder: (_, notifier, __) {
                        return GestureDetector(
                          onTap: () {
                            notifier.orderCheckOut(widget.token, 'cod');
                            showToastMessage("Order Check Out Successful");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
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
                              "Order Confirm",
                              style:
                                  appStyle(20, FontWeight.bold, Colors.white),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ));
  }
}
