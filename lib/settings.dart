import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';
  late int workTime;
  late int shortBreak;
  late int longBreak;

  late SharedPreferences prefs;

  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
   txtLong = TextEditingController();

   readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(fontSize: 24);

    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(20),
        children: [
          Text('Work', style: textStyle,),
          Text(''),
          Text(''),
          SettingButton(color: Color(0xff455A64), txt: '-', value: -1, setting: WORKTIME, size: 12, callback: updateSettings ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
            readOnly: true,
          ),
          SettingButton(color: Color(0xff009688), txt: '+', value: 1, setting: WORKTIME, size: 12, callback: updateSettings ),

          Text('Short', style: textStyle,),
          Text(''),
          Text(''),
          SettingButton(color: Color(0xff455A64), txt: '-', value: -1, setting: SHORTBREAK, size: 12, callback: updateSettings ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
            readOnly: true,
          ),
          SettingButton(color: Color(0xff009688), txt: '+', value: 1, setting: SHORTBREAK, size: 12, callback: updateSettings ),

          Text('Long', style: textStyle,),
          Text(''),
          Text(''),
          SettingButton(color: Color(0xff455A64), txt: '-', value: -1, setting: LONGBREAK, size: 12, callback: updateSettings ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
            readOnly: true,
          ),
          SettingButton(color: Color(0xff009688), txt: '+', value: 1, setting: LONGBREAK, size: 12, callback: updateSettings ),
        ],
      ),
    );
  }


  readSettings() async{
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if(workTime == null){
      await prefs.setInt(WORKTIME, 30);
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if(shortBreak == null){
      await prefs.setInt(SHORTBREAK, 30);
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if(longBreak == null){
      await prefs.setInt(LONGBREAK, 30);
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value){
    switch(key){
      case WORKTIME: {
        int? workTime = prefs.getInt(WORKTIME);
        workTime = workTime! + value;
        if(workTime >= 1 && workTime <= 180){
          prefs.setInt(WORKTIME, workTime);
          setState(() {
            txtWork.text = workTime.toString();
          });
        }
      }
      break;
      case SHORTBREAK: {
        int? short = prefs.getInt(SHORTBREAK);
        short = short! + value;
        if(short >= 1 && short <= 120){
          prefs.setInt(SHORTBREAK, short);
          setState(() {
            txtShort.text = short.toString();
          });
        }
      }
      break;
      case LONGBREAK: {
        int? long = prefs.getInt(LONGBREAK);
        long = long! + value;
        if(long >= 1 && long <= 180){
          prefs.setInt(LONGBREAK, long);
          setState(() {
            txtLong.text = long.toString();
          });
        }
      }
      break;

    }
  }
}
