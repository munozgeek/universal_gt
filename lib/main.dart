import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:universal_gt/src/Handler/audio_player_handler.dart';
import 'package:universal_gt/src/pages/blogger_page.dart';
import 'package:universal_gt/src/pages/contact_page.dart';
import 'package:universal_gt/src/pages/programation_page.dart';

import 'package:universal_gt/src/widgets/background.dart';
import 'package:universal_gt/src/widgets/custom_bottom_navigation.dart';
import 'package:universal_gt/src/widgets/page_title.dart';

late AudioHandler _audioHandler;

Future<void> main() async {
  _audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Uniradio',
      initialRoute: 'homePage',
      routes: {
        'homePage': (BuildContext context ) => HomePage(),
        'contactPage': (BuildContext context ) => ContactPage(),
        'programationPage': (BuildContext context ) => ProgramationPage(),
        'bloggerPage': (BuildContext context ) => BloggerPage(),
      },
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Background(),
          _HomeBody(),
          Container(
            padding: EdgeInsets.only(top: 175),
              child:
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Show media item title
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 60),
                      child: Image(
                        image: NetworkImage('https://universal.org.gt/App/Img/User/photo-2022-01-07-08-41-04-61d85198db459.jpeg'),
                      ),
                    ),

                    // Play/pause/stop buttons.
                    StreamBuilder<bool>(
                      stream: _audioHandler.playbackState
                          .map((state) => state.playing)
                          .distinct(),
                      builder: (context, snapshot) {
                        final playing = snapshot.data ?? false;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (playing)
                              _button(Icons.stop, _audioHandler.stop)
                            else
                              _button(Icons.play_arrow, _audioHandler.play),

                          ],
                        );
                      },
                    ),
                    // Display the processing state.
                  ],
                ),
              )
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottonNaviga(0),
    );
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
    icon: Icon(iconData),
    iconSize: 64.0,
    onPressed: onPressed,
  );
}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Titulos
          PageTitle(const [
            Text('RADIO', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white )),
            SizedBox( height: 10 ),
            Text('Disfruta de nuestra programación', style: TextStyle( fontSize: 18, color: Colors.white )),
            Text('que tenemos solo para ti', style: TextStyle( fontSize: 18, color: Colors.white )),
          ]),

        ],
      ),
    );
  }
}
