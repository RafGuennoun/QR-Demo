
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({ Key? key }) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  void reassemble() async {

    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context, width),

          Positioned(
            bottom: 15,
            child: buildResult()
          )
        ],
      )
    );
  }

  Widget buildQrView(BuildContext context, double width) => QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      cutOutSize: width*0.8,
      borderWidth: 10,
      borderLength: 25,
      borderRadius: 15,
      borderColor: Colors.blue
    ),
  );

  void onQRViewCreated(QRViewController controller){

    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream
      .listen((barcode) {
        setState(() {
          this.barcode = barcode; 
        });
      });
  }

    Widget buildResult() => Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Text(
        barcode != null 
        ? "Result = ${barcode!.code}"
        : "Scan a code",
        maxLines: 3,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
      ),
    ); 
}