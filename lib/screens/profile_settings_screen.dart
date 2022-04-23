import 'package:collabcar/models/user.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:collabcar/widgets/settings_widgets/profile_settings_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/profile-settings';

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  void _submitProfileSettingsForm(User? user) async {
    String message = "Hiba a mentés során";
    try {
      if (user != null) {
        Provider.of<LoggedUserProvider>(context, listen: false)
            .modifyUser(user);
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sikeresen elmentve'),
        backgroundColor: Colors.green,
      ));
    } on PlatformException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message == null ? message : err.message!),
        backgroundColor: Colors.red.shade700,
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<LoggedUserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilbeállítások'),
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: ProfileSettingsForm(
          user: userProvider.user,
          submitProfileSettings: _submitProfileSettingsForm,
        ),
      ),
    );
  }
}
