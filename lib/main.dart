import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final options = [
    "C",
    "%",
    "*",
    "/",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "=",
    "0",
    "."
  ];

  var operation = "";
  var result = 0.0;
  var a;
  var b;
  var currentOp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 15, right: 20, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade800, width: 4),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24, left: 24),
                    child: Text(
                      operation,
                      style: GoogleFonts.pressStart2p(
                        textStyle: TextStyle(
                          color: Colors.greenAccent.shade400,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: 18,
                    itemBuilder: (BuildContext context, int index) =>
                        ElevatedButton(
                      style: index == 16
                          ? ElevatedButton.styleFrom(
                              shadowColor: Colors.greenAccent.shade400,
                              elevation: 7,
                              shape: StadiumBorder(),
                              side: BorderSide(
                                  color: Colors.deepPurple.shade800, width: 8),
                            )
                          : index == 15
                              ? ElevatedButton.styleFrom(
                                  shadowColor: Colors.greenAccent.shade400,
                                  elevation: 7,
                                  shape: StadiumBorder(),
                                  side: BorderSide(
                                      color: Colors.deepPurple.shade800,
                                      width: 8),
                                )
                              : ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  shadowColor: Colors.greenAccent.shade400,
                                  elevation: 7,
                                  side: BorderSide(
                                      color: Colors.deepPurple.shade800,
                                      width: 7),
                                ),
                      onPressed: () {
                        final op = options[index];
                        if (options[index] == '=') {
                          operation = separatesFunctionIntoSmallerFunctions(
                              operation, '*', '/');
                          operation = separatesFunctionIntoSmallerFunctions(
                              operation, '-', '+');
                        } else {
                          operation += options[index];
                        }

                        switch (op) {
                          case "C":
                            {
                              a = null;
                              b = null;
                              result = 0.0;
                              operation = "";
                              break;
                            }
                          case "+":
                            {
                              currentOp = op;
                              break;
                            }
                          case "-":
                            {
                              currentOp = op;
                              break;
                            }
                          case "*":
                            {
                              currentOp = op;
                              break;
                            }
                          case "/":
                            {
                              currentOp = op;
                              break;
                            }
                          case "=":
                            {
                              break;
                            }
                        }

                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple),
                        child: Text(
                          options[index],
                          style: GoogleFonts.pressStart2p(
                            textStyle: TextStyle(
                                color: (index == 15
                                    ? Colors.green.shade300
                                    : Colors.lightGreenAccent.shade400),
                                fontSize: 33),
                          ),
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) {
                      if (index == 15) {
                        return StaggeredTile.count(1, 2);
                      } else if (index == 16) {
                        return StaggeredTile.count(2, 1);
                      } else {
                        return StaggeredTile.count(1, 1);
                      }
                    },
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

separatesFunctionIntoSmallerFunctions(text, op1, op2) {
  // RegExp para verificar se a string ?? um numero
  final onlyNumbers = RegExp('[0-9]');

  // Booleano para armazenar se j?? encontrou o operador.
  bool findOperator = false;
  // Booleano para verificar continua while continua.
  bool keepLooking = true;

  while (keepLooking) {
    // Seta o booleano falso. Necess??rio para caso n??o encontre nenhum dos
    // operadores o while n??o entre em loop.
    keepLooking = false;
    // Armazena a operacao numerica a ser executada.
    String operation = '';
    // Armazena qual o operador da fun????o a ser executada.
    String operator = '';
    // Loop para percorrer a string
    for (int i = 0; i < text.length; i++) {
      // Verifica se a letra ?? um dos operadores pesquisados e se o primeiro operador j?? foi encontrado.
      // Caso positivo setamos a vari??vel keepLooking como true.
      // Isso faz com que ap??s a execu????o do for o loop se mantenha e continue a busca dos pr??ximos operadores.
      // Nessa parte tamb??m setamos qual operador foi lido.
      // Setar que um operador foi encontrado ?? necess??rio para que possamos parar a busca pelo segundo n??mero
      // no pr??ximo operador.
      if ((text[i] == op1 || text[i] == op2) && !findOperator) {
        operation += text[i];
        keepLooking = true;
        findOperator = true;
        if (text[i] == op1) operator = op1;
        if (text[i] == op2) operator = op2;
        // Verifica se a letra ?? um n??mero
      } else if (onlyNumbers.hasMatch(text[i])) {
        operation += text[i];
        // Caso j?? tenhamos encontrado o primeiro operador verificamos se a proxima letra tambem ?? um numero.
        // Caso positivo continuamos o For.
        // Caso negativo paramos a execus??o do for ?? enviamos chamamos a funcao calculateString
        // A funcao calculateString pega uma excus??o de apenas uma operacao e retonar o seu resutado.
        // Com isso fazemos um replace da operac??o com o resultado.
        if (findOperator &&
            ((i + 1 == text.length) || !onlyNumbers.hasMatch(text[i + 1]))) {
          text = text.replaceAll(
              operation, calculateString(operation, operator).toString());
          operation = '';
          findOperator = false;
          break;
        }
      } else {
        operation = "";
      }
    }
  }
  return text;
}

calculateString(text, op) {
  List<String> textArray = [];
  if (op == '*') {
    textArray = text.split(op);
    return int.parse(textArray[0]) * int.parse(textArray[1]);
  } else if (op == '/') {
    textArray = text.split(op);
    return int.parse(textArray[0]) / int.parse(textArray[1]);
  } else if (op == '+') {
    textArray = text.split(op);
    return int.parse(textArray[0]) + int.parse(textArray[1]);
  } else if (op == '-') {
    textArray = text.split(op);
    return int.parse(textArray[0]) - int.parse(textArray[1]);
  }
}
