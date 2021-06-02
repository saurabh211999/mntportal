import 'dart:developer';

import 'package:demo2/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:demo2/service/service.dart';
import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';

class Login extends StatelessWidget {
  // const Login({Key key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text('Kaar Technologies'),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 10.0),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Maintenance Portal',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(

                      child: Text('Login'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                        
                        LoginAuth data = LoginAuth(
                            Username: nameController.text.toString(),
                            Password: passwordController.text.toString()
                        );

                        Services.Login(data).then((value){
                          Map respdata = jsonDecode(value);
                          print(respdata['resp']['USERNAME'][0]);
                          if(respdata['flag'] == '0'){
                            Navigator.pushNamed(context, '/Dashboard', arguments:{ 'name' : respdata['resp']['USERNAME'][0]});
                          }
                          else{
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: 'Error Login',
                              autoCloseDuration: Duration(seconds: 5),
                            );
                          }
                        });
                      },
                    )),

              ],
            )));;
  }
}
