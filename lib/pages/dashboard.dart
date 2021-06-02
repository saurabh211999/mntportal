import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  // const dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  late String Name = '';


  @override
  Widget build(BuildContext context) {
    Map name = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;

    Name = name['name'];
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Welcome $Name')
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                    'Maintenance Portal is designed and developed to provide easy and anywhere access through our mobile phone which has the below functionalities',
                    style: TextStyle(fontSize: 16),
                  )),
                Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: Center(child: const Text('Notification', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30.0, color: Colors.blue),))
                        ),
                        Image.asset('assests/notification.png'),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'The mobile application is designed and developed to help the Maintenance Department employee to know the Notifications assigned to him/her and the Work Orders assigned.',
                            style: TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(120.0,5.0,10.0,5.0),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                child: Text('Navigate',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)
                                  ,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context,'/Notification');
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                        title: Center(child: const Text('Work Order', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30.0, color: Colors.blue)))
                    ),
                    Image.asset('assests/workorder.jpg'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'The Mobile App has provision to create a new Work Order for the respective Notification Type, Breakdown Maintenance Order or Preventive Maintenance Order, automatically when the notification is created. ',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(120.0,5.0,10.0,5.0),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            child: Text('Navigate',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)
                              ,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context,'/WorkOrder');
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ]
    )
    )
    );





      // child:  Card(
          //   clipBehavior: Clip.antiAlias,
          //   child: Column(
          //     children: [
          //       ListTile(
          //
          //         title: const Text('Notification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
          //       ),
          //       Image.asset('assests/notification.jpg'),
          //       Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Text(
          //           ' It is used for planned maintenance activity and to notify planners',
          //           style: TextStyle(color: Colors.black.withOpacity(0.7)),
          //         ),
          //       ),
          //       ButtonBar(
          //         alignment: MainAxisAlignment.start,
          //         children: [
          //           FlatButton(
          //             textColor: const Color(0xFF6200EE),
          //             onPressed: () {
          //               // Perform some action
          //             },
          //             child: const Text('Navigate'),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),


    // );
  }
}
