import 'package:flutter/material.dart';

class VenueList extends StatefulWidget {
  @override
  _VenueListState createState() => _VenueListState();
}

class _VenueListState extends State<VenueList> {

  String _clinichosp = null;
  String _dept = null;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                key: ValueKey('clinichosp'),
                value: _clinichosp,
                isDense: true,
                // validator: (value) =>
                //     value == null ? 'Please fill in your title' : null,
                decoration: InputDecoration(
                    hoverColor: Theme.of(context).primaryColor,
                    labelText: 'Clinic / Hospital',
                    labelStyle: _clinichosp == null
                        ? null
                        : TextStyle(color: Theme.of(context).primaryColor)),
                onChanged: (String newValue) {
                  setState(() {
                    _clinichosp = newValue;
                    // phoneController.text = _dropdownValue.countryCode;
                  });
                },
                items: _dropdownTitles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(value),
                      width: 200.0,
                    ),
                  );
                }).toList(),
              ),
              if (_clinichosp.)
            ],
          )),
    ));
  }
}
