import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/http/auth_response.dart';
import 'package:project_urbanizacion/ui/components/custom_outlined_button.dart';
import 'package:project_urbanizacion/providers/auth_provider.dart';
import 'package:project_urbanizacion/providers/login_form_provider.dart';
import 'package:project_urbanizacion/services/notifications_service.dart';
import 'package:project_urbanizacion/style/custom_inputs.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(
        builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

          void sendLogin() async {
            Authentication? usuario = await loginFormProvider.sendLogin();
            if (usuario != null) {
              authProvider.login(usuario);
            } else {
              NotificationsService.showSnackbar(
                  'Usuario / Password no válidos');
            }
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                    key: loginFormProvider.formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su identificacion';
                            }
                            if (value.length <= 2) {
                              return 'La identificacion debe ser mayor a 2 caracteres';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            loginFormProvider.usuario = value;
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Ingrese Su Identificacion',
                              label: 'Identificacion',
                              icon: Icons.person),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            loginFormProvider.password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su password';
                            }

                            if (value.length < 6) {
                              return 'La password debe ser mayor o igual a 10 caracteres ';
                            }

                            return null;
                          },
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '******',
                              label: 'Password',
                              icon: Icons.lock_outline_rounded),
                          onEditingComplete: () async {
                            sendLogin();
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomOutlinedButton(
                            onPressed: () async => sendLogin(),
                            text: 'Ingresar'),
                        TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                (Set<MaterialState> states) {
                                  return Colors.transparent;
                                },
                              ),
                            ),
                            child: const Text(
                              '¿Olvidastes tu constraseña?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
