import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:omni_mobile_app/screens/about/components/about_header.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final data =
      """<p style="font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(65, 65, 65); font-size: 14px; line-height: 1.6;"><span style="font-weight: bold; font-size: 36px;">About Us</span></p><p style="text-align: justify; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(65, 65, 65); font-size: 14px; line-height: 1.6;"><span style="white-space: pre-wrap;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.</span></p><p style="font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(65, 65, 65); font-size: 14px; line-height: 1.6;"><span style="white-space: pre-wrap;"><br></span></p><div style="text-align: justify; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(65, 65, 65); font-size: 14px; line-height: 1.6;">&nbsp;&nbsp;<img src="https://richtexteditor.com/imageuploads/638012291125622945-61bacda6-031f-4095-9847-6c6b0c90c360.png" style="cursor: default; max-width: 80%; height: 165px;">&nbsp;&nbsp;<img src="https://richtexteditor.com/imageuploads/638012291292497269-7b0adf29-6b03-488b-9586-0f6500ee335c.jpg" style="cursor: default; max-width: 80%; height: 165px;">&nbsp;&nbsp;<img src="https://richtexteditor.com/imageuploads/638012292009213146-c66db993-e7ad-4165-8f29-c20f3876c7fd.png" style="cursor: default; max-width: 80%; width: 242px;">&nbsp;<img src="https://richtexteditor.com/imageuploads/638012292194993653-28d5e117-77a8-4c0a-a3a6-1db17925af9e.jpg" style="cursor: default; max-width: 80%; height: 161px;"></div><p style="font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(65, 65, 65); font-size: 14px; line-height: 1.6;"><span style="font-size: 36px; font-weight: bold;">Services</span></p><p style="text-align: justify; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(65, 65, 65); font-size: 14px; line-height: 1.6;"><span style="white-space: pre-wrap;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.</span></p><ul>
</ul>
<p></p>""";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        AboutUsHeader(),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(data),
            ),
          ),
        )
      ]),
    );
  }
}
