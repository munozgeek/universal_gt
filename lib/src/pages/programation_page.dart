import 'package:flutter/material.dart';
import 'package:universal_gt/src/widgets/background.dart';
import 'package:universal_gt/src/widgets/custom_bottom_navigation.dart';
import 'package:universal_gt/src/widgets/page_title.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProgramationPage extends StatefulWidget {
  const ProgramationPage({Key? key}) : super(key: key);

  @override
  _ProgramationPageState createState() => _ProgramationPageState();
}

class _ProgramationPageState extends State<ProgramationPage> {

  final url = 'https://universal.org.gt/api';

  List _getJsonProgramation = [];

  void getContact() async {
    try {
      final response = await http.get(Uri.parse(url+'/programation'));
      final jsonData = convert.jsonDecode(response.body) as List;
      setState(() {
        _getJsonProgramation = jsonData;
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
          _ProgramationBody(),
          Container(
            padding: EdgeInsets.only(top: 175),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _getJsonProgramation.length,
              itemBuilder: (context, i) {
                final data = _getJsonProgramation[i];
                //return Text("Name: ${data['name']}", style: TextStyle( fontSize: 30, color: Colors.white ));
                return Column(
                    children: [
                      Text(
                        data['title'],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['schedule'],
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 25),
                    ]
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottonNaviga(2),
    );
  }
}

class _ProgramationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Titulos
          PageTitle(const [
            Text('PROGRAMACIÓN', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white )),
            SizedBox( height: 10 ),
            Text('Listado de nuestra programación', style: TextStyle( fontSize: 18, color: Colors.white )),
          ]),
        ],
      ),
    );
  }
}

