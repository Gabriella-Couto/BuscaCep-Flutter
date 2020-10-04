import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flutter_app/componentes/componentes.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController controladorCEP = TextEditingController();
  GlobalKey<FormState> cform = GlobalKey<FormState>();


  String rua ="Rua";
  String estado = "Estado";
  String cidade = "Cidade";
  String bairro = "Bairro";
  String complemento = "Complemento";


  Function validaCEP = ((value){
    if(value.isEmpty)
      return "Informe o CEP";
    return null;
  });

  OnClick() async{
    if(!cform.currentState.validate())
      return;
    String url = "https://viacep.com.br/ws/${controladorCEP.text}/json/";
    Response response = await get(url);
    Map endereco = json.decode(response.body);
    setState(() {
      rua = endereco["logradouro"];
      estado = endereco["uf"];
      cidade = endereco["localidade"];
      bairro = endereco["bairro"];
      complemento = endereco["complemento"];

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
              key: cform,
              child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Image.asset(
                          "assets/imgs/buscacep.png",
                          fit: BoxFit.contain,
                        )
                    ),
                    Componentes.caixaDeTexto("CEP", "Informe o CEP", controladorCEP, validaCEP, numero: true),
                    Container(
                      height: 100,
                      child: IconButton(
                        onPressed: OnClick,
                        icon: FaIcon(FontAwesomeIcons.globe, size: 64, ),
                      ),
                    ),

                    Componentes.rotulo(rua),
                    Componentes.rotulo(complemento),
                    Componentes.rotulo(bairro),
                    Componentes.rotulo(cidade),
                    Componentes.rotulo(estado)

                  ]
              ),
            ),
        )

    );

  }
}

