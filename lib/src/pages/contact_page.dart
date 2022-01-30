import 'package:flutter/material.dart';

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
          ListView.builder(
              itemCount: _getJsonBlogger.length,
              itemBuilder: (context, i) {
                final data = _getJsonBlogger[i];
                return Text("Name: ${data['name']}", style: TextStyle( fontSize: 18, color: Colors.white ));
              },
          )
        ],
      ),
      bottomNavigationBar: const CustomBottonNaviga(1),
    );
  }
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
            Text('Información de nuestros pastores y', style: TextStyle( fontSize: 18, color: Colors.white )),
            Text('redes sociales', style: TextStyle( fontSize: 18, color: Colors.white ))
          ]),
        ],
      ),
    );
  }
}
