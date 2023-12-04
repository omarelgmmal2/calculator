import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  List<String> symbols = [
    "C",
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "+",
    "3",
    "2",
    "1",
    "-",
    ".",
    "0",
    "Ans",
    "=",
  ];

  String inPut = "";
  String outPut = "";

  Color? myBackGroundColor(String color) {
    if (color == "C") {
      return Colors.teal.shade300;
    } else if (color == "Del") {
      return Colors.red.shade200;
    } else if (color == "%" ||
        color == "/" ||
        color == "*" ||
        color == "+" ||
        color == "-" ||
        color == "=") {
      return Colors.blue.shade400;
    } else {
      return Colors.grey.shade300;
    }
  }

  Color? myTextColor(String color) {
    if (color == "C" ||
        color == "%" ||
        color == "/" ||
        color == "*" ||
        color == "+" ||
        color == "-" ||
        color == "=" ||
        color == "Del") {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Calculator",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                inPut,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                outPut,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent.shade400,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (symbols[index] == "C") {
                      inPut = "";
                      outPut = "";
                      setState(() {});
                    } else if (symbols[index] == "Del") {
                      inPut = inPut.substring(0, inPut.length - 1);
                      setState(() {});
                    } else if (symbols[index] == "Ans") {
                      inPut = outPut;
                      outPut = "";
                      setState(() {});
                    } else if (symbols[index] == "%" ||
                        symbols[index] == "/" ||
                        symbols[index] == "*" ||
                        symbols[index] == "+" ||
                        symbols[index] == "-") {
                      if (inPut.endsWith("%") ||
                          inPut.endsWith("/") ||
                          inPut.endsWith("*") ||
                          inPut.endsWith("+") ||
                          inPut.endsWith("-")) {
                        null;
                      } else {
                        inPut += symbols[index];
                        setState(() {});
                      }
                      if (inPut.startsWith("%") ||
                          inPut.endsWith("/") ||
                          inPut.endsWith("*") ||
                          inPut.endsWith("+") ||
                          inPut.endsWith("-")) {
                        null;
                      } else {
                        inPut += symbols[index];
                        setState(() {});
                      }
                    } else if (symbols[index] == "=") {
                      Expression exp = Parser().parse(inPut);
                      double result = exp.evaluate(
                        EvaluationType.REAL,
                        ContextModel(),
                      );
                      outPut = result.toString();
                      setState(() {});
                    } else {
                      inPut += symbols[index];
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: myBackGroundColor(
                        symbols[index],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      symbols[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: myTextColor(
                          symbols[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: symbols.length,
            ),
          ),
        ],
      ),
    );
  }
}
