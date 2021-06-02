import 'package:flutter/material.dart';
import 'package:demo2/Model/model.dart';
import 'package:demo2/service/service.dart';
import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:cool_alert/cool_alert.dart';



class NotificationData extends StatefulWidget {
  // const ({Key? key}) : super(key: key);

  @override
  _NotificationDataState createState() => _NotificationDataState();
}

class _NotificationDataState extends State<NotificationData> {

  List<NotificationModel> _notify = [];

  String globalnotifnumber = '';
  bool loader = true;

  @override
  void initState() {
    Services.getList().then((value){
      print(value);
      Map data = jsonDecode(value);
      setState(() {
        List temp_list = data["resp"];
        for(int i = 0 ; i < temp_list.length ; i++)
        {
          _notify.add(
              NotificationModel(
                  notif_no : temp_list[i]['QMNUM'][0],
                  equip_no: temp_list[i]['EQUNR'][0],
                  noti_date: temp_list[i]['QMDAT'][0],
                  notification_type: temp_list[i]['QMART'][0],
                  short_text: temp_list[i]['QMTXT'][0]
              )
          );
        }
        setState(() {
          loader = false;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Notification Data')),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff2196f3),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'List', icon: Icon(Icons.list)),
                Tab(text: 'Fetch', icon: Icon(Icons.note)),
                Tab(text: 'Create', icon: Icon(Icons.create)),
              ],
            ),
          ),
          body: loader?  Center(child: CircularProgressIndicator()) :TabBarView(
            children: [
              ListView.builder(
                  itemCount: _notify.length,
                  itemBuilder: (context, index)
                  {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                              title: Text(int.parse(_notify[index].notif_no).toString()),
                              isThreeLine: true,
                              subtitle: Text(
                                  'Description - ' + _notify[index].short_text + '\nType : ' + _notify[index].notification_type+ '\nDate : ' + _notify[index].noti_date
                              ),
                              onTap: () {

                                globalnotifnumber =  _notify[index].notif_no;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content:Text('Copied to display'),
                                ));
                                print(_notify[index].notif_no);
                              },
                              trailing: Icon(Icons.arrow_forward_ios)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0,1.0,10.0,1.0),
                          child: Divider(thickness: 2.0, color: Colors.grey),
                        ),
                      ],
                    );
                  }),
              NotifFetch(globalnotifnumber),
              Notifcreate(),
            ],
          ),
        ),
      ),
    );
  }
}

class Notifcreate extends StatefulWidget {

  const Notifcreate({Key? key}) : super(key: key);

  @override
  _NotifcreateState createState() => _NotifcreateState();
}

class _NotifcreateState extends State<Notifcreate> {

  String dropdownValue = 'None';
  late String strtMlfDate = '';
  late String endMlfDate = '';
  late String strtTime = '';
  late String endTime = '';
  late String notifDate = '';

  late TextEditingController _plant = TextEditingController(text: 'SA02');
  late TextEditingController  _group = TextEditingController(text: '010');
  late TextEditingController _reported_by = TextEditingController();
  late TextEditingController _cause = TextEditingController();
  late TextEditingController _line_text = TextEditingController();
  late TextEditingController _mnt_loc = TextEditingController(text: 'RECEIVING');
  late TextEditingController _mnt_plnt = TextEditingController(text: 'SA02');
  late TextEditingController _notif_typ = TextEditingController();
  late TextEditingController _task = TextEditingController();
  late TextEditingController _equip_no = TextEditingController();

  late final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
                      child: Text('Enter the details',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0, color: Colors.blue),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,1.0,10.0,1.0),
                      child: Divider(thickness: 2.0, color: Colors.blue),
                    ),
                    //--------------------------- For notification type
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _notif_typ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Notification Type',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),





                    //------------------------------For Plant field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _plant,
                        enabled: false,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Plant',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),


                    //------------------------------For Group Field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _group,
                        enabled: false,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Group',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),






                    // -------------------------- For Notification date field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.black45),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Notification Date',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                        onDateSelected: (DateTime value) {
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          notifDate = formatter.format(value);
                          print(notifDate);
                        },
                      ),
                    ),







                    // -------------------------- For Reported by field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _reported_by,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Reported by',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),








                    // -------------------------- For Reported by field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _equip_no,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Equip.no',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),



                    //------------------------------For Start Malfunction date field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.black45),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Malf Start Date & Time',
                        ),
                        mode: DateTimeFieldPickerMode.dateAndTime,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                        onDateSelected: (DateTime value) {
                          final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                          strtMlfDate = dateFormat.format(value);
                          print(strtMlfDate);

                          final DateFormat timeFormat = DateFormat('Hms');
                          strtTime = timeFormat.format(value);
                          print(strtTime);
                        },
                      ),

                    ),



                    //------------------------- For end Malfunction date
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.black45),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Malf End Date & Time',
                        ),
                        mode: DateTimeFieldPickerMode.dateAndTime,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                        onDateSelected: (DateTime value) {
                          final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                          endMlfDate = dateFormat.format(value);
                          print(endMlfDate);

                          final DateFormat timeFormat = DateFormat('Hms');
                          endTime = timeFormat.format(value);
                          print(endTime);
                        },
                      ),
                    ),





                    //---------------------------- Fro Description field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _line_text,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),





                    // ------------------------- For Breakdown field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [

                          Expanded(
                            child: Text('Break Down'),
                          ),

                          Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 20,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['None', 'Yes', 'No']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),




                    //---------------------------- For Cause
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _cause,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Cause',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),





                    // ------------------------- For Task
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _task,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Task',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),




                    // ------------------------- For maintenance location
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _mnt_loc,
                        // enabled: false,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Maint.Locaiton',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),




                    // ------------------------- For Maintenance Plant
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _mnt_plnt,
                        // enabled: false,
                        // initialValue: '$title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Should not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Maint.Plant',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),



                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            NotificationCreationModel data =  NotificationCreationModel(
                                plan_plant: _plant.text.toString(),
                                plan_grp: _group.text.toString(),
                                reported_by: _reported_by.text.toString(),
                                notif_date: notifDate.toString(),
                                end_mlf_date: endMlfDate.toString(),
                                brk_dwn: dropdownValue.toString(),
                                cause: _cause.text.toString(),
                                end_mlf_time: endTime.toString(),
                                line_text: _line_text.text.toString(),
                                mnt_loc: _mnt_loc.text.toString(),
                                mnt_plnt: _mnt_plnt.text.toString(),
                                notif_typ: _notif_typ.text.toString(),
                                str_mlf_date: strtMlfDate.toString(),
                                str_mlf_time: strtTime.toString(),
                                task: _task.text.toString(),
                                equip_no:  _equip_no.text.toString()
                            );

                            Services.createNotification(
                                data
                            ).then((value){
                              // print(value);
                              Map data = jsonDecode(value);
                              // print(data['resp']);
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: data['resp'],
                                autoCloseDuration: Duration(seconds: 5),
                              );
                            });
                          } else {
                            // print('Validation error');
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: 'Validation error',
                              autoCloseDuration: Duration(seconds: 5),
                            );
                          }
                        },
                        child: Text('Submit')
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}

class NotifFetch extends StatefulWidget {
  // const NotifFetch({Key? key}) : super(key: key);

  String notifnumber ;
  NotifFetch(this.notifnumber);


  @override
  _NotifFetchState createState() => _NotifFetchState();
}

class _NotifFetchState extends State<NotifFetch> {



  bool show = false;
  bool editable = false;

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  late Map data;



  TextEditingController notif_number = TextEditingController(text: '');

  TextEditingController notif_type = TextEditingController(text: '');

  TextEditingController Equipement = TextEditingController(text: '');
  TextEditingController equip_desc = TextEditingController(text: '');
  TextEditingController planplant = TextEditingController(text: '');
  TextEditingController plangrp = TextEditingController(text: '');
  TextEditingController prioritytype = TextEditingController(text: '');
  TextEditingController maintplant= TextEditingController(text: '');
  TextEditingController maintloc = TextEditingController(text: '');
  TextEditingController reportedby = TextEditingController(text: '');
  TextEditingController cause = TextEditingController(text: '');
  TextEditingController task = TextEditingController(text: '');
  TextEditingController description = TextEditingController(text: '');
  TextEditingController workcenter = TextEditingController(text: '');
  TextEditingController costcenter = TextEditingController(text: '');
  TextEditingController functionalloc = TextEditingController(text: '');
  TextEditingController Startmlfdate = TextEditingController(text: '');
  TextEditingController endmlfdate = TextEditingController(text: '');
  TextEditingController startmlftime = TextEditingController(text: '');
  TextEditingController endmlftime = TextEditingController(text: '');
  TextEditingController notifdate = TextEditingController(text: '');


  @override
  void initState() {
    // TODO: implement initState
    notif_number.text = widget.notifnumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
                        child: Text('Enter Notification Number',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0, color: Colors.blue ,decoration: TextDecoration.underline),),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: notif_number,
                            decoration: InputDecoration(
                              labelText: 'Notification Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(3.0))
                              ),
                            ),
                          ),
                        ),
                      ),


                      ElevatedButton(
                          onPressed: (){
                            Services.getDetail(
                                notif_number.text.toString()
                            ).then((value){
                              setState(() {
                                notif_type.text = value.notif_type;
                                costcenter.text = value.costcenter ;
                                workcenter.text = value.work_center;
                                equip_desc.text = value.equip_desc;
                                Equipement.text = value.equip;
                                description.text = value.description;
                                task.text = value.task ;
                                cause.text = value.cause;
                                functionalloc.text = value.func_loc;
                                reportedby.text = value.reported_by;
                                plangrp.text = value.plan_grp;
                                planplant.text = value.plan_plant;
                                maintplant.text = value.maintplant;
                                maintloc.text = value.maintloc;
                                prioritytype.text = value.priority_typ;
                                Startmlfdate.text = value.start_mlf_date;
                                endmlfdate.text = value.end_mlf_date;
                                startmlftime.text = value.start_mlf_time;
                                notifdate.text = value.notif_date;
                                endmlftime.text = value.end_mlf_time;
                              });

                              setState(() {
                                show = true ;
                              });
                            });
                          },
                          child: Text('Submit')
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,1.0,20.0,1.0),
                        child: Divider(thickness: 2.0, color: Colors.blue),
                      ),


                      show ? Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: notif_type,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Notification Type',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: description,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: Equipement,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Equipment',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: notifdate,

                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Notification Date',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: Startmlfdate,

                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Malfunction Start Date',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: endmlfdate,

                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Malfunction End Date ',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: equip_desc,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Equipment Description',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: maintplant,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Maintenance Plant',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: maintloc,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Maintenance Location',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: prioritytype,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Priority Type',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: cause,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Cause',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: task,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Task',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: reportedby,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Reported by',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: workcenter,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Work Center',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: costcenter,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Cost Center',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: functionalloc,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Functional Location',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),


                              ElevatedButton(
                                  onPressed: (){

                                    setState(() {
                                      editable = true;
                                    });
                                  },
                                  child: Text('Edit')
                              ),

                              !editable ? Container() : ElevatedButton(
                                  onPressed: (){

                                    NotificationModifyModel data = NotificationModifyModel(
                                      task: task.text.toString(),
                                      reported_by: reportedby.text.toString(),
                                      notif_number: notif_number.text.toString(),
                                      cause: cause.text.toString(),
                                      mnt_loc: maintloc.text.toString(),
                                      mnt_plnt: maintplant.text.toString(),
                                      notif_typ: notif_type.text.toString()

                                    );

                                    Services.ModifyNotification(
                                        data
                                    ).then((value){
                                      print(value);
                                      Map data = jsonDecode(value);
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        text: data['resp'],
                                        autoCloseDuration: Duration(seconds: 3),
                                      );


                                      setState(() {
                                        editable = false ;
                                      });

                                    });

                                  },
                                  child: Text('Save Changes')
                              ),


                            ],
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),

                ),
              ],
            )
        ),
      ),
    );
  }
}


