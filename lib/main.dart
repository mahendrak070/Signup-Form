import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BlankForm(),
    );
  }
}

class BlankForm extends StatefulWidget {
  const BlankForm({super.key});
  @override
  _BlankFormState createState() => _BlankFormState();
}

class _BlankFormState extends State<BlankForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController     = TextEditingController();
  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController      = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // White background for the overall screen.
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign-Up Form'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 16),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 16),
              // Date of Birth Field
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Select DOB' : null,
              ),
              const SizedBox(height: 16),
              // Password protected
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter password' : null,
              ),
              const SizedBox(height: 32),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the data or navigate to another screen.
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
