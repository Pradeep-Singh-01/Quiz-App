import 'package:flutter/material.dart';

class Onbaording extends StatefulWidget {
  const Onbaording({super.key});

  @override
  State<Onbaording> createState() => _OnbaordingState();
}

class _OnbaordingState extends State<Onbaording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("images/background.jpg",fit: BoxFit.cover,
            ),
          ),
          Center(child: Image.asset("images/logo.png")),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 120),
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.5,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30),

                 ),
                  child: Center(

                    child: Text("Start Playing",style: TextStyle(
                      color: Colors.black,
                      fontSize: 24, fontWeight: FontWeight.bold,
                                  ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
    )
    )
    );
  }
}



