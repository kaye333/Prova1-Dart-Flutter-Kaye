import 'package:flutter/material.dart';
import 'RadioButton.dart';

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova 1: Calculadora Dart/Flutter',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const Calculate(),
    );
  }
}

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  State<Calculate> createState() {
    return CalculateState();
  }
}

class CalculateState extends State<Calculate> {
  String campoNumero1 = '';
  String campoNumero2 = '';
  String campoResultado = '';
  String op = '+';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  String? buildValidacao(value) {
    final validateNum = num.tryParse(value);
    if (validateNum == null) {
      return '"$value" não é aceito!';
    }
    return null;
  }

  Widget buildCampoNumero1() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: buildValidacao,
      onSaved: (value) => setState(() => campoNumero1 = value!),
    );
  }

  Widget buildCampoNumero2() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: buildValidacao,
      onSaved: (value) => setState(() => campoNumero2 = value!),
    );
  }

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => op = value!);
  }

  Widget buildCampoRadio() {
    return Column(
      children: [
        RadioOption<String>(
          value: '+',
          groupValue: op,
          onChanged: _valueChangedHandler(),
          label: '+',
          text: 'Adição',
        ),
        RadioOption<String>(
          value: '-',
          groupValue: op,
          onChanged: _valueChangedHandler(),
          label: '-',
          text: 'Subtração',
        ),
        RadioOption<String>(
          value: '*',
          groupValue: op,
          onChanged: _valueChangedHandler(),
          label: '*',
          text: 'Multiplicação',
        ),
        RadioOption<String>(
          value: '/',
          groupValue: op,
          onChanged: _valueChangedHandler(),
          label: '/',
          text: 'Divisão',
        ),
      ],
    );
  }

  Widget buildCampoResultado() {
    return TextFormField(
      enabled: false,
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }

  String result() {
    double n1 = double.parse(campoNumero1);
    double n2 = double.parse(campoNumero2);
    // ignore: prefer_typing_uninitialized_variables
    var result;
    if (op == '+') {
      result = n1 + n2;
    } else if (op == '-') {
      result = n1 - n2;
    } else if (op == '*') {
      result = n1 * n2;
    } else if (op == '/') {
      result = n1 / n2;
    }
    return result.toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Prova 1: Calculadora Dart/Flutter")),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(200.0, 8.0, 40.0, 8.0),
                        child: Expanded(
                          child: Text(
                            'Número 1:',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 8.0, 300.0, 8.0),
                          child: buildCampoNumero1(),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(200.0, 8.0, 40.0, 8.0),
                        child: Expanded(
                          child: Text(
                            'Número 2:',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 8.0, 300.0, 8.0),
                          child: buildCampoNumero2(),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      const Text(
                        'Escolha a operação desejada:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildCampoRadio(),
                      const SizedBox(height: 50),
                      ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.lightBlue.shade700,
                            onSurface: Colors.black,
                            elevation: 20,
                            shadowColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Executar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            final isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              _formKey.currentState!.save();
                              setState(() {
                                controller.text = result();
                              });
                            }
                          }),
                      const SizedBox(height: 50),
                      Row(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(200.0, 8.0, 40.0, 8.0),
                            child: Expanded(
                              child: Text(
                                'Resultado:',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 300.0, 8.0),
                              child: buildCampoResultado(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
}
