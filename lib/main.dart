import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Permission",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                var status = await Permission.camera.status;
                if (status.isGranted) {
                  showToast("Camera access granted");
                } else if (status.isDenied) {
                  requestCameraPermission();
                }
              },
              child: const Text("Ask camera permission"),
            ),
            ElevatedButton(
              onPressed: () async {
                var status = await Permission.storage.status;
                if (status.isGranted) {
                  showToast("Storage access granted");
                } else if (status.isDenied) {
                  requestStoragePermission();
                }
              },
              child: const Text("Ask storage permission"),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(
    String message, {
    bool isError = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : null,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      showToast("Storage access denied");
    } else if (status.isDenied) {
      showToast("Storage access permanently denied");
    } else if (status.isPermanentlyDenied) {
      showToast("Storage access granted");
    } else {
      showToast("Storage access : ${status.isGranted}");
    }
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      showToast("Camera access denied");
    } else if (status.isPermanentlyDenied) {
      showToast("Camera access permanently denied");
    } else if (status.isGranted) {
      showToast("Camera access granted");
    } else {
      showToast("Camera access : ${status.isGranted}");
    }
  }
}
