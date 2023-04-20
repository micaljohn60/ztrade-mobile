import 'package:flutter/material.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/providers/app_providers.dart';
import 'package:omni_mobile_app/screens/profile/profile.dart';
import 'package:omni_mobile_app/screens/search/search.dart';
import 'package:omni_mobile_app/services/search/search_suggestion.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  ApiResponse _apiResponse = ApiResponse();
  CustomSecureStorage css = CustomSecureStorage();
  String newValue = "n";

  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    setState(() {
      newValue = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    readToken();
    super.initState();
  }

  List<String> suggestons = [];
  @override
  Widget build(BuildContext context) {
    context.read<SearchSuggestionService>().fetchData(newValue);
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: primaryBackgroundColor),
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer<SearchSuggestionService>(
            builder: ((context, value, child) {
              return value.map.length == 0 && !value.error
                  ? Text("")
                  : value.error
                      ? Text(value.errorMessage)
                      : SizedBox(
                          height: 65.0,
                          width: size.width / 1.2,
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
                                    
                                    style: TextStyle(
                                        color: secondayBackgroundColor),
                                    onChanged: (value){AppProviders.disposeSearch(context);},
                                    onSubmitted: (value) async {
                                      
                                      pushNewScreen(
                                        context,
                                        screen: Search(
                                          id: newValue,
                                          text: value,
                                        ),
                                        withNavBar: true,
                                      );
                                      
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(UniconsLine.search,
                                            color: secondayBackgroundColor),
                                        labelText: "Search",
                                        labelStyle: TextStyle(
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
                                                      padding: EdgeInsets.only(
                                                          right: 60),
                                                      child: Card(
                                                          child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Text(opt),
                                                      ))));
                                            }).toList(),
                                          ))));
                                },
                              )),
                        );
            }),
          ),

          //       SizedBox(
          //         height: 65.0,
          //         width: size.width / 1.2,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             onSubmitted: (value) {
          //               pushNewScreen(
          //                 context,
          //                 screen: Search(text: value,),
          //                 withNavBar: true,
          // );
          //             },
          //             decoration: InputDecoration(
          //               prefixIcon: Icon(UniconsLine.search,color: secondayBackgroundColor),
          //               labelText: "Search",
          //               labelStyle: TextStyle(color: secondayBackgroundColor),
          //               enabledBorder: OutlineInputBorder(
          //                 borderSide: const  BorderSide(width: 2, color: secondayBackgroundColor),
          //                 borderRadius: BorderRadius.circular(15)
          //               ),
          //               focusedBorder: OutlineInputBorder(
          //                 borderSide: const  BorderSide(width: 2, color: secondayBackgroundColor),
          //                 borderRadius: BorderRadius.circular(15)
          //               )
          //             ),
          //           ),
          //         ),
          //       ),
          IconButton(
              onPressed: () => {
                    pushNewScreen(
                      context,
                      screen: Profile(token: newValue),
                    )
                  },
              icon: Icon(
                UniconsLine.user,
                size: 30.0,
                color: secondayBackgroundColor,
              ))
        ],
      ),
    );
  }
}
