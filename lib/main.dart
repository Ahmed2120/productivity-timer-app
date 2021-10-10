import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './setting-screen.dart';
import './timer-model.dart';
import './widgets.dart';
import './timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  void goToSettingsScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[
      PopupMenuItem(
        child: Text('Settings'),
        value: 'Settings',
      )
    ];
    timer.startWork();

    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [
            PopupMenuButton(itemBuilder: (BuildContext context){
              return menuItems.toList();
            },
            onSelected: (s){
              if(s == 'Settings')
                goToSettingsScreen(context);
            },)
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    txt: 'Work',
                    onPressed: () => timer.startWork(),
                    size: 12,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff607D8B),
                    txt: 'Short Break',
                    onPressed: () => timer.shortBreak(),
                    size: 12,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff455A64),
                    txt: 'Long Break',
                    onPressed: () => timer.longBreak(),
                    size: 12,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                      initialData: '00:00',
                      stream: timer.stream(),
                      builder: (context, snapshot) {
                        TimerModel? timer = ((snapshot.data == '00:00')
                            ? TimerModel('00:00', 1)
                            : snapshot.data) as TimerModel?;
                        return CircularPercentIndicator(
                          radius: availableWidth / 2,
                          lineWidth: 10,
                          percent: timer!.percent,
                          center: Text(
                            timer.time,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          progressColor: Color(0xff009688),
                        );
                      })),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff212121),
                    txt: 'Stop',
                    onPressed: () => timer.stopTimer(),
                    size: 12,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    txt: 'Restart',
                    onPressed: () => timer.startTimer(),
                    size: 12,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
            ],
          );
        }));
  }
}
