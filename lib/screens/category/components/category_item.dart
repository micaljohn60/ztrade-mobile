import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/category_detail.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/services/category/category.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  bool isHomePage;
  CategoryItems({Key key, this.isHomePage}) : super(key: key);

  String link =
      "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h71/h5d/9017844662302/1-Grocery.jpg";

  var links = [
    {
      'image' : "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h71/h5d/9017844662302/1-Grocery.jpg",
      'name' : "Groceries"
    },
     {
      'image' : "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h1d/h79/9008829464606/Beverages.jpg",
      'name' : "Drinks"
    },
     {
      'image' :     "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/ha2/h58/9073492918302/EN_Homepage_Desktop.jpg",
      'name' : "Drinks"
    },
     {
      'image' :     "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/hc8/h3f/9017369559070/Beauty & Personal Care.jpg",

      'name' : "Personal Care"
    },
     {
      'image' : "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/hc8/h3f/9017369559070/Beauty & Personal Care.jpg",
      'name' : "Skin Care"
    },
     {
      'image' :     "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h71/h5d/9017844662302/1-Grocery.jpg",

      'name' : "Body Care"
    },
     {
      'image' : "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h09/h91/9008830087198/CBC.jpg",
      'name' : "Fresh"
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    context.read<CategoryService>().fetchData;
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
      await context.read<CategoryService>().fetchData;
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
                          children: !isHomePage
                              ? value.map
                                  .sublist(0, 6)
                                  .map((e) => listItem(Colors.white, "Fresh",value.map, context,e))
                                  .toList()
                              : value.map
                                  .map((e) => listItem(Colors.white, "Fresh",value.map, context,e))
                                  .toList())
                    ],
                  );
  })
    )
    );
      
   }

  Widget listItem(Color color, String title,List data,BuildContext context,dynamic e)=> 
     Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: (){
            pushNewScreen(
                context,
                screen: CategoryDetail(title: e["name"],categoryId: e["id"].toString(),),
                
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
                Text(e["name"])
              ],
            ),
          ),
        ),
      );
  
}
