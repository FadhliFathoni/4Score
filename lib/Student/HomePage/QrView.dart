import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample(
      {super.key,
      required this.user,
      required this.collections,
      required this.futureSnapshot});
  final User user;
  final CollectionReference collections;
  final AsyncSnapshot<QuerySnapshot<Object?>> futureSnapshot;

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  DateTime today = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: BackButton(
              color: Colors.white,
            ),
          ),
          Positioned(
            child: Center(
              child: Image(
                width: width(context) * 0.6,
                image: AssetImage("assets/images/qr_scanner.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onScanned() {
    try {
      var id = widget.futureSnapshot.data!.docs.first.id;
      var subCollection = widget.collections.doc(id).collection("absen");
      subCollection.add({"date": today});
      Navigator.pop(context);
      myDialog(context, "Absent success");
    } catch (e) {
      myDialog(context, "There's an error");
      print(e);
    }
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    var isScanned = 0;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        isScanned++;
      });
      if (isScanned == 1) {
        onScanned();
      } else {}
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
