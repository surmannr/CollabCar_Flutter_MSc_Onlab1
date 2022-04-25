import 'package:collabcar/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:collabcar/models/user.dart' as my_user;
import 'package:intl/intl.dart';

class ProfileSettingsForm extends StatefulWidget {
  const ProfileSettingsForm(
      {this.user, required this.submitProfileSettings, Key? key})
      : super(key: key);

  final my_user.User? user;
  final void Function(my_user.User? user) submitProfileSettings;

  @override
  State<ProfileSettingsForm> createState() => _ProfileSettingsFormState();
}

class _ProfileSettingsFormState extends State<ProfileSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      widget.submitProfileSettings(widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasCarpoolService = widget.user!.hasCarpoolService;
    if (widget.user == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A név kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.user!.name,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Név',
              ),
              onSaved: (value) {
                if (value != null) widget.user!.name = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A telefonszám kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.user!.telephone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Telefonszám',
              ),
              onSaved: (value) {
                if (value != null) widget.user!.telephone = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return "Érvénytelen formátumú email cím!";
                }
                return null;
              },
              initialValue: widget.user!.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Emal cím',
              ),
              onSaved: (value) {
                if (value != null) widget.user!.email = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 7) {
                  return "A jelszó mérete legalább 7 karakter!";
                }
                return null;
              },
              initialValue: widget.user!.password,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Jelszó',
              ),
              onSaved: (value) {
                if (value != null) widget.user!.password = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A születési dátum kitöltése kötelező!";
                }
                return null;
              },
              initialValue:
                  DateFormat('yyyy-MM-dd').format(widget.user!.birthDate),
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.cake),
                labelText: 'Születési dátum',
              ),
              onSaved: (value) {
                if (value != null)
                  widget.user!.birthDate = DateTime.parse(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Telekocsi szolgáltatást nyújt'),
                    Text(
                      'Csak érvényes gépjárművel lehetséges',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Switch(
                  value: hasCarpoolService,
                  onChanged: (value) => setState(() {
                    widget.user!.hasCarpoolService = value;
                  }),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _trySubmit(context),
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Mentés'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Mégse'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
