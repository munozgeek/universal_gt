import 'dart:ui';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:universal_gt/src/widgets/background.dart';
import 'package:universal_gt/src/widgets/custom_bottom_navigation.dart';
import 'package:universal_gt/src/widgets/page_title.dart';
class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final url = 'https://universal.org.gt/api';

  List _getJsonContact = [];

  void getContact() async {
    try {
      final response = await http.get(Uri.parse(url+'/contact'));
      final jsonData = convert.jsonDecode(response.body) as List;
      setState(() {
        _getJsonContact = jsonData;
      });
    } catch (error) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getContact();
    return  Scaffold(
      body: Stack(
        children: [
          Background(),
          _ContactBody(),
          Container(
            padding: EdgeInsets.only(top: 175),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _getJsonContact.length,
              itemBuilder: (context, i) {
                final data = _getJsonContact[i];
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
                      const SizedBox(height: 35),
                      Column(
                        children: [
                          const Text(
                            'ESCRÍBENOS',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 25),
                          _ContactWidget(data['whatsapp'],data['whatsapp2'],data['email'],data['web']),

                        ],
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'REDES SOCIALES',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      _NumbersWidget(data['facebook'],data['instagram'],data['twitter'],data['youtube']),
                      const SizedBox(height: 48),
                      buildAbout(data['address']),
                      const SizedBox(height: 48),
                    ]
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottonNaviga(1),
    );
  }

  @override
  Widget buildImage(String dataImage) {
    final image = NetworkImage(dataImage);

    return Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          width: 337,
          height: 55,
        ),
      );
  }

  @override
  Widget buildAbout(String? address) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dirección',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            address!,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
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

class _ContactWidget extends StatelessWidget {
  String? _whatsapp1;
  String? _whatsapp2;
  String? _email;
  String? _web;

  _ContactWidget(this._whatsapp1,this._whatsapp2,this._email,this._web);

  @override
  Widget build(BuildContext context) {
    List <Widget> _content = [];
    if(_whatsapp1 != null){
      _content.add(buildButton(context, FontAwesomeIcons.whatsapp, 'WSP', _whatsapp1!, true));
      //_content.add(buildDivider());
    }
    if(_whatsapp2 != null){
      _content.add(buildButton(context, FontAwesomeIcons.whatsapp, 'WSP 2', _whatsapp2!, true));
      //_content.add(buildDivider());
    }
    if(_email != null){
      _content.add(buildButton(context, FontAwesomeIcons.mailBulk, 'CORREO', _email!, false));
      //_content.add(buildDivider());
    }
    if(_web != null){
      _content.add(buildButton(context, FontAwesomeIcons.globe, 'WEB', _web!, false));
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

    _launchURL(BuildContext context, url) async {
      if(await canLaunch(url)){
          await launch(url);
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Aplicación no instalada'),
              content: Text('Disculpa pero no se reconocio la aplicacion para ser ejecutada'),
            )
        );
      }

    }

    Widget buildButton(BuildContext context, IconData icon, String text, String url, bool type) =>
        MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: () {
            if(type){
              var platform = Theme.of(context).platform;
              var whatsapp = url;
              var whatsappUrlAndroid = "whatsapp://send?phone=$whatsapp&text=${Uri.encodeFull('Hola, Saludos')}";
              var whatsappUrlIos = "whatsapp://wa.me/$whatsapp/?text=${Uri.encodeFull('Hola, Saludos')}";
              if(platform == TargetPlatform.iOS){
                _launchURL(context, whatsappUrlIos);
              } else {
                _launchURL(context, whatsappUrlAndroid);
              }
            }else{
              _launchURL(context, url);
            }
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
            Text('CONTACTANOS', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white )),
            SizedBox( height: 10 ),
            Text('Información para que te contactes', style: TextStyle( fontSize: 18, color: Colors.white )),
            Text('con nosotros', style: TextStyle( fontSize: 18, color: Colors.white )),
          ]),
        ],
      ),
    );
  }
}
