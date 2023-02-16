import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/screens/favourite/components/facourite_items.dart';
import 'package:omni_mobile_app/screens/favourite/components/favourite_header.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/services/wishlist_service/user_wishlist_service.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  CustomSecureStorage css = CustomSecureStorage();
  String newValue = "n";
  bool isLoading = true;
  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    setState(() {
      newValue = value;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    readToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserWishListService>().fetchWishListData(newValue);
    return Consumer<UserWishListService>(
      builder: ((context, value, child) {
        return value.map.length == 0 && !value.error && !value.isEmpty
            ? Center(
                child: Loading(height: 160),
              )
            : value.map.length == 0 && !value.error && value.isEmpty
                ? SafeArea(
                    child: Scaffold(
                    body: Container(
                      child: Column(
                        
                        children: [
                          FavouriteHeader(),
                          Container(
                            height: 500,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                              'assets/images/lover.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:20.0),
                              child: Text("You Haven't Add Favourite to the List"),
                            )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                : value.error
                    ? Center(
                        child: Text(value.errorMessage),
                      )
                    : Container(
                        color: primaryBackgroundColor,
                        child: SafeArea(
                          child: Scaffold(
                            backgroundColor: secondayBackgroundColor,
                            body: Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    FavouriteHeader(),
                                    Flexible(
                                        child: FavouriteItems(
                                      products: value.map,
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      );
      }),
    );
  }
}
