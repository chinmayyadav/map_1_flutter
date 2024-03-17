import 'dart:ffi';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expressionText = 'Expression';
  String solutionText = 'Solution';
  String playButtonText = 'Play';
  String solveButtonText = 'Solve';
  int totalCounts = 0;
  bool hasSolved = false;
  List<int?> previous = [0, 0];

  int? randomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  void updateExpression() {
    int? firstValue = randomInt(0, 100);
    int? secondValue = randomInt(0, 100);
    setState(() {
      expressionText = '$firstValue + $secondValue';
      solutionText = 'Solution';
      hasSolved = false; // Reset the flag when generating a new expression
      // playButtonText = 'Play';
    });
  }

  void solveExpression() {
    List<String> parts = expressionText.split(' ');
    int? firstOperand = int.tryParse(parts[0]);
    int? secondOperand = int.tryParse(parts[2]);
    if (firstOperand != null && secondOperand != null) {
      int sum = firstOperand + secondOperand;
      setState(() {
        solutionText = 'Sum: $sum';
        hasSolved = true; // Set the flag after solving for the first time
        playButtonText = 'Play Again';
        if (firstOperand != previous[0] && secondOperand != previous[1]) {
          totalCounts++;
        }
        previous[0] = firstOperand;
        previous[1] = secondOperand;
      });
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Flutter App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const SizedBox(height: 20),
//             Text(
//               expressionText,
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               solutionText,
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TotalCountsLabel(totalCounts: totalCounts),
//                 CupertinoButton(
//                   onPressed: () {
//                     updateExpression();
//                   },
//                   child: Text(playButtonText),
//                 ),
//                 const SizedBox(width: 20),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CupertinoButton(
//                   onPressed: () {
//                     solveExpression();
//                   },
//                   child: Text(solveButtonText),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TotalCountsLabel extends StatelessWidget {
//   final int totalCounts;

//   const TotalCountsLabel({Key? key, required this.totalCounts})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       'Total Counts: $totalCounts',
//       style: TextStyle(fontSize: 20),
//     );
//   }
// }

// class TotalCountsLabel extends StatelessWidget {
//   final int totalCounts;

//   const TotalCountsLabel({Key? key, required this.totalCounts})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.indigoAccent,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         'Total Counts: $totalCounts',
//         style: const TextStyle(fontSize: 18, color: Colors.white),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              expressionText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              solutionText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TotalCountsLabel(totalCounts: totalCounts),
                _buildPlayButton(),
                const SizedBox(width: 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSolveButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoButton(
        onPressed: () {
          updateExpression();
        },
        child: Text(playButtonText),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          updateExpression();
        },
        child: Text(playButtonText),
      );
    }
  }

  Widget _buildSolveButton() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoButton(
        onPressed: () {
          solveExpression();
        },
        child: Text(solveButtonText),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          solveExpression();
        },
        child: Text(solveButtonText),
      );
    }
  }
}

class TotalCountsLabel extends StatelessWidget {
  final int totalCounts;

  const TotalCountsLabel({Key? key, required this.totalCounts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Total Counts: $totalCounts',
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
