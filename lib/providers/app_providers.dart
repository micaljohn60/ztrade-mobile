import 'package:flutter/cupertino.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';
import 'package:omni_mobile_app/services/category/category.dart';
import 'package:omni_mobile_app/services/category/category_with_product.dart';
import 'package:omni_mobile_app/services/index/index_service.dart';
import 'package:omni_mobile_app/services/search/search_service.dart';
import 'package:provider/provider.dart';

class AppProviders{

  static List<DisposableProvider> getDisposableProviders(BuildContext context){
    return [
      Provider.of<CategoryWithProduct>(context, listen:false),
      Provider.of<IndexService>(context, listen:false),
    ];
  }

    static List<DisposableProvider> getCategoryWithProductProvider(BuildContext context) {
    return [
      Provider.of<CategoryWithProduct>(context, listen: false),
    

      //...other disposable providers
    ];
  }

  static List<DisposableProvider> searchProvider(BuildContext context){
    return [
      Provider.of<SearchService>(context, listen:false),
     
    ];
  }

    static List<DisposableProvider> getIndex(BuildContext context) {
    return [
      
      Provider.of<IndexService>(context, listen:false),

      //...other disposable providers
    ];
  }

  static void disposeCategoryWithProductProvider(BuildContext context) {
    getCategoryWithProductProvider(context).forEach((disposableProvider) {
      disposableProvider.disposeValue();
    });
  }

  static void disposeSearch(BuildContext context) {
    searchProvider(context).forEach((disposableProvider) {
      disposableProvider.disposeValue();
    });
  }

   static void disposeLogin(BuildContext context) {
    getIndex(context).forEach((disposableProvider) {
      disposableProvider.disposeValue();
    });
  }

}