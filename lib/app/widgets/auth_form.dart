import 'package:flutter/material.dart';

enum CustomAuthMode { login, register }

class AuthForm extends StatefulWidget {
  final void Function(String email, String password) onLogin;
  final void Function(String email, String password) onRegister;

  const AuthForm({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<AuthForm> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  CustomAuthMode _mode = CustomAuthMode.login;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      
      FocusScope.of(context).unfocus();

      if (_mode == CustomAuthMode.login) {
        widget.onLogin(email, password);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Вход...')),
        );
      } else {
        widget.onRegister(email, password);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Регистрация...')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildModeButton(CustomAuthMode.login, 'Вход'),
              const SizedBox(width: 24),
              _buildModeButton(CustomAuthMode.register, 'Регистрация'),
            ],
          ),

          const SizedBox(height: 32),

          _buildTextField(
            controller: _emailController,
            label: 'Почта',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v!.isEmpty ? 'Обязательное поле' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passwordController,
            label: 'Пароль',
            icon: Icons.lock,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (v) => v!.isEmpty ? 'Обязательное поле' : null,
          ),
          const SizedBox(height: 32),
          // Кнопка
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 202, 32, 174),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _mode == CustomAuthMode.login ? 'ВОЙТИ' : 'ЗАРЕГИСТРИРОВАТЬСЯ',
                style: const TextStyle(
                  color: Color.fromARGB(255, 32, 34, 107),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 18
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(CustomAuthMode mode, String label) {
    final isActive = _mode == mode;
    return TextButton(
      onPressed: () => setState(() => _mode = mode),
      style: TextButton.styleFrom(
        foregroundColor: isActive ? const Color.fromARGB(255, 202, 32, 174) : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: Colors.grey.withAlpha(80),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Color.fromARGB(255, 202, 32, 174),
        ),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.withAlpha(80),
        labelStyle: TextStyle(
          color: Colors.white
        ),
      ),
      style: TextStyle(
        color: Colors.white
      )
    );
  }
}
