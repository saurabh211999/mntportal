import 'package:flutter/material.dart';
import 'package:demo2/Model/model.dart';
import 'package:demo2/service/service.dart';
import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:demo2/utilities/scrollable_widget.dart';

class Workorder extends StatefulWidget {
  const Workorder({Key? key}) : super(key: key);

  @override
  _WorkorderState createState() => _WorkorderState();
}

class _WorkorderState extends State<Workorder> {

  List<WOlistModel> WoList = [];
  bool loader = true;

  void initState() {
    Services.getWOList().then((value){
      print(value);
      Map data = jsonDecode(value);
      setState(() {
        List temp_list = data["resp"];
        for(int i = 0 ; i < temp_list.length ; i++)
        {

          WoList.add(
              WOlistModel(
                  Orderid:  temp_list[i]['ORDERID'][0],
                  ordertype:  temp_list[i]['ORDER_TYPE'][0],
                  date :  temp_list[i]['REF_DATE'][0],
                  description : temp_list[i]['DESCRIPTION'][0],
                  equipment :  temp_list[i]['EQUIPMENT'][0],
              )
          );
        }
        setState(() {
          loader = false;
        });

      });
    });
  }

  String WOglobalnumber ='';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Work Order Data')),
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
          body: loader?  Center(child: CircularProgressIndicator()) : TabBarView(
            children: [
              ListView.builder(
                  itemCount: WoList.length,
                  itemBuilder: (context, index)
                  {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                              title: Text(int.parse(WoList[index].Orderid).toString()),
                              isThreeLine: true,
                              subtitle: Text(
                                  'Order Type - '+ WoList[index].ordertype + '\nDescription - ' + WoList[index].description +'\nDate : ' + WoList[index].date
                              ),
                              onTap: () {
                                // Navigator.pushNamed(context, '/notifDetails', arguments: {
                                //   'notification_no' : _notify[index].notif_no
                                // }
                                // );
                                WOglobalnumber = WoList[index].Orderid.toString();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content:Text('Copied to display'),
                                ));
                                // print(WoList[index].notif_no);
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
              WorkOrderGetDetail(WOglobalnumber),
              WorkOrderCreate()
            ],
          ),
        ),
      ),
    );
  }
}

class WorkOrderCreate extends StatefulWidget {
  const WorkOrderCreate({Key? key}) : super(key: key);

  @override
  _WorkOrderCreateState createState() => _WorkOrderCreateState();
}

class _WorkOrderCreateState extends State<WorkOrderCreate> {

  late TextEditingController  description= TextEditingController();
  late TextEditingController  shorttext = TextEditingController();
  late TextEditingController  notif_no = TextEditingController();
  late TextEditingController  notif_type = TextEditingController();
  late TextEditingController  order_type = TextEditingController();
  late TextEditingController  requirement_quantity = TextEditingController(text : '0.000');
  late TextEditingController  material = TextEditingController();
  late TextEditingController  duration_normal = TextEditingController();
  late TextEditingController  equipment = TextEditingController();
  late TextEditingController  pers_no = TextEditingController(text : '00000000');
  late TextEditingController  work_activity = TextEditingController();

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
                        controller: notif_no,
                        decoration: InputDecoration(
                          labelText: 'Notification Number',
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
                        controller: notif_type,
                        decoration: InputDecoration(
                          labelText: 'Notification Type',
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
                        controller: equipment,
                        decoration: InputDecoration(
                          labelText: 'Equipment',
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
                        controller: order_type,
                        decoration: InputDecoration(
                          labelText: 'Order Type',
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
                        controller: description,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),




                    //---------------------------- Fro Description field
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: duration_normal,
                        decoration: InputDecoration(
                          labelText: 'Duration Normal',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),

                    //---------------------------- For Cause
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: material,
                        decoration: InputDecoration(
                          labelText: 'Material',
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
                        controller: pers_no,
                        decoration: InputDecoration(
                          labelText: 'Pers Number',
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
                        controller: requirement_quantity,
                        decoration: InputDecoration(
                          labelText: 'Requirement Quantity',
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
                        controller: work_activity,
                        decoration: InputDecoration(
                          labelText: 'Work Activity',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: shorttext,
                        decoration: InputDecoration(
                          labelText: 'Short Text',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3.0))
                          ),
                        ),
                      ),
                    ),




                    TextButton(
                        onPressed: () {
                            WorkorderCreateModel data = WorkorderCreateModel(
                                work_activity : work_activity.text.toString(),
                                Short_Text:  shorttext.text.toString(),
                                requirement_quantity : requirement_quantity.text.toString(),
                                pers_no : pers_no.text.toString(),
                                material : material.text.toString(),
                                duration_normal : duration_normal.text.toString(),
                                description : description.text.toString(),
                                Order_type:  order_type.text.toString(),
                                equipment : equipment.text.toString(),
                                notif_type : notif_type.text.toString(),
                                notif_no : notif_no.text.toString()

                            );


                            Services.WOCreate(data).then((value){
                              print(value);
                              Map data = jsonDecode(value);
                              print(data['response']);
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: data['response'],
                                autoCloseDuration: Duration(seconds: 2),
                              );
                            });

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


class WorkOrderGetDetail extends StatefulWidget {

  String WOglobalnumber;
  WorkOrderGetDetail(this.WOglobalnumber);


  // const WorkOrderGetDetail({Key ? key}) : super(key: key);

  @override
  _WorkOrderGetDetailState createState() => _WorkOrderGetDetailState();
}

class _WorkOrderGetDetailState extends State<WorkOrderGetDetail> {

  bool show = false;
  bool editable = false;



  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  late Map data;

  WOheaderDetailModel header = WOheaderDetailModel(
      work_center: '',
      short_text: '',
      enter_date: '',
      equipment: '',
      func_loc: '',
      maint_plant: '',
      notif_no: '',
      order_id: '',
      order_type: '',
      plan_group: '',
      costcenter: ''
  );
  List<WOOperationModel> operation = [];
  List<WOComponentsModel> component = [];
  List<CostModel> costDetail = [];


  TextEditingController WOnumber = TextEditingController(text: '');
  TextEditingController costcenter = TextEditingController(text: '');
  TextEditingController plan_group = TextEditingController(text: '');
  TextEditingController order_type= TextEditingController(text: '');
  TextEditingController order_id = TextEditingController(text: '');
  TextEditingController notif_no = TextEditingController(text: '');
  TextEditingController maint_plant = TextEditingController(text: '');
  TextEditingController func_loc = TextEditingController(text: '');
  TextEditingController equipment = TextEditingController(text: '');
  TextEditingController enter_date = TextEditingController(text: '');
  TextEditingController short_text = TextEditingController(text: '');
  TextEditingController work_center = TextEditingController(text: '');


  @override
  void initState() {
    // TODO: implement initState
    WOnumber.text = widget.WOglobalnumber;
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
                        child: Text('Enter Work Order Number',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0, color: Colors.blue ,decoration: TextDecoration.underline),),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: WOnumber,
                            decoration: InputDecoration(
                              labelText: 'Word Order Number',
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
                            Services.WOheaderdetails(
                                WOnumber.text.toString()
                            ).then((value){
                              data = jsonDecode(value);
                              print('response');
                              print(data);
                              setState(() {
                                component = [];
                                costDetail = [];
                                operation = [];
                                show = true;
                                notif_no.text = data['notif_no'];
                                equipment.text = data['equipment'];
                                order_type.text = data['order_type'];
                                func_loc.text = data['functional_loc'];
                                work_center.text = data['workcenter'];
                                short_text.text = data['short_text'];
                                enter_date.text = data['enter_date'];
                                maint_plant.text = data['maintplant'];
                                order_id.text = data['orderid'];
                                plan_group.text = data['plangrp'];
                                costcenter.text = data['costcenter'];

                                // Taking operation detail

                                List temp_list = data['operation'];
                                for(int i = 0 ; i < temp_list.length ; i++) {
                                  operation.add(WOOperationModel(
                                      desc: temp_list[i]['DESCRIPTION'][0],
                                      work_center: temp_list[i]['WORK_CNTR'][0],
                                      activity_type: temp_list[i]['ACTTYPE'][0],
                                      control_key: temp_list[i]['CONTROL_KEY'][0],
                                      duration: temp_list[i]['DURATION_NORMAL'][0],
                                      work_activity: temp_list[i]['WORK_ACTIVITY'][0])
                                  );
                                }

                                if(data['components'] != null) {
                                  for (int i = 0; i <
                                      data['components'].length; i++) {
                                    component.add(
                                        WOComponentsModel(
                                            mat_desc: data['components'][i]['MATL_DESC'][0],
                                            material: data['components'][i]['MATERIAL'][0],
                                            plant: data['components'][i]['PLANT'][0],
                                            price: data['components'][i]['PRICE'][0],
                                            req_date: data['components'][i]['REQ_DATE'][0],
                                            req_quants: data['components'][i]['REQUIREMENT_QUANTITY'][0]
                                        )
                                    );
                                  }
                                }
                                else{
                                   component = [];
                                }


                                if(data['costdetails'] != null) {
                                  for (int i = 0; i <
                                      data['costdetails'].length; i++) {
                                    costDetail.add(
                                        CostModel(
                                            debit_type: data['costdetails'][i]['DEBIT_TYPE'][0],
                                            budget_type: data['costdetails'][i]['BUDGET_TYPE'][0],
                                            cost_plant: data['costdetails'][i]['COSTS_PLAN'][0],
                                            currency: data['costdetails'][i]['CURRENCY'][0]
                                        )
                                    );
                                  }

                                }
                                else{
                                  costDetail = [];
                                }
                              });
                               // print(header.plan_group );
                            });
                          },
                          child: Text('Submit')
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,1.0,20.0,1.0),
                        child: Divider(thickness: 2.0, color: Colors.blue),
                      ),


                      show ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: order_type,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Order Type',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: order_id,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Order Id',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: short_text,
                                  enabled: editable,
                                  decoration: InputDecoration(
                                      labelText: 'Short Text',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: notif_no,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Notification Number',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: equipment,
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
                                  controller: func_loc,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Functional Location',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: maint_plant,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Maintenance Plant',
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
                                  controller: work_center,
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
                                  controller: plan_group,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Planner Group',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: enter_date,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: 'Entry Date',
                                      border: OutlineInputBorder()
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
                                child: Text('Operation Details',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0, color: Colors.blue),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,1.0,10.0,1.0),
                                child: Divider(thickness: 2.0, color: Colors.blue),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ScrollableWidget(
                                 child: buildOperationDataTable(),
                                )
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
                                child: Text('Components Details',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0, color: Colors.blue),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,1.0,10.0,1.0),
                                child: Divider(thickness: 2.0, color: Colors.blue),
                              ),


                              component.length == 0 ? Text('No Details available') :  Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ScrollableWidget(
                                    child: buildDataTable(),
                                  )
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
                                child: Text('Cost Details',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0, color: Colors.blue),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,1.0,10.0,1.0),
                                child: Divider(thickness: 2.0, color: Colors.blue),
                              ),

                              costDetail.length == 0 ? Text('No Details available') : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ScrollableWidget(
                                    child: buildCostDataTable(),
                                  )
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

                                    WoEditmodel data = WoEditmodel(
                                        OrderId:  order_id.text.toString(),
                                        Short_text : short_text.text.toString(),

                                    );

                                    Services.ModifyWorkOrder(
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
  //Widgets for COMPONENTS -  Data table
  Widget buildDataTable() {
    final columns = ['Material', 'Plant', 'Desc', 'Req.Date', 'Req.Quant', 'Price'];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(component),
    );
  }
  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column),
  ))
      .toList();
  List<DataRow> getRows(List<WOComponentsModel> users) => users.map((WOComponentsModel comp) {
    final cells = [ int.parse(comp.material).toString(),
      comp.plant, comp.mat_desc, comp.req_date, comp.req_quants, comp.price];
    return DataRow(cells: getCells(cells));
  }).toList(); // End of table for Components
//Widgets for OPERATIONS -  Data table
  Widget buildOperationDataTable() {
    final columns = ['Cont.Key', 'Work center', 'Desc', 'Duration', 'Work Activity', 'Activity'];
    return DataTable(
      columns: getOperationColumns(columns),
      rows: getOperationRows(operation),
    );
  }
  List<DataColumn> getOperationColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column),
  ))
      .toList();
  List<DataRow> getOperationRows(List<WOOperationModel> users) => users.map((WOOperationModel comp) {
    final cells = [ comp.control_key,
      comp.work_center, comp.desc, comp.duration, comp.work_activity, comp.activity_type];
    return DataRow(cells: getCells(cells));
  }).toList(); // End of table for Operation
//Widgets for COST DETAIL -  Data table
  Widget buildCostDataTable() {
    final columns = ['Debit Type', 'Budget Type', 'Cost Plant', 'Currency',];
    return DataTable(
      columns: getCostColumns(columns),
      rows: getCostRows(costDetail),
    );
  }
  List<DataColumn> getCostColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column),
  ))
      .toList();
  List<DataRow> getCostRows(List<CostModel> users) => users.map((CostModel comp) {
    final cells = [ comp.debit_type, comp.budget_type, comp.cost_plant, comp.currency];
    return DataRow(cells: getCells(cells));
  }).toList(); // End of table for COST DETAIL
//Common for Each table
  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}


