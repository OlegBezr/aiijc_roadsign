import 'dart:math';

import 'package:aiijc_roadsign/api.dart';
import 'package:aiijc_roadsign/image_data.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _textController = TextEditingController();
  ImageData _imageData;
  var _chosenClass = 'Turn';
  final _valueClasses = ['Speedlimit', 'City'];
  var _chosenValue = '';

  Future getImage() async {
    if (_imageData == null) {
      var image = await Api.getImage();

      setState(() {
        _imageData = image;
      });
    }
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
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // if (FocusScope.of(context).hasFocus)
          //   FocusScope.of(context).unfocus();
        },
        child: FutureBuilder(
          future: getImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (_imageData == null) {
                return Container(color: Colors.redAccent);
              }

              _textController.text = _chosenValue;

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
                            image: DecorationImage(
                              image: NetworkImage(_imageData.url),
                              fit: BoxFit.contain
                            )
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
                                  _chosenValue = '';
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
                                  controller: _textController,
                                  onSubmitted: (value) {
                                    print(value);
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
                            var submission = SubmissionImageData(_imageData.name, _imageData.apiKey, _chosenClass + '_' + _chosenValue, true);
                            Api.submitImage(submission);

                            // setState(() {
                            //   _imageData = null;
                            // });
                          }: null
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          minWidth: min(200, MediaQuery.of(context).size.width / 3),
                          height: 50,
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                            ),
                          ),
                          disabledColor: Colors.grey,
                          onPressed: () {
                            var submission = SubmissionImageData(_imageData.name, _imageData.apiKey, _chosenClass, false);
                            Api.submitImage(submission);

                            // setState(() {
                            //   _imageData = null;
                            // });
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