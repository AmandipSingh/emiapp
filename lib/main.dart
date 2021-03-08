import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMI Calculator App',
          home: EMIapp(),
    )
  );
}

class EMIapp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EMIapp();
  }
}

class _EMIapp extends State<EMIapp>{

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState(){
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('EMI calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding*2),
        child: ListView(
          children: <Widget>[

            getImage(),
            
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: principalController,
                  decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g 12000',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            )),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
              keyboardType: TextInputType.number,
              controller: roiController,
              decoration: InputDecoration(
                labelText: 'Rate Of Interest',
                hintText: 'In Percentage',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            )
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding
              ),
                child: Row(
                  children: <Widget>[
                    Expanded(child: TextField(
                      keyboardType: TextInputType.number,
                      controller: termController,
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        hintText: 'In Years',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                )),

                Container(width: _minimumPadding*5,),
                
                Expanded(child: DropdownButton<String>(
                  items: _currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                  value: _currentItemSelected,

                  onChanged: (String newValueSelected){
                    _onDropDownItemSelected(newValueSelected);

                  },
                )),
              ],
            )),

            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding
                ),
                child: Row(children: <Widget>[
                  Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text('Calculate', textScaleFactor: 1.5,),
                    onPressed: () {
                      setState(() {
                        this.displayResult = _calulateTotalReturns();
                      });
                    },
                  ),
              ),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Reset', textScaleFactor: 1.5, ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                  },
                ),
              ),
              
            ],)),
            
            Padding(
              padding: EdgeInsets.all(_minimumPadding*2),
              child: Text(this.displayResult,),
            )

          ],
        )
      ),
    );
  }

  Widget getImage() {

    AssetImage assetImage = AssetImage('images/cash.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding*10),);
  }

  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calulateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal*roi*term)/100;

    String result = 'After $term Years, Your ivestment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset(){
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }

}


