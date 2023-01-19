import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/category_detail.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/services/category/category.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_providers.dart';

class CategoryItems extends StatefulWidget {
  bool isHomePage;
  List<dynamic> wishLists;
  CategoryItems({Key key, this.isHomePage,this.wishLists}) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
  
}

class _CategoryItemsState extends State<CategoryItems> {
  CustomSecureStorage css = CustomSecureStorage();
  String newValue = "n";
  
  @override
  void initState() {
    // TODO: implement initState
    readToken();
    super.initState();
    
    
  }
  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    setState(() {
      newValue = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    
    context.read<CategoryService>().fetchData(newValue);
    List<String> widgetList = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J'
    ];
    var size = MediaQuery.of(context).size;
   
    return RefreshIndicator(onRefresh: () async {
      await context.read<CategoryService>().fetchData(newValue);
    }, child: Consumer<CategoryService>(
      builder: ((context, value, child) {
        return value.map.length == 0 && !value.error
            ? Center(
                child: Loading(height: 160,)
              )
            : value.error
                ? Center(child: Text(value.errorMessage))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0, top: 15.0),
                        child: Text(
                          "Category",
                          style: GoogleFonts.poppins(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      
                      GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: size.width > 600 ? 4 : 3,
                          childAspectRatio: size.width > 600 ? 1 : 0.7,
                          shrinkWrap: true,
                          children: !widget.isHomePage
                              ? 
                              value.map["category"].length >=6 ?
                              value.map["category"]
                                  .sublist(0, 6)
                                  .map<Widget>((e) => listItem(Colors.white, "Fresh",value.map["category"], context,e,value.map["wishlist"]))
                                  .toList()
                                :
                                value.map["category"]
                                  .map<Widget>((e) => listItem(Colors.white, "Fresh",value.map["category"], context,e,value.map["wishlist"]))
                                  .toList()
                              : value.map["category"]
                                  .map<Widget>((e) => listItem(Colors.white, "Fresh",value.map["category"], context,e,value.map["wishlist"]))
                                  .toList())
                    ],
                  );
    })
    )
    );
      
   }
  // Widget listItem1(Color color, String title,List data,BuildContext context,dynamic e){
  //   print("E is here");
  //   print(e);
  // }

  Widget listItem(Color color, String title,List data,BuildContext context,dynamic e,List wishList)=> 
  
     Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: (){
            AppProviders.disposeCategoryWithProductProvider(context);
            pushNewScreen(
                context,
                screen: CategoryDetail(
                  title: e["name"],
                  categoryId: e["id"].toString(),
                  wishLists: wishList,
                  ),
                
            );
          },
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ], color: color, borderRadius: BorderRadius.circular(8.0)),
            height: 160.0,
            width: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(ZtradeAPI.categoryImageUrl+ e["image"]), fit: BoxFit.contain)),
                    height: 110.0,
                    width: 100,
                  ),
                ),
                Text(e["name"] + e["id"].toString(),textAlign: TextAlign.center,)
              ],
            ),
          ),
        ),
      );
}
