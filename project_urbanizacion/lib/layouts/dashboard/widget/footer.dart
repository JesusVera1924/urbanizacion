import 'package:flutter/material.dart';
import 'package:project_urbanizacion/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.8, color: Color(0xCC232d37)),
        ),
        color: Color.fromRGBO(234, 234, 234, 1),
      ),
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0,
          MediaQuery.of(context).size.width * 0.05, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () => {},
                    child: const Text('Prueba',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                  const Text(' | ',
                      style: TextStyle(fontSize: 12, color: Color(0xCC232d37))),
                  const InkWell(
                    child: Text('00000',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                  const Text(' | ',
                      style: TextStyle(fontSize: 12, color: Color(0xCC232d37))),
                  const InkWell(
                    child: Text('admin',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Text('2023 - 2024',
                      style: TextStyle(
                          color: Color(0xCC232d37),
                          fontSize: 12,
                          letterSpacing: 0.23)))
            ],
          ),
          InkWell(
            onTap: () =>
                Provider.of<AuthProvider>(context, listen: false).logout(),
            child: const Row(
              children: [
                Icon(Icons.exit_to_app_rounded,
                    size: 30, color: Color(0xD9b22222)),
                Text(
                  'Cerrar Sesión',
                  style: TextStyle(fontSize: 18, color: Color(0xD9b22222)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
