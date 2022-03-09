class Validators {
  static String? validateEmail(String? email) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return !regex.hasMatch(email ?? '') //
        ? 'Email inválido'
        : null;
  }

  static String? validatePassword(String? password) {
    return (password?.length ?? 0) < 6 //
        ? 'Contraseña muy corta'
        : null;
  }
}
