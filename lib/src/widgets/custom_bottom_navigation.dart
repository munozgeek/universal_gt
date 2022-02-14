import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottonNaviga extends StatefulWidget {
  final int _currentPage;
  const CustomBottonNaviga(this._currentPage);

  @override
  State<CustomBottonNaviga> createState() => _CustomBottonNavigaState();
}

class _CustomBottonNavigaState extends State<CustomBottonNaviga> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          setState(() {
            if(index == 0){
              Navigator.pushNamed(context, 'homePage');
            } else if(index == 1){
              Navigator.pushNamed(context, 'contactPage');
            } else if(index == 2){
              Navigator.pushNamed(context, 'programationPage');
            } else {
              Navigator.pushNamed(context, 'bloggerPage');
            }
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromRGBO(151, 151, 151, 1.0),
        backgroundColor: const Color.fromRGBO(20, 21, 23, 1.0),
        currentIndex: widget._currentPage,
        items: const [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Inicio'
        ),
      BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.globeAmericas),
          label: 'Contactanos'
      ),
      BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.tasks),
          label: 'Programación'
      ),
      BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.church),
          label: 'Obispos'
      ),
    ]);
  }
}
