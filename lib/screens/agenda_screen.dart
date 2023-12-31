

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';
import '../models/task.dart';
import '../widgets/buttons.dart';
import '../widgets/date_picker.dart';
import '../widgets/seperator.dart';
import 'add_task_page.dart';

List<Task> list = [
  Task(
      title: "Frontend",
      note: "Lesson 6: Flexbox",
      startTime: DateTime(2023,10,10,9),
      endTime: DateTime(2023,10,10,10),
      color: Colors.orange.value
  ),
  Task(
      title: "SQL",
      note: "Lesson 2: NoSQL Database",
      startTime: DateTime(2023,10,10,12),
      endTime: DateTime(2023,10,10,13),
      color: Colors.pink.value
  ),
  Task(
      title: "Flutter",
      note: "Lesson 2: Navigation",
      startTime: DateTime(2023,10,10,13),
      endTime: DateTime(2023,10,10,14),
      color: Colors.blue.value
  ),
];

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _selectedDate = DateTime.now();
  List<bool> _addTask = List.filled(24, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // first part
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         children: [
          //           Text(DateFormat.yMMMMd().format(DateTime.now())),
          //           Text("Today")
          //         ],
          //       ),
          //       MyButton(label: Text(
          //         "Create Task",
          //         style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
          //       ), onTap: () async {
          //         await Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => AddTaskPage()),
          //         );
          //         setState(() {});
          //       },)
          //     ],
          //   ),
          // ),
          _dateSelection(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text("OnGoing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          _tasksDisplay(list.where((task) =>
          task.startTime.year == _selectedDate.year &&
              task.startTime.month == _selectedDate.month &&
              task.startTime.day == _selectedDate.day).toList())
        ],
      ),
    );
  }

  Widget _dateSelection() {
    List<String> abbrMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    List<String> months = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    return Container(
      color: Color(0xFFF5FBFF),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => _selectedDate = _selectedDate.subtract(Duration(days: _selectedDate.day)));
                    print(_selectedDate);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.grey, size: 12,),
                        Text(abbrMonths[(_selectedDate.month + 12 - 2) % 12], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: Colors.grey),),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(months[_selectedDate.month - 1], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () => _getDateFromUser(),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white
                        ),
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        child: Icon(Icons.calendar_today_outlined, size: 15, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _selectedDate = _selectedDate.add(Duration(days: DateUtils.getDaysInMonth(_selectedDate.year, _selectedDate.month) - _selectedDate.day + 1)));
                    print(_selectedDate);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(abbrMonths[_selectedDate.month % 12], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: Colors.grey),),
                        Icon(Icons.arrow_forward, color: Colors.grey, size: 12,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: DatePicker(
              _selectedDate,
              height: 105,
              width: 64,
              initialSelectedDate: _selectedDate,
              selectionColor: Color(0xFF2FD1C5),
              deactivatedColor: Colors.white,
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),
              dayTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),
              enabledMonthText: false,
              dateChangedFromOutside: true,
              onDateChange: (date) => setState(() => _selectedDate = date),
            ),
          )
        ],
      ),
    );
  }

  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2121)
    );
    setState(() => _selectedDate = _pickerDate!);
  }

  Widget _tasksDisplay(List<Task> selectedList) {
    selectedList.sort((a, b) => a.startTime.compareTo(b.startTime));
    print(selectedList);
    List<DateTime> hours = List.generate(24, (int index) {
      return DateTime(2023, 1, 1, index, 0); // Assuming January 1, 2023 as the date
    });
    return Expanded(
        child: ListView.builder(
          itemCount: hours.length,
          itemBuilder: (context, index) {
            List<Task> curList = selectedList.where((task) => task.startTime.hour == hours[index].hour).toList();
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('ha').format(hours[index])),
                    MySeparator(color: Colors.grey, dashWidth: 2.5,),
                    Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Column(
                          children: [
                            InkWell(
                                onTap: () => setState(() {
                                  if(curList.length == 0){
                                    _addTask[index] = !_addTask[index];
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.warning_amber_rounded, color: Colors.red),
                                              SizedBox(width: 12.0,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Alert!",  style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text("There already existed a task!"),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                    );
                                  }
                                }),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // taskWidget(list[0]),
                                    for(int i = 0; i < curList.length; i++)
                                      taskWidget(curList[i]),

                                    _addTask[index] ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        addTaskButton(),
                                      ],
                                    ) : Container(height: 35,),
                                  ],
                                )
                            )
                          ]
                      ),
                    )
                  ],
                )
            );
          },
        )
    );
  }

  Widget addTaskButton() => Container(
    margin: EdgeInsets.only(top: 5),
    decoration:BoxDecoration(
      color: Color(0xFFF5FBFF),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: DottedBorder(
      color: Color.fromARGB(255, 115, 211, 255),
      dashPattern: [7, 5],
      strokeWidth: 1.5,
      borderType: BorderType.RRect,
      radius: Radius.circular(15),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
            height: 99,
            width: 284,
            color: Color(0xFFF5FBFF),
            alignment: Alignment.center,
            child: MyButton(label: Text(
              "+ Add Task",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
            ), onTap: () => Get.to(AddTaskPage()))
        ),
      ),
    ),
  );

  Widget taskWidget(Task task) => Center(
    child: Container(
      width: 252,
      height: 93,
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.fromLTRB(16,16,16,10),
      decoration: BoxDecoration(color: Color(task.color), borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text(task.note, style: TextStyle(fontSize: 12, color: Colors.white)),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateFormat('h:mm a').format(task.startTime) + " - " + DateFormat('h:mm a').format(task.endTime), style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
        ],
      ),
    ),
  );

  PreferredSizeWidget _appBar() => AppBar(
    // backgroundColor: context.theme.backgroundColor,
    leading: GestureDetector(
      onTap: (){
        // ThemeService().switchTheme();
        // notifyHelper.displayNotification(
        //   title: "Theme Changed",
        //   body: Get.isDarkMode ? "Activated Light Theme":"Activated Dark Theme",
        // );
        // notifyHelper.scheduleNotification();
      },
      child: Icon(Icons.nightlight_round, size: 20),
    ),
    actions: [
      Icon(Icons.person, size: 20,)
    ],
  );
}
