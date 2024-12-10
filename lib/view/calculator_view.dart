// import 'package:flutter/material.dart';

// class CalculatorView extends StatefulWidget {
//   const CalculatorView({super.key});

//   @override
//   State<CalculatorView> createState() => _CalculatorViewState();
// }

// class _CalculatorViewState extends State<CalculatorView> {
//   final _textController = TextEditingController();
//   List<String> lstSymbols = [
//     "C",
//     "*",
//     "/",
//     "<-",
//     "1",
//     "2",
//     "3",
//     "+",
//     "4",
//     "5",
//     "6",
//     "-",
//     "7",
//     "8",
//     "9",
//     "*",
//     "%",
//     "0",
//     ".",
//     "=",
//   ];

//   final _key = GlobalKey<FormState>();
//   int first = 0;
//   int second = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calculator App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _key,
//           child: Column(
//             children: [
//               TextFormField(
//                 textDirection: TextDirection.rtl,
//                 controller: _textController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 8.0,
//                     mainAxisSpacing: 8.0,
//                   ),
//                   itemCount: lstSymbols.length,
//                   itemBuilder: (context, index) {
//                     return ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         lstSymbols[index],
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }}

import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  final _key = GlobalKey<FormState>();

  // Variables to store the first number, second number, and the operator
  double? firstNumber;
  double? secondNumber;
  String? operator;

  // Symbols for the calculator buttons
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  // Method to handle button press
  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        // Clear the input and reset variables
        _textController.clear();
        firstNumber = null;
        secondNumber = null;
        operator = null;
      } else if (symbol == "<-") {
        // Delete the last character
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if (symbol == "=") {
        // Perform the calculation
        if (firstNumber != null && operator != null) {
          secondNumber = double.tryParse(_textController.text);
          if (secondNumber != null) {
            double? result;
            switch (operator) {
              case "+":
                result = firstNumber! + secondNumber!;
                break;
              case "-":
                result = firstNumber! - secondNumber!;
                break;
              case "*":
                result = firstNumber! * secondNumber!;
                break;
              case "/":
                result = secondNumber! != 0
                    ? firstNumber! / secondNumber!
                    : double.nan;
                break;
              case "%":
                result = firstNumber! % secondNumber!;
                break;
            }
            _textController.text = result?.toString() ?? "Error";
            firstNumber = result;
            secondNumber = null;
            operator = null;
          }
        }
      } else if ("+-*/%".contains(symbol)) {
        // Handle operator input
        if (_textController.text.isNotEmpty) {
          firstNumber = double.tryParse(_textController.text);
          operator = symbol;
          _textController.clear();
        }
      } else {
        // Append numbers or decimal points to the input
        _textController.text += symbol;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true, // Prevent manual editing
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => _onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
