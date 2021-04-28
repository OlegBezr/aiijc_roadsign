import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _picker = ImagePicker();
  File _pickedImageFile;
  var _chosenClass = 'Turn';
  final _valueClasses = ['Speedlimit', 'City'];
  var _chosenValue = '';

  Future _pickImage() async {
    // if (_pickedImageFile == null) {
    //   var pickedImage = await _picker.getImage(source: ImageSource.gallery);

    //   if (pickedImage == null) {
    //     _pickImage();
    //     return;
    //   }

    //   var imageFile = File(pickedImage.path);

    //   setState(() {
    //     _pickedImageFile = imageFile;
    //   });
    // }
  }

  @override
  void initState() {
    _pickImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Road signs classifier'),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Builder(
          builder: (context) {
            if (_pickedImageFile == null) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              
                            ),
                            color: Colors.black,
                            // image: DecorationImage(
                            //   image: FileImage(_pickedImageFile),
                            //   fit: BoxFit.contain
                            // )
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: min(300, MediaQuery.of(context).size.width / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              
                            ),
                          ),
                          child: Center(
                            child: DropdownButton(
                              items: ['Speedlimit', 'Turn', 'Stop', 'City'].map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              itemHeight: 50,
                              value: _chosenClass,
                              onChanged: (value) {
                                setState(() {
                                  _chosenClass = value;
                                });
                              },
                            ),
                          ),
                        ),
                        if (_valueClasses.contains(_chosenClass))
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: min(300, MediaQuery.of(context).size.width / 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  
                                ),
                              ),
                              child: Center(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _chosenValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 40),
                        MaterialButton(
                          minWidth: min(200, MediaQuery.of(context).size.width / 3),
                          height: 50,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          color: Colors.green,
                          disabledColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide()
                          ),
                          onPressed: (_chosenClass != 'None' && !(_valueClasses.contains(_chosenClass) && _chosenValue == ''))? () {
                            _pickedImageFile = null;
                            _pickImage();
                          }: null
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          minWidth: min(200, MediaQuery.of(context).size.width / 3),
                          height: 50,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                            ),
                          ),
                          disabledColor: Colors.grey,
                          onPressed: () {
                            _pickedImageFile = null;
                            _pickImage();
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}