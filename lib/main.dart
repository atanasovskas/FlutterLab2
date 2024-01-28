import 'package:flutter/material.dart';
import 'package:clothes_lab2/clothes_question.dart';
import 'package:clothes_lab2/clothes_answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late String _selectedType;
  late String _selectedSize;
  late String _selectedClothes;
  TextEditingController _textFieldController = TextEditingController();

  var _questionId = 0;
  List<String> _choice = [];

  void _selectType(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _selectSize(String size) {
    setState(() {
      _selectedSize = size;
    });
  }

  void _selectClothes(String clothes) {
    setState(() {
      _selectedClothes = clothes;
    });
  }

  var questions = [
    {
      'question': "Choose category:",
      'answer': ['men', 'woman']
    },
    {
      'question': "Choose size:",
      'answer': ['XS', 'S', 'M', 'L', 'XL']
    },
    {
      'question': "Choose clothing:",
      'answer': ['shirt', 'pants', 'јacket', 'coat']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Clothes",  style: TextStyle(color: Colors.blue)),
          backgroundColor: Colors.green
        ),
        body: Column(
          children: [
            ClothesQuestion(questions[_questionId]['question'] as String),
            ...(questions[_questionId]['answer'] as List<String>)
                .map((answer) {
              return ClothesAnswer(
                    () {
                  if (_questionId == 0) {
                    _selectType(answer);
                    _questionId += 1;
                  } else if (_questionId == 1) {
                    _selectSize(answer);
                    _questionId += 1;
                  } else if (_questionId == 2) {
                    _selectClothes(answer);
                    _addDialog();
                  }
                },
                answer,
              ) ;
            }),
            SizedBox(height: 20),
            Text(
              'List of clothes:',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _choice.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        _choice[index],
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        _editClothes(_choice[index]);
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _editClothes(_choice[index]);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                            ),
                            child: Text('Edit', style: TextStyle(color: Colors.red)),
                          ),
                          SizedBox(width: 8), // Add some space between the buttons
                          ElevatedButton(
                            onPressed: () {
                              _deleteClothes(index);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                            ),
                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addDialog,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text('Add', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
  void _addDialog() {
    if (_selectedClothes != null && _selectedSize != null && _selectedType != null) {
      setState(() {
        _choice.add('$_selectedClothes, $_selectedSize, $_selectedType');
        _selectedClothes = '';
        _selectedSize = '';
        _selectedType = '';
      });
    }
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Add Clothes', style: TextStyle(color: Colors.blue)),
    //       content: TextField(
    //         controller: _textFieldController,
    //         decoration: InputDecoration(labelText: 'Enter Clothes'),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('Cancel', style: TextStyle(color: Colors.blue)),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             setState(() {
    //               String newItem = _textFieldController.text.trim();
    //               if (newItem.isNotEmpty) {
    //                 _choice.add(newItem);
    //                 _textFieldController.clear();
    //               }
    //               Navigator.pop(context);
    //             });
    //           },
    //           child: Text('Add', style: TextStyle(color: Colors.blue)),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _deleteClothes(int index) {
    setState(() {
      _choice.removeAt(index);
    });
  }

  void _editClothes(String choice) {
    _textFieldController.text = choice[0];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Clothes', style: TextStyle(color: Colors.blue)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: 'Enter new clothing type'),
              ),
              SizedBox(height: 8),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _choice[0] = _textFieldController.text;
                  _textFieldController.clear();
                  Navigator.pop(context);
                });
              },
              child: Text('Edit', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}

