import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/providers/add_to_cart/add_to_cart_provider.dart';
import 'package:omni_mobile_app/providers/app_providers.dart';
import 'package:omni_mobile_app/screens/cart/cart_screen.dart';
import 'package:omni_mobile_app/screens/profile/profile.dart';
import 'package:omni_mobile_app/screens/search/search.dart';
import 'package:omni_mobile_app/services/search/search_suggestion.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/share/app_style.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class TopBar extends StatefulWidget {
  TopBar({Key key, this.userId}) : super(key: key);
  String userId;
  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  CustomSecureStorage css = CustomSecureStorage();
  String newValue = "n";
  String token = "";

  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    final String userToken = await css.readValue();
    setState(() {
      newValue = value;
      token = userToken;
    });
    Provider.of<AddToCartNotifier>(context, listen: false)
        .getCartsFromAPI(token);
  }

  @override
  void initState() {
    readToken();

    super.initState();
  }

  List<String> suggestons = [];
  @override
  Widget build(BuildContext context) {
    context.read<SearchSuggestionService>().fetchData(newValue);
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(color: primaryBackgroundColor),
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer<SearchSuggestionService>(
            builder: ((context, value, child) {
              return value.map.length == 0 && !value.error
                  ? const Text("")
                  : value.error
                      ? Text(value.errorMessage)
                      : SizedBox(
                          height: 65.0,
                          width: newValue != null ? width * 0.7 : width * 0.8,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RawAutocomplete(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  List<String> matches = <String>[];
                                  print(value
                                      .map["productSuggestion"].runtimeType);
                                  suggestons = value.stringData as List;

                                  matches.addAll(suggestons);

                                  matches.retainWhere((s) {
                                    return s.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                  return matches;
                                },
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted) {
                                  return TextField(
                                    style: const TextStyle(
                                        color: secondayBackgroundColor),
                                    onChanged: (value) {
                                      AppProviders.disposeSearch(context);
                                    },
                                    onSubmitted: (value) async {
                                      pushNewScreen(
                                        context,
                                        screen: Search(
                                          userID: widget.userId,
                                          id: newValue,
                                          text: value,
                                        ),
                                        withNavBar: true,
                                      );
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                            UniconsLine.search,
                                            color: secondayBackgroundColor),
                                        labelText: "Search",
                                        labelStyle: const TextStyle(
                                            color: secondayBackgroundColor),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2,
                                                color: secondayBackgroundColor),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2,
                                                color: secondayBackgroundColor),
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                  );
                                },
                                optionsViewBuilder: (BuildContext context,
                                    void Function(String) onSelected,
                                    Iterable<String> options) {
                                  return Material(
                                      child: SizedBox(
                                          height: 200,
                                          child: SingleChildScrollView(
                                              child: Column(
                                            children: options.map((opt) {
                                              return InkWell(
                                                  onTap: () {
                                                    onSelected(opt);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 60),
                                                      child: Card(
                                                          child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(opt),
                                                      ))));
                                            }).toList(),
                                          ))));
                                },
                              )),
                        );
            }),
          ),
          IconButton(
            onPressed: () => {
              pushNewScreen(
                context,
                screen: Profile(token: newValue),
              ),
            },
            icon: const Icon(
              UniconsLine.user,
              size: 30.0,
              color: secondayBackgroundColor,
            ),
          ),
          Consumer<AddToCartNotifier>(builder: (_, notifier, __) {
            return Visibility(
              visible: newValue != null,
              child: Badge(
                toAnimate: true,
                showBadge: notifier.cartDataList.isNotEmpty,
                badgeColor: Colors.redAccent,
                elevation: 0,
                ignorePointer: false,
                badgeContent: Text(
                  '${notifier.cartDataList.length}',
                  style: appStyle(12, FontWeight.w300, Colors.white),
                ),
                animationType: BadgeAnimationType.fade,
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () => {
                    pushNewScreen(
                      context,
                      screen: const CartScreen(),
                    ),
                  },
                  icon: const Icon(
                    UniconsLine.shopping_cart,
                    size: 30.0,
                    color: secondayBackgroundColor,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
