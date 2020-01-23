import 'package:flutter/material.dart';

class note_details extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _NoteDetails();
  }

}
class _NoteDetails extends State<note_details>{

  static var _priority = ["High", "Low"];
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body:
          Padding(
            padding: EdgeInsets.only(top:10.0, right: 8.0, left: 5.0),
            child:ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                    items: _priority.map((String DropDownStringItem){
                      return DropdownMenuItem(
                        value: DropDownStringItem,
                        child: Text(DropDownStringItem),
                      );
                    }).toList(),
                    value: 'Low',
                    onChanged: (valueSelectedByUser){
                      setState(() {
                        debugPrint('User Selected $valueSelectedByUser');
                      });
                    },
                  ),
                ),

                //2nd element
                Padding(
               padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: title,
                  style: textStyle,
                  onChanged: (value){
                    debugPrint('kichu ashbe');
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                ) ,
               ),

                //3rd element

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: description,
                    style: textStyle,
                    onChanged: (value){
                      debugPrint('kichu ashbe');
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                    ),
                  ) ,
                ),

                //4th Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.blue,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text('Save', textScaleFactor: 1.5,),
                          onPressed: (){
                            setState(() {
                              debugPrint('save will worked soon');
                            });
                          },
                        ),
                      ),

                      Container(width:5.0),
                      Expanded(
                        child: RaisedButton(
                          color: Colors.blue,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text('Delete', textScaleFactor: 1.5,),
                          onPressed: (){
                            setState(() {
                              debugPrint('delete will worked soon');
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ),


    );
  }



}

