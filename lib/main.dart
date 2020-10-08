import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calduladora de IMC',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

String _infoText = 'Insira Seus Dados';
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _HomePageState extends State<HomePage> {
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = 'Informe Seus Dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _imcCalculator() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 16) {
        _infoText = 'Magreza Grave (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 16 && imc < 17) {
        _infoText = 'Magreza Moderada (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 17 && imc < 18.5) {
        _infoText = 'Magreza Leve (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = 'Saudável (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 30 && imc < 35) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 35 && imc < 40) {
        _infoText =
            'Obesidade Grau II - Severa (${imc.toStringAsPrecision(4)})';
      } else if (imc > 40) {
        _infoText =
            'Obesidade Grau III - Mórbida (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  //Objetos para calcular os valores digitados
  //  Controlador 1: Responsável pelo controle do Peso
  TextEditingController weightController = TextEditingController();

  //  Controlador 2: Responsável pelo controle da altura
  TextEditingController heightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculadora de IMC'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      //Widget que permite a rolagem da tela
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 110,
                color: Colors.black,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 23),
                controller: weightController,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Insira Seu Peso';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura',
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 23),
                controller: heightController,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Insira Sua Altura';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: Container(
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _imcCalculator();
                      }
                    },
                    child: Text(
                      'Calcular',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
