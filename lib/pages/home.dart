import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:triviaapp/pages/service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool music = true,
      geography = false,
      fooddrink = false,
      sciencenature = false,
      entertainment = false,
      answernow = false;
  // String? question, answer;
  String question = "Loading...", answer = "Loading...";

  List<String> option = [];
  @override
  void initState() {
    super.initState();
    Restoption();
    fetchQuiz("music");

  }

  Future<void> fetchQuiz(String category) async {
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/trivia'),
      headers: {'Content-Type': 'application/json', 'X-Api-Key': APIKEY},
    );
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> quiz = jsonData[0];
        // question = quiz["question"];
        // answer = quiz["answer"];
        question = quiz["question"] ?? "No question available";
        answer = quiz["answer"] ?? "No answer available";
        option.add(answer);
        option.shuffle();
      }
      setState(() {});
    }
  }




  // Future<void> fetchQuiz(String category) async {
  //   setState(() {
  //     question = "Loading..."; // Indicate loading state more clearly
  //     answer = "Loading...";
  //     option.clear(); // Clear old options before fetching new ones
  //   });
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://api.api-ninjas.com/v1/trivia?category=$category'), // Include category in query
  //       headers: {'Content-Type': 'application/json', 'X-Api-Key': APIKEY},
  //     );
  //     print('Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonData = jsonDecode(response.body);
  //       if (jsonData.isNotEmpty) {
  //         Map<String, dynamic> quiz = jsonData[0];
  //         question = quiz["question"] ?? "No question available";
  //         answer = quiz["answer"] ?? "No answer available";
  //         option.add(answer); // Add the correct answer first
  //         // Restoption will add other random words
  //       } else {
  //         question = "No trivia found for this category.";
  //         answer = "";
  //       }
  //     } else {
  //       question = "Error fetching trivia: ${response.statusCode}";
  //       answer = "";
  //       // Potentially show a user-facing error message
  //     }
  //   } catch (e) {
  //     print("Error in fetchQuiz: $e");
  //     question = "An error occurred. Please try again.";
  //     answer = "";
  //     // Potentially show a user-facing error message
  //   }
  //   // Ensure Restoption is called after fetching the actual answer
  //   if (answer.isNotEmpty && answer != "No answer available" && answer != "Loading...") {
  //     await Restoption(); // This also calls setState
  //   } else {
  //     setState(() {}); // If Restoption isn't called, ensure UI updates
  //   }
  // }







  Future<void> Restoption() async {
    // option.clear();
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/randomword'),
      headers: {'Content-Type': 'application/json', 'X-Api-Key': RANDOMKEY},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        String word = jsonData["word"].toString();
        option.add(word);
      }
      if (option.length < 4) {
        Restoption();
      }

      print(option);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          option.length != 4
              ? Center(child: CircularProgressIndicator())
              : Container(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "images/background.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 90.0, left: 20.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                music
                                    ? Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 5.0,
                                        child: Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,

                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Music",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap: () async {
                                        music = true;
                                        geography = false;
                                        fooddrink = false;
                                        sciencenature = false;
                                        entertainment = false;
                                        option = [];
                                        await Restoption();
                                        await fetchQuiz("music");
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 120,
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "music",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                geography
                                    ? Container(
                                      margin: EdgeInsets.only(right: 20),

                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 3.0,
                                        child: Container(
                                          width: 170,

                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "geography",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap: () async {
                                        music = false;
                                        geography = true;
                                        fooddrink = false;
                                        sciencenature = false;
                                        entertainment = false;
                                        await Restoption();
                                        await fetchQuiz("geography");
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 170,
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "geography",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                fooddrink
                                    ? Container(
                                      margin: EdgeInsets.only(right: 20),

                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 3.0,
                                        child: Container(
                                          width: 170,

                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "fooddrink",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap: () async {
                                        music = false;
                                        geography = false;
                                        fooddrink = true;
                                        sciencenature = false;
                                        entertainment = false;
                                        await Restoption();
                                        await fetchQuiz("fooddrink");
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 170,
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "fooddrink",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                sciencenature
                                    ? Container(
                                      margin: EdgeInsets.only(right: 20),

                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 3.0,
                                        child: Container(
                                          width: 200,

                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "sciencenature",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap: () async {
                                        music = false;
                                        geography = false;
                                        fooddrink = false;
                                        sciencenature = true;
                                        entertainment = false;
                                        await Restoption();
                                        await fetchQuiz("sciencenature");
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 200,
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "sciencenature",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                entertainment
                                    ? Container(
                                      margin: EdgeInsets.only(right: 20),

                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 3.0,
                                        child: Container(
                                          width: 170,

                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "entertainment",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    : GestureDetector(
                                      onTap: () async {
                                        music = false;
                                        geography = false;
                                        fooddrink = false;
                                        sciencenature = false;
                                        entertainment = true;
                                        await Restoption();
                                        await fetchQuiz("entertainment");
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 170,
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "entertainment",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    question.toString(),
                                    // "Who was the first president of the United States?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                GestureDetector(
                                  onTap: () {
                                    answernow = true;
                                    setState(() {});
                                  },
                                  child: Container( // first option
                                    height: 60,
                                    margin: EdgeInsets.only(left: 20, right: 20,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: answernow?answer==option[0].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        )?Colors.green : Colors.red:Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: Center(
                                      child: Text(
                                        option[0].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        ),
                                        // option[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    answernow = true;
                                    setState(() {});
                                  },
                                  child: Container( //second option
                                    height: 60,
                                    margin: EdgeInsets.only(left: 20, right: 20,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: answernow?answer==option[1].replaceAll(
                                          RegExp(r'[\[\]]'),
                                      "",
                                    )?Colors.green : Colors.red:Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: Center(
                                      child: Text(
                                        option[1].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: (){
                                    answernow = true;
                                    setState(() {

                                    });
                                  },
                                  child: Container( //third option
                                    height: 60,
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: answernow?answer==option[3].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        )?Colors.green : Colors.red:Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: Center(
                                      child: Text(
                                        option[3].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        ) ,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    answernow = true;
                                    setState(() {});
                                  },
                                  child: Container(// last option
                                    height: 60,
                                    margin: EdgeInsets.only(left: 20, right: 20,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: answernow?answer==option[2].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        )?Colors.green : Colors.red:Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: Center(
                                      child: Text(
                                        option[2].replaceAll(
                                          RegExp(r'[\[\]]'),
                                          "",
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
