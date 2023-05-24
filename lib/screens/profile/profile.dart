import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/main.dart';
import 'package:omni_mobile_app/screens/favourite/favourite.dart';
import 'package:omni_mobile_app/services/authentication/user_service.dart';
import 'package:omni_mobile_app/share/components/no_auth/no_auth.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/share/components/snackbar/snackbar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Input {
  Icon icon;
  String type;
  String text;
  String changeValue;

  Input({this.icon, this.type, this.text, this.changeValue});
}

class Profile extends StatefulWidget {
  String token;
  Profile({Key key, this.token}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Uri _privacyurl = Uri.parse('https://ztrademm.com/privacypolicy');
  final Uri _termsurl = Uri.parse('https://ztrademm.com/termsandconditions');
  ApiResponse _apiResponse = ApiResponse();
  CustomSecureStorage css = CustomSecureStorage();
  String newValue = "n";
  String profilePicture;
  File profileImage = File("");
  bool profileClick = false;
  String image = "assets/images/user.png";
  String name;
  String factoryName;

  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    setState(() {
      newValue = value;
    });
  }

  void _launchUrl() async {

    if (!await launchUrl(_privacyurl,mode: LaunchMode.externalApplication)) throw 'Could not launch $_privacyurl';
  }

  void _launchUrl2() async {
    if (!await launchUrl(_termsurl,mode: LaunchMode.externalApplication)) throw 'Could not launch $_termsurl';
  }

  @override
  void initState() {
    // TODO: implement initState

    readToken();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    context.read<UserService>().fetchData(widget.token);
    void updateProfile() async {
      final FormState form = _formKey.currentState;
      // Future<String> id = css.readValueName("sesson_id");
      if (!form.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar("Please Fix Error First"));
      } else {
        setState(() {
          // isLoading = true;
        });
        form.save();
        _apiResponse =
            await updateUser(name, factoryName, newValue, profilePicture);
      }
      if (_apiResponse.apiError == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar("Updated Successfully"));
        //  pushNewScreen(context, screen: MyHomePage());
        //  Navigator.of(context).pushReplacement(
        //    MaterialPageRoute(builder: (context) => MyHomePage()
        //    )
        //  );
      } else {
        Map data = _apiResponse.apiError;
        ScaffoldMessenger.of(context).showSnackBar(snackBar(data["message"]));
        setState(() {
          // isLoading = false;
        });
      }
    }

    void handleImage() async {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg']);
      if (result != null) {
        PlatformFile file = result.files.first;

        setState(() {
          profileClick = true;
          profileImage = File(result.files.single.path);
          profilePicture = file.path;
        });
      } else {
        // User canceled the picker
        print("Cancelled");
      }
    }

    return newValue == null
        ? NoAuth()
        : newValue == "n"
            ? Text("Loading")
            : Scaffold(
                body: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<UserService>().fetchData(widget.token);
                  },
                  child: Consumer<UserService>(
                    builder: ((context, value, child) {
                      return value.map.length == 0 && !value.error
                          ? Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: primaryBackgroundColor),
                            )
                          : value.error && newValue != null
                              ? Center(child: Text(value.errorMessage))
                              : Scaffold(
                                  body: Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color:
                                                      primaryBackgroundColor),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 60.0),
                                              child: Container(
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: profileClick
                                                              ? profileImage
                                                                          .existsSync() ==
                                                                      true
                                                                  ? FileImage(
                                                                          profileImage)
                                                                      as ImageProvider
                                                                  : AssetImage(
                                                                      image)
                                                              : NetworkImage(
                                                                  "https://appstaging.ztrademm.com/storage/profile_pictures/" +
                                                                      value.map[
                                                                              "user"]
                                                                          [
                                                                          "profile_pic"]),
                                                          fit: BoxFit.contain),
                                                      border: Border.all(
                                                          color:
                                                              secondayBackgroundColor,
                                                          width: 3.0))),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            onPressed: () => {handleImage()},
                                            child:
                                                Text("Change Profile Picture")),
                                        Form(
                                          key: _formKey,
                                          child: Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            primaryBackgroundColor)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: value
                                                        .map["user"]["email"],
                                                    //  onSaved: (value) => name = value,
                                                    // onChanged: (value) => name = value,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter Your Email",
                                                        icon: Icon(
                                                          Icons.email,
                                                          color:
                                                              primaryBackgroundColor,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      primaryBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      primaryBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            primaryBackgroundColor)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    initialValue: value
                                                        .map["user"]["name"],
                                                    onSaved: (value) =>
                                                        name = value,
                                                    onChanged: (value) =>
                                                        name = value,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter Your Name",
                                                        icon: Icon(
                                                          Icons
                                                              .account_circle_rounded,
                                                          color:
                                                              primaryBackgroundColor,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      primaryBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      primaryBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            primaryBackgroundColor)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    initialValue:
                                                        value.map["user"]
                                                            ["factory_name"],
                                                    onSaved: (value) =>
                                                        factoryName = value,
                                                    onChanged: (value) =>
                                                        factoryName = value,
                                                    decoration: InputDecoration(
                                                        hintText: value
                                                                .map["user"]
                                                            ["factory_name"],
                                                        icon: Icon(
                                                          Icons.factory_rounded,
                                                          color:
                                                              primaryBackgroundColor,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      primaryBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      primaryBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 300,
                                            height: 50,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary:
                                                        primaryBackgroundColor),
                                                onPressed: () {
                                                  updateProfile();
                                                },
                                                child: Text(
                                                  "Update",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 300,
                                            height: 50,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary:
                                                        primaryBackgroundColor),
                                                onPressed: () {
                                                  css.deleteData("token");
                                                  css.deleteData("session_id");
                                                  css.deleteData("email");
                                                  css.deleteData("username");
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                          context) {
                                                        return const MyHomePage();
                                                      },
                                                    ),
                                                    (_) => false,
                                                  );
                                                },
                                                child: Text(
                                                  "Log Out",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.of(context, rootNavigator: true)
                                            //       .pushAndRemoveUntil(
                                            //     MaterialPageRoute(
                                            //       builder: (BuildContext context) {
                                            //         return const MyHomePage();
                                            //       },
                                            //     ),
                                            //     (_) => false,
                                            //   );
                                            pushNewScreen(
                                              context,
                                              screen: Favourite(),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50.0,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color:
                                                        primaryBackgroundColor,
                                                    width: 2.0),
                                                bottom: BorderSide(
                                                    color:
                                                        primaryBackgroundColor,
                                                    width: 2.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    color:
                                                        primaryBackgroundColor,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                        "Favourites Items",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize:
                                                                    18.0)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50.0,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: primaryBackgroundColor,
                                                  width: 2.0),
                                              bottom: BorderSide(
                                                  color: primaryBackgroundColor,
                                                  width: 2.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: _launchUrl,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.document_scanner,
                                                    color:
                                                        primaryBackgroundColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "Privacy Policy",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18.0),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50.0,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: primaryBackgroundColor,
                                                  width: 2.0),
                                              bottom: BorderSide(
                                                  color: primaryBackgroundColor,
                                                  width: 2.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: _launchUrl2,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.document_scanner,
                                                    color:
                                                        primaryBackgroundColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "Terms & Conditions",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18.0),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                    }),
                  ),
                ),
              );
  }

  Widget inputLists({Icon icon, String hint, String changeValue}) {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryBackgroundColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: hint,
            // onSaved: (value) => email = value,
            onChanged: (value) => name = value,
            decoration: InputDecoration(
                hintText: hint,
                icon: icon,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: primaryBackgroundColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: primaryBackgroundColor),
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
        ),
      ),
    ));
  }
}
