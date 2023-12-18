import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/hive_constant.dart';
import 'package:omni_mobile_app/persistent/cart_data_dao/cart_data_dao.dart';
import 'package:omni_mobile_app/providers/add_to_cart/add_to_cart_provider.dart';
import 'package:omni_mobile_app/providers/check_out_provider/check_out_provider.dart';
import 'package:omni_mobile_app/screens/auth/authenticate.dart';
import 'package:omni_mobile_app/screens/auth/login.dart';
import 'package:omni_mobile_app/screens/auth/register.dart';
import 'package:omni_mobile_app/screens/splash_screen/splash_screen.dart';
import 'package:omni_mobile_app/services/aboutus/aboutus_service.dart';
import 'package:omni_mobile_app/services/authentication/user_service.dart';
import 'package:omni_mobile_app/services/brand/brand.dart';
import 'package:omni_mobile_app/services/brand/store_with_products.dart';
import 'package:omni_mobile_app/services/category/category.dart';
import 'package:omni_mobile_app/services/category/category_with_product.dart';
import 'package:omni_mobile_app/services/index/index_service.dart';
import 'package:omni_mobile_app/services/index/index_service_auth.dart';
import 'package:omni_mobile_app/services/product/product.dart';
import 'package:omni_mobile_app/services/product/related_products.dart';
import 'package:omni_mobile_app/services/search/search_service.dart';
import 'package:omni_mobile_app/services/search/search_suggestion.dart';
import 'package:omni_mobile_app/services/slider/carousel_slider_service.dart';
import 'package:omni_mobile_app/services/wishlist_service/user_wishlist_service.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexService()),
        ChangeNotifierProvider(create: (context) => IndexServiceAuth()),
        ChangeNotifierProvider(create: (context) => CategoryService()),
        ChangeNotifierProvider(create: (context) => CarouselSliderService()),
        ChangeNotifierProvider(create: (context) => ProductService()),
        ChangeNotifierProvider(create: (context) => BrandService()),
        ChangeNotifierProvider(create: (context) => StoreWithProduct()),
        ChangeNotifierProvider(create: (context) => CategoryWithProduct()),
        ChangeNotifierProvider(create: (context) => SearchService()),
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => UserWishListService()),
        ChangeNotifierProvider(create: (context) => AboutUsService()),
        ChangeNotifierProvider(create: (context) => SearchSuggestionService()),
        ChangeNotifierProvider(create: (context) => RelatedProductService()),
        //for adding new cart
        ChangeNotifierProvider(
          create: (context) => AddToCartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckOutProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: myNavigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          'login': (context) => const Authenticate(),
          'register': (context) => const Register()
        },
      ),
    );
  }
}
