import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/home_screen.dart';
import 'screens/player_setup_screen.dart';
import 'screens/cards_game_screen.dart';
import 'screens/spinner_game_screen.dart';
import 'screens/loading_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure global audio context for mobile and web compatibility
  try {
    await AudioPlayer.global.setAudioContext(AudioContext(
      android: AudioContextAndroid(
        audioFocus: AndroidAudioFocus.gain,
        usageType: AndroidUsageType.game,
        contentType: AndroidContentType.sonification,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.ambient,
        options: {
          AVAudioSessionOptions.mixWithOthers,
          AVAudioSessionOptions.defaultToSpeaker,
        },
      ),
    ));
  } catch (e) {
  }

  runApp(const PartyGamesApp());
}

class PartyGamesApp extends StatelessWidget {
  const PartyGamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Party Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B6B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => const LoadingScreen(),

        '/': (context) => const HomeScreen(),
        '/player_setup': (context) => const PlayerSetupScreen(),
        '/poker': (context) => const CardsGameScreen(),
        '/spinner': (context) => const SpinnerGameScreen(),
      },
    );
  }
}

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const GradientScaffold({super.key, required this.body, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/game_bg.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: appBar,
        body: body,
      ),
    );
  }
}
