import 'package:flutter/material.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Image Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase Image Provider example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseImage('gs://bucket123/otherUser123.jpg').preCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Image(
        image: FirebaseImage('gs://bucket123/userIcon123.jpg',
            shouldCache: true, // The image should be cached (default: True)
            maxSizeBytes: 3000 * 1000, // 3MB max file size (default: 2.5MB)
            cacheRefreshStrategy:
                CacheRefreshStrategy.NEVER // Switch off update checking
            ),
        width: 100,
      ),
    );
  }
}
