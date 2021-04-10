import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class Perfilmensajero extends StatelessWidget {
  final idperfil;
  var img = 'https://img.icons8.com/color/480/000000/whatsapp--v1.png';
  final List<Post> perfil;
  Perfilmensajero({Key key, this.perfil, this.idperfil});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil Mensajero Juan Herrera Joiro'),
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        elevation: 2,
                        child: Image.network(perfil[idperfil].foto),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                perfil[idperfil].nombre,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(perfil[idperfil].moto),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Calificaciones'),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Cumplimiento'),
                                      CircleAvatar(child: Text('0.0')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Responsabilidad'),
                                      CircleAvatar(child: Text('0.0')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Amabilidad'),
                                      CircleAvatar(child: Text('0.0')),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Descripcion:'),
                              Text('Mensajero las 24 Horas'),
                              Text("TEL: " + perfil[idperfil].telefono),
                              Text("Wsp: " + perfil[idperfil].whatsapp),
                              SizedBox(height: 20),
                              SizedBox(height: 20),
                              Text('Verificar Placa:'),
                              SizedBox(height: 10),
                              Container(
                                width: 100,
                                height: 50,
                                color: Colors.yellowAccent,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  perfil[idperfil].placa,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: () {
                          _makePhoneCall('tel:${perfil[idperfil].telefono}');
                        },
                        child: Icon(Icons.phone_sharp)),
                    FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: () {
                          String mensaje = "Hola Programa de mensajeria \n" +
                              "---------------------------------------\n" +
                              "Id: ${perfil[idperfil].id}\n" +
                              "Mensajero: ${perfil[idperfil].nombre}\n" +
                              "Telefono: ${perfil[idperfil].telefono}\n" +
                              "Whatsapp: ${perfil[idperfil].whatsapp}\n" +
                              "Placa: ${perfil[idperfil].placa}\n" +
                              "Moto: ${perfil[idperfil].moto}\n" +
                              "---------------------------------------\n" +
                              "BY: Juan Herrera Joiro\n" +
                              "---------------------------------------\n";

                          _makeWhatsapp(perfil[idperfil].whatsapp, mensaje);
                        },
                        child: CircleAvatar(
                          radius: size.height,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(img),
                        )),
                    SizedBox(
                      width: 200.0,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Regresar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _makePhoneCall(String telefono) async {
    if (await canLaunch(telefono)) {
      await launch(telefono);
    } else {
      throw 'NO SE PUDO ABRIR LA APLICACION DE TELEFONO $telefono';
    }
  }

  void _makeWhatsapp(
      @required String telefono, @required String mensaje) async {
    String whatsapp = "whatsapp://send?phone=+57${telefono}&text=${mensaje}";

    if (await canLaunch(whatsapp)) {
      await launch(whatsapp);
    } else {
      throw 'NO SE PUDO ABRIR LA APLICACION DE WHATSAPP $whatsapp';
    }
  }
}
