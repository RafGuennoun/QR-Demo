import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class CreateQR extends StatefulWidget {
  const CreateQR({ Key? key }) : super(key: key);

  @override
  State<CreateQR> createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
    
  final TextEditingController _controller = TextEditingController();

  String data = "Hello world";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: width*0.5,
                height: width*0.5,
                child: QrImage(
                  data: data
                ),
              ),

              const SizedBox(height: 50,),

              SizedBox(
                width: width*0.8,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter something",
                    labelText: "Data",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.play_circle),
                      onPressed: (){
                        setState(() {
                          data = _controller.text;
                        });
                      }, 
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}