import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  String location = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              child: Text('Download'),
              onPressed: () async {
                try {
                  // Saved with this method.
                  var imageId = await ImageDownloader.downloadImage("https://avatars.githubusercontent.com/u/45892408?v=4");
                  if (imageId == null) {
                    return;
                  }
                  // Below is a method of obtaining saved image information.
                  var fileName = await ImageDownloader.findName(imageId);
                  var path = await ImageDownloader.findPath(imageId);
                  var size = await ImageDownloader.findByteSize(imageId);
                  var mimeType = await ImageDownloader.findMimeType(imageId);
                  setState(() {
                    location = path.toString();
                    print("zein"+location);
                  });
                } on PlatformException catch (error) {
                  print("zein_"+error.message.toString());
                }
              },
            ),
            if (location.isNotEmpty)
              Image.file(
                File(location),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
