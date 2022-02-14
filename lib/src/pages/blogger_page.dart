import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:universal_gt/src/widgets/background.dart';
import 'package:universal_gt/src/widgets/custom_bottom_navigation.dart';
import 'package:universal_gt/src/widgets/page_title.dart';
class BloggerPage extends StatefulWidget {
  const BloggerPage({Key? key}) : super(key: key);

  @override
  _BloggerPageState createState() => _BloggerPageState();
}

class _BloggerPageState extends State<BloggerPage> {

  final url = 'https://universal.org.gt/api';

  List _getJsonBlogger = [];

  void getBlogger() async {
    try {
      final response = await http.get(Uri.parse(url+'/obispos'));
      final jsonData = convert.jsonDecode(response.body) as List;
      setState(() {
        _getJsonBlogger = jsonData;
      });
    } catch (error) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBlogger();
  }

  @override
  Widget build(BuildContext context) {
    getBlogger();
    return  Scaffold(
      body: Stack(
        children: [
          Background(),
          _ContactBody(),
          Container(
            padding: EdgeInsets.only(top: 175),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _getJsonBlogger.length,
              itemBuilder: (context, i) {
                final data = _getJsonBlogger[i];
                //return Text("Name: ${data['name']}", style: TextStyle( fontSize: 30, color: Colors.white ));
                return Column(
                    children: [
                      Center(
                        child: Stack(
                            children: [
                              buildImage(data['image']),
                            ]
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          if(data['web'] != null) MaterialButton(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            onPressed: () {
                              launch(data['web']);
                            },
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Icon(
                                  FontAwesomeIcons.globe,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'PAGINA WEB',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      _NumbersWidget(data['facebook'],data['instagram'],data['twitter'],data['youtube']),
                      const SizedBox(height: 90),
                  ]
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottonNaviga(3),
    );
  }

  @override
  Widget buildImage(String dataImage) {
    final image = NetworkImage(dataImage);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

}

class _NumbersWidget extends StatelessWidget {
  String? _facebook;
  String? _twitter;
  String? _instagram;
  String? _youtube;

  _NumbersWidget(this._facebook,this._instagram,this._twitter,this._youtube);

  @override
  Widget build(BuildContext context) {
    List <Widget> _content = [];
    if(_facebook != null){
      _content.add(buildButton(context, FontAwesomeIcons.facebookSquare, 'FACEBOOK', _facebook!));
      //_content.add(buildDivider());
    }
    if(_instagram != null){
      _content.add(buildButton(context, FontAwesomeIcons.instagram, 'INSTAGRAM', _instagram!));
      //_content.add(buildDivider());
    }
    if(_twitter != null){
      _content.add(buildButton(context, FontAwesomeIcons.twitter, 'TWITTER', _twitter!));
      //_content.add(buildDivider());
    }
    if(_youtube != null){
      _content.add(buildButton(context, FontAwesomeIcons.youtube, 'YOUTUBE', _youtube!));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _content,
    );
  }
    Widget buildDivider() => Container(
      height: 24,
      child: VerticalDivider(),
    );

    Widget buildButton(BuildContext context, IconData icon, String text, String url) =>
        MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: () {
            launch(url);
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );

}

class _ContactBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Titulos
          PageTitle(const [
            Text('OBISPOS', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white )),
            SizedBox( height: 10 ),
            Text('Información de nuestros pastores y', style: TextStyle( fontSize: 18, color: Colors.white )),
            Text('redes sociales', style: TextStyle( fontSize: 18, color: Colors.white )),
          ]),
        ],
      ),
    );
  }
}
