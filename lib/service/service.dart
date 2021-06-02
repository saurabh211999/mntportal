import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo2/Model/model.dart';

class Services {
  //Get Lsit of Notification
  static const String url = "http://192.168.0.101:3002/PMnotiflist";
  static List return_list = [];
  static Future<String> getList() async {
    final response = await http.post(
        Uri.parse(url), body: {}
    );
    return response.body;
  }

  static const String url7 = "http://192.168.0.101:3002/PMwolist";
  static List return_wo_list = [];
  static Future<String> getWOList() async {
    final response = await http.post(
        Uri.parse(url7), body: {}
    );
    return response.body;
  }

  static const String url2 = "http://192.168.0.101:3002/PMnotifCreate";
  static Future<String> createNotification(NotificationCreationModel value) async {
    print(value);
    final responseDetail = await http.post(
      Uri.parse(url2),
      body: {
        "plant" : value.plan_plant,
        "group" : value.plan_grp,
        "notif_type" : value.notif_typ,
        "task" : value.task,
        "strt_mlf_date" : value.str_mlf_date,
        "end_mlf_date" : value.end_mlf_date,
        "strt_mlf_time" : value.str_mlf_time,
        "end_mlf_time" : value.end_mlf_time,
        "mnt_plant" : value.mnt_plnt,
        "mnt_loc" : value.mnt_loc,
        "lint_text" : value.line_text,
        "cause" : value.cause,
        "brk_dwn" : value.brk_dwn,
        "notif_date" : value.notif_date,
        "reported_by" : value.reported_by,
        "equip_no" : value.equip_no
      },
    );
    // print(data);
    return responseDetail.body;
  }

  static const String url1 = "http://192.168.0.101:3002/PMnotifgetdetails";
  static List return_detail = [];
  static Future<NotifDetailMdl> getDetail(String number) async {
    // print(number);
    final responseDetail = await http.post(
        Uri.parse(url1), body: { 'number' : number }
    );
    Map data = jsonDecode(responseDetail.body);
    // print('Data');
    // print(responseDetail.body.notif_date);

    final detail = NotifDetailMdl(
        description: data['description'],
        cause: data['cause'],
        costcenter: data['cost_center'],
      end_mlf_date: data['Malenddate'],
      end_mlf_time: data['Malendtime'],
      equip: data['Equiment'],
      equip_desc: data['Equidesc'],
      func_loc: data['functional_loc'],
      maintloc: data['maintloc'],
      maintplant: data['maintplant'],
      notif_date: data['notif_date'],
      notif_number: data['notif_number'],
      notif_time: data['notif_time'],
      notif_type: data['notif_type'],
      plan_grp: data['Plangroup'],
      plan_plant: data['Planplant'],
      priority_typ: data['prioritytype'],
      reported_by: data['reportedby'],
      start_mlf_date: data['Malstrtdate'],
      start_mlf_time: data['Malstrttime'],
      task: data['task'],
      work_center: data['workcenter']
    );

    // print(detail.maintplant);
    return detail;
  }

  static const String url3 = "http://192.168.0.101:3002/PMnotifModify";
  static Future<String> ModifyNotification(NotificationModifyModel value) async {
    print(value);
    final responseDetail = await http.post(
      Uri.parse(url3),
      body: {
        "notif_type" : value.notif_typ,
        "task" : value.task,
        "mnt_plant" : value.mnt_plnt,
        "mnt_loc" : value.mnt_loc,
        "cause" : value.cause,
        "reported_by" : value.reported_by,
        "notif_number" : value.notif_number
      },
    );
    // print(data);
    return responseDetail.body;
  }

  static const String url4 = "http://192.168.0.101:3002/PMuserAuth";
  static Future<String> Login(LoginAuth value) async {
    print(value);
    final responseDetail = await http.post(
      Uri.parse(url4),
      body: {
        "Username" : value.Username,
        "Password" : value.Password
      },
    );
    // print(data);
    return responseDetail.body;
  }


  static const String url5 = "http://192.168.0.101:3002/PMwocreate";
  static Future<String> WOCreate(WorkorderCreateModel value) async {
    print(value);
    final responseDetail = await http.post(
      Uri.parse(url5),
      body: {
        "work_activity" : value.work_activity,
        "Short_text" : value.Short_Text,
        "requirement_quantity" : value.requirement_quantity,
        "pers_no" : value.pers_no,
        "Order_type" : value.Order_type,
        "notif_no" : value.notif_no,
        "material" : value.material,
        "duration_normal" : value.duration_normal,
        "description" : value.description,
        "notif_type" : value.notif_type,
        "equipment" : value.equipment,
      },
    );
    // print(data);
    return responseDetail.body;
  }

  static const String url6 = "http://192.168.0.101:3002/PMwogetdetails";
  static Future<String> WOheaderdetails(String value) async {
    print(value);
    final responseDetail = await http.post(
      Uri.parse(url6),
      body: {
        "Number" : value
      },
    );
    // print(data);
    return responseDetail.body;
  }

  static const String url8 = "http://192.168.0.101:3002/PMwoEdit";
  static Future<String> ModifyWorkOrder(WoEditmodel value) async {
    print(value);
    final responseDetail = await http.post(
      Uri.parse(url8),
      body: {
        "ShortText" : value.Short_text,
        "orderId" : value.OrderId,
        // "duration_normal" : value.Duration_normal,
        // "description" : value.Description,
      },
    );
    // print(data);
    return responseDetail.body;
  }



}



