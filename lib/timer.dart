import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './timer-model.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration fullTime;
  int work = 30;
  int short = 5;
  int long = 10;


  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();

    int numSeconds = t.inSeconds - (t.inMinutes * 60);

    String seconds = (numSeconds < 10)
        ? '0' + numSeconds.toString()
        : numSeconds.toString();

    String formattedTime = minutes + ':' +seconds;

    return formattedTime;
  }

  Stream<TimerModel> stream() async*{
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time ;
      if(_isActive){
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / fullTime.inSeconds;
        if(_time.inSeconds <= 0){
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  void startWork(){
    _radius = 1;
    readSettings();
    _time = Duration(minutes: work, seconds: 0);
    fullTime = _time;
  }
  void shortBreak(){
    _radius = 1;
    readSettings();
    _time = Duration(minutes: short, seconds: 0);
    fullTime = _time;
  }
  void longBreak(){
    _radius = 1;
    readSettings();
    _time = Duration(minutes: long, seconds: 0);
    fullTime = _time;
  }

  void stopTimer(){
    _isActive = false;
  }

  void startTimer(){
    if(_time.inSeconds > 0)
    _isActive = true;
  }

  Future readSettings() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = (prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime'))!;
    short = (prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak'))!;
    long = (prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak'))!;

  }
}
