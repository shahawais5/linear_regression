import 'dart:math';
import 'package:flutter/material.dart';

class LinearRegression {
  List<double> x;
  List<double> y;
  double slope=0;
  double intercept=0;

  LinearRegression(this.x, this.y);

  void train() {
    if (x.length != y.length) {
      throw Exception('Input data must have the same length');
    }

    double xMean = calculateMean(x);
    double yMean = calculateMean(y);

    double numerator = 0;
    double denominator = 0;

    for (int i = 0; i < x.length; i++) {
      numerator += (x[i] - xMean) * (y[i] - yMean);
      denominator += pow(x[i] - xMean, 2);
    }

    slope = numerator / denominator;
    intercept = yMean - slope * xMean;
  }

  double calculateMean(List<double> data) {
    double sum = 0;
    for (double value in data) {
      sum += value;
    }
    return sum / data.length;
  }

  double predict(double input) {
    return slope * input + intercept;
  }
}

void main() {
  runApp(LinearRegressionApp());
}

class LinearRegressionApp extends StatefulWidget {
  @override
  _LinearRegressionAppState createState() => _LinearRegressionAppState();
}

class _LinearRegressionAppState extends State<LinearRegressionApp> {
  List<double> x = [1, 2, 3, 4, 5];
  List<double> y = [2, 4, 6, 8, 10];
  LinearRegression linearRegression = LinearRegression([], []);
  double input = 6;
  double prediction = 0;

  @override
  void initState() {
    super.initState();
    linearRegression = LinearRegression(x, y);
    linearRegression.train();
    prediction = linearRegression.predict(input);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linear Regression',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Linear Regression'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Slope: ${linearRegression.slope.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Intercept: ${linearRegression.intercept.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Prediction for input $input: ${prediction.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
