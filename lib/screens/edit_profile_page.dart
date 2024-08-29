import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with EditProfilePageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[300]!,
              Colors.purple[300]!,
              Colors.purple[200]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextFormField(
                    label: 'Username',
                    initialValue: _username,
                    onSaved: (value) => _username = value!,
                  ),
                  _buildTextFormField(
                    label: 'First Name',
                    initialValue: _firstName,
                    onSaved: (value) => _firstName = value!,
                  ),
                  _buildTextFormField(
                    label: 'Last Name',
                    initialValue: _lastName,
                    onSaved: (value) => _lastName = value!,
                  ),
                  _buildTextFormField(
                    label: 'Email',
                    initialValue: _email,
                    onSaved: (value) => _email = value!,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextFormField(
                    label: 'Phone Number',
                    initialValue: _phoneNumber,
                    onSaved: (value) => _phoneNumber = value!,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextFormField(
                    label: 'Date of Birth',
                    initialValue: _dateOfBirth,
                    onSaved: (value) => _dateOfBirth = value!,
                    keyboardType: TextInputType.datetime,
                  ),
                  _buildTextFormField(
                    label: 'Weight',
                    initialValue: _weight,
                    onSaved: (value) => _weight = value!,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextFormField(
                    label: 'Country',
                    initialValue: _country,
                    onSaved: (value) => _country = value!,
                  ),
                  _buildTextFormField(
                    label: 'State',
                    initialValue: _state,
                    onSaved: (value) => _state = value!,
                  ),
                  _buildTextFormField(
                    label: 'City',
                    initialValue: _city,
                    onSaved: (value) => _city = value!,
                  ),
                  _buildTextFormField(
                    label: 'Street',
                    initialValue: _street,
                    onSaved: (value) => _street = value!,
                  ),
                  _buildTextFormField(
                    label: 'Zip Code',
                    initialValue: _zipCode,
                    onSaved: (value) => _zipCode = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.zenDots(
            textStyle: TextStyle(color: Colors.white70),
          ),
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

mixin EditProfilePageMixin on State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String _username = "mohammed.altamimi";
  String _firstName = "Mohammed";
  String _lastName = "Altamimi";
  String _email = "mohammedtamimi72@gmail.com";
  String _phoneNumber = "123-456-7890";
  String _dateOfBirth = "1994-08-29";
  String _weight = "75 kg";
  String _country = "Saudi Arabia";
  String _state = "Riyadh";
  String _city = "Riyadh";
  String _street = "Olaya Street";
  String _zipCode = "12345";

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would typically send the data to your backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }
}
