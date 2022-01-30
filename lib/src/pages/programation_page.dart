import 'package:flutter/material.dart';
import 'package:universal_gt/src/widgets/background.dart';
import 'package:universal_gt/src/widgets/custom_bottom_navigation.dart';
import 'package:universal_gt/src/widgets/page_title.dart';

class ProgramationPage extends StatefulWidget {
  const ProgramationPage({Key? key}) : super(key: key);

  @override
  _ProgramationPageState createState() => _ProgramationPageState();
}

class _ProgramationPageState extends State<ProgramationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Background(),
          _ProgramationBody(),
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

