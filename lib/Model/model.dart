class NotificationModel {
  final notif_no;                 //qmnum*
  final equip_no;                 //equnr*
  final notification_type;        //qmart*
  final short_text;               //qmtxt*
  final noti_date;                //qmdat*
  NotificationModel(
      {
        this.notif_no,
        this.equip_no,
        this.notification_type,
        this.short_text,
        this.noti_date
      }
      );
}

class NotificationCreationModel {
  String plan_plant;      //SA02
  String plan_grp;        //010
  String str_mlf_date;
  String end_mlf_date;
  String str_mlf_time;    //optional
  String end_mlf_time;    //optional
  String mnt_plnt;        //SA02  * not changeable
  String mnt_loc;         //Receiving * not changeable
  String notif_typ;       //m1
  String notif_date;
  String line_text;       //Description
  String reported_by;
  String cause;
  String task;
  String brk_dwn;
  String equip_no;


  NotificationCreationModel({
    required this.plan_plant,
    required this.plan_grp,
    required this.reported_by,
    required this.notif_date,
    required this.end_mlf_date,
    required this.brk_dwn,
    required this.cause,
    required this.end_mlf_time,
    required this.line_text,
    required this.mnt_loc,
    required this.mnt_plnt,
    required this.notif_typ,
    required this.str_mlf_date,
    required this.str_mlf_time,
    required this.task,
    required this.equip_no
  });
}


class NotificationModifyModel {
  String mnt_plnt;        //SA02  * not changeable
  String mnt_loc;         //Receiving * not changeable
  String notif_typ;       //m1
  String notif_number;
  String reported_by;
  String cause;
  String task;


  NotificationModifyModel({
    required this.reported_by,
    required this.cause,
    required this.mnt_loc,
    required this.mnt_plnt,
    required this.notif_typ,
    required this.task,
    required this.notif_number
  });
}


class NotifDetailMdl {
  //heade rexport
  String notif_number;
  String plan_plant;
  String plan_grp;
  String equip;
  String notif_type;
  String start_mlf_date;
  String end_mlf_date;
  String start_mlf_time;
  String end_mlf_time;
  String priority_typ;
  String notif_date;
  String notif_time;
  String reported_by;
  String maintplant;
  String maintloc;
  String work_center;
  String equip_desc;
  String cause;
  String task;
  String costcenter;
  String description;
  String func_loc;


  NotifDetailMdl({
    required this.description,
    required this.equip,
    required this.equip_desc,
    required this.costcenter,
    required this.cause,
    required this.notif_date,
    required this.notif_number,
    required this.notif_time,
    required this.notif_type,
    required this.plan_grp,
    required this.plan_plant,
    required this.priority_typ,
    required this.reported_by,
    required this.start_mlf_date,
    required this.work_center,
    required this.end_mlf_date,
    required this.end_mlf_time,
    required this.start_mlf_time,
    required this.maintloc,
    required this.maintplant,
    required this.task,
    required this.func_loc

  });

}

class LoginAuth {
  String Username;
  String Password;

  LoginAuth({
   required this.Username,
   required this.Password
});
}

class WorkorderCreateModel {
  String description;
  String equipment;
  String duration_normal;
  String material;
  String notif_no;
  String notif_type;
  String Order_type;
  String pers_no;
  String requirement_quantity;
  String Short_Text;
  String work_activity;

  WorkorderCreateModel({
   required this.notif_type,
   required this.description,
   required this.duration_normal,
   required this.equipment,
   required this.material,
   required this.notif_no,
   required this.Order_type,
   required this.pers_no,
   required this.requirement_quantity,
   required this.Short_Text,
   required this.work_activity
});

}

class WOlistModel{
  String Orderid;
  String equipment;
  String date;
  String description;
  String ordertype;

  WOlistModel({
   required this.Orderid,
   required this.equipment,
   required this.date,
   required this.description,
   required this.ordertype ,
});
}

// Model for Details
class WOheaderDetailModel{
  String order_id;
  String order_type;
  String maint_plant;
  String work_center;
  String equipment;
  String enter_date;
  String short_text;
  String notif_no;
  String func_loc;
  String plan_group;
  String costcenter;

  WOheaderDetailModel({
    required this.work_center,
    required this.short_text,
    required this.enter_date,
    required this.equipment,
    required this.func_loc,
    required this.maint_plant,
    required this.notif_no,
    required this.order_id,
    required this.order_type,
    required this.plan_group,
    required this.costcenter,
  });
}
//Sub model of WO DetailModel
class WOOperationModel{
  String control_key;
  String work_center;
  String desc;
  String duration;
  String work_activity;
  String activity_type;
  WOOperationModel({
    required this.desc,
    required this.work_center,
    required this.activity_type,
    required this.control_key,
    required this.duration,
    required this.work_activity
  });
}
//Sub model for WODetailModel - Components
class WOComponentsModel {
  String material;
  String plant;
  String mat_desc;
  String price;
  String req_date;
  String req_quants;
  WOComponentsModel({
    required this.mat_desc,
    required this.material,
    required this.plant,
    required this.price,
    required this.req_date,
    required this.req_quants,
  });
}
// Sub model for WODetailModel
class CostModel {
  String debit_type;
  String budget_type;
  String cost_plant;
  String currency;
  CostModel({
    required this.budget_type,
    required this.cost_plant,
    required this.debit_type,
    required this.currency
  });
}


class WoEditmodel{
  String Short_text;
  // String Description;
  String OrderId;
  // String Duration_normal;
  WoEditmodel({
    // required this.Description,
    // required this.Duration_normal,
    required this.OrderId,
    required this.Short_text
});

}