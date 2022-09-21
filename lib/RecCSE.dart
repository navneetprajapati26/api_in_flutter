import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/studentModel.dart';
class RECcse extends StatefulWidget {
  const RECcse({Key? key}) : super(key: key);

  @override
  State<RECcse> createState() => _RECcseState();
}

class _RECcseState extends State<RECcse> {

  List<StudentModel> studentList=[];

  Future<List<StudentModel>> getStudent() async{
    final respons = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbxzb18-YsXTdkKvd4RBKeEQtgG-Kiq99dlZawPPeZ8587tWLsymFFAcVPRBCien3Rr1/exec'));
    var data = jsonDecode(respons.body.toString());
    if(respons.statusCode == 200){
      for(Map i in data){
        studentList.add(StudentModel.fromJson(i));
        //TODO "bhut kuch karna he..."
      }
      return studentList;
    }
    else{
      return studentList;
    }

  }
  @override
  Widget build(BuildContext context) {
    //print(studentList.length);
    return Scaffold(
      body: Expanded(
        child: FutureBuilder(
          future: getStudent(),
          builder: (context,snapshot){
            return ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context,index){
              return Card(
                child: Column(
                  children: [
                    //TODO : soo student data
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

class Ditals{

  String Student_Name, Email_Address, Entry;

  Ditals({ required this.Email_Address, required this.Entry, required this.Student_Name});

}

