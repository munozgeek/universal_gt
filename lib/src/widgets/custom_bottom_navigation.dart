import 'package:flutter/material.dart';

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
            } else {
              Navigator.pushNamed(context, 'programationPage');
            }
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromRGBO(151, 151, 151, 1.0),
        backgroundColor: const Color.fromRGBO(20, 21, 23, 1.0),
        currentIndex: widget._currentPage,
        items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio'
        ),
      BottomNavigationBarItem(
          icon: Icon(Icons.perm_contact_cal),
          label: 'Contactanos'
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play),
          label: 'Programación'
      ),
    ]);
  }
}
