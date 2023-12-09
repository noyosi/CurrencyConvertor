
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrencyConverter(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfffafafa),
        brightness: Brightness.light,
      ),
    );
  }
}

class CurrencyConverter extends StatefulWidget { 
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double amount = 0.0;
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double convertedAmount = 0.0;
  bool isValid = true; // to check if the entered value is valid number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Convertor',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff7c4dff),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8.0), 
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                // For user input
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    isValid = double.tryParse(value) != null;
                    if (isValid) {
                      amount = double.parse(value);
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  errorText: // showing an error message if the entered value is not a number
                      isValid 
                          ? null
                          : 'Please enter a number',
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 5.0), 
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>( // for currency selection
                    value: fromCurrency,
                    onChanged: (value) {
                      setState(() {
                        fromCurrency = value!;
                      });
                    },
                    items: ['USD', 'EUR', 'GBP', 'JPY', 'ILS', 'THB', 'SGD']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButton<String>(
                    value: toCurrency,
                    onChanged: (value) {
                      setState(() {
                        toCurrency = value!;
                      });
                    },
                    items: ['USD', 'EUR', 'GBP', 'JPY', 'ILS', 'THB', 'SGD']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0), 
            ElevatedButton(
              // Conversion logic
              onPressed: () {
                double usdToEurRate = 0.93;
                double usdToGbpRate = 0.79;
                double usdToJpyRate = 144.74;
                double usdToIlsRate = 3.70;
                double usdToThbRate = 35.20;
                double usdToSgdRate = 1.34;

                double fromRate = 1.0;
                double toRate = 1.0;

                if (fromCurrency == 'USD') {
                  fromRate = 1.0;
                } else if (fromCurrency == 'EUR') {
                  fromRate = usdToEurRate;
                } else if (fromCurrency == 'GBP') {
                  fromRate = usdToGbpRate;
                } else if (fromCurrency == 'JPY') {
                  fromRate = usdToJpyRate;
                } else if (fromCurrency == 'ILS') {
                  fromRate = usdToIlsRate;
                } else if (fromCurrency == 'THB') {
                  fromRate = usdToThbRate;
                } else if (fromCurrency == 'SGD') {
                  fromRate = usdToSgdRate;
                }

                if (toCurrency == 'USD') {
                  toRate = 1.0;
                } else if (toCurrency == 'EUR') {
                  toRate = usdToEurRate;
                } else if (toCurrency == 'GBP') {
                  toRate = usdToGbpRate;
                } else if (toCurrency == 'JPY') {
                  toRate = usdToJpyRate;
                } else if (toCurrency == 'ILS') {
                  toRate = usdToIlsRate;
                } else if (toCurrency == 'THB') {
                  toRate = usdToThbRate;
                } else if (toCurrency == 'SGD') {
                  toRate = usdToSgdRate;
                }

                setState(() {
                  convertedAmount = (amount / fromRate) * toRate;
                  convertedAmount =
                      double.parse(convertedAmount.toStringAsFixed(5));
                });
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff80ab),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(30),
                shape: CircleBorder(),
                elevation: 5,
                shadowColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Convert',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  Icon(Icons.swap_vert, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 5.0), 
            Text(
              '$convertedAmount $toCurrency', // displaying the converted amount with the selected currency
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: Image(
                image: AssetImage('assets/bottom_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}