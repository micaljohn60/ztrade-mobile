import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/services/category/category.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  bool isHomePage;
  CategoryItems({Key key, this.isHomePage}) : super(key: key);

  String link =
      "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h71/h5d/9017844662302/1-Grocery.jpg";

  @override
  Widget build(BuildContext context) {
    context.read<Category>().fetchData;
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
      await context.read<Category>().fetchData;
    }, child: Consumer<Category>(
      builder: ((context, value, child) {
        return value.map.length == 0 && !value.error
            ? Center(
                child: Loading()
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
                              ? widgetList
                                  .sublist(0, 6)
                                  .map((e) => listItem(Colors.white, "Fresh"))
                                  .toList()
                              : widgetList
                                  .map((e) => listItem(Colors.white, "Fresh"))
                                  .toList())
                    ],
                  );
  })
    )
    );
      
  }

  Widget listItem(Color color, String title) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0)
          ], color: color, borderRadius: BorderRadius.circular(13.0)),
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
                          image: NetworkImage(link), fit: BoxFit.cover)),
                  height: 110.0,
                  width: 100,
                ),
              ),
              Text(title)
            ],
          ),
        ),
      );
}
