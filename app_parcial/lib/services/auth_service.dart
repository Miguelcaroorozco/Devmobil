import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _autenticacion = FirebaseAuth.instance;

  User? get usuarioActual => _autenticacion.currentUser;

  Stream<User?> get cambiosDeAutenticacion => _autenticacion.authStateChanges();

  /// Inicia sesión con correo electrónico y contraseña
  Future<UserCredential> iniciarSesionConCorreo({
    required String correo,
    required String contrasena,
  }) async {
    return await _autenticacion.signInWithEmailAndPassword(
      email: correo.trim(),
      password: contrasena,
    );
  }

  /// Registra un nuevo usuario con correo, contraseña y nombre completo
  Future<UserCredential> registrarConCorreo({
    required String nombre,
    required String correo,
    required String contrasena,
  }) async {
    final credencial = await _autenticacion.createUserWithEmailAndPassword(
      email: correo.trim(),
      password: contrasena,
    );

    if (credencial.user != null) {
      await credencial.user!.updateDisplayName(nombre.trim());
      await credencial.user!.reload();
    }

    return credencial;
  }

  /// Inicia sesión con Google (Popup en Web, nativo en móvil)
  Future<UserCredential?> iniciarSesionConGoogle() async {
    if (kIsWeb) {
      final GoogleAuthProvider proveedorGoogle = GoogleAuthProvider();
      proveedorGoogle.addScope('email');
      proveedorGoogle.addScope('profile');
      return await _autenticacion.signInWithPopup(proveedorGoogle);
    }

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? cuentaGoogle = await googleSignIn.signIn();

    if (cuentaGoogle == null) return null;

    final GoogleSignInAuthentication autenticacionGoogle =
        await cuentaGoogle.authentication;

    final OAuthCredential credencial = GoogleAuthProvider.credential(
      accessToken: autenticacionGoogle.accessToken,
      idToken: autenticacionGoogle.idToken,
    );

    return await _autenticacion.signInWithCredential(credencial);
  }

  /// Inicia sesión con Facebook (Popup en Web, nativo en móvil)
  Future<UserCredential?> iniciarSesionConFacebook() async {
    if (kIsWeb) {
      final FacebookAuthProvider proveedorFacebook = FacebookAuthProvider();
      return await _autenticacion.signInWithPopup(proveedorFacebook);
    }

    final LoginResult resultado = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    if (resultado.status == LoginStatus.success &&
        resultado.accessToken != null) {
      final OAuthCredential credencial = FacebookAuthProvider.credential(
        resultado.accessToken!.tokenString,
      );
      return await _autenticacion.signInWithCredential(credencial);
    } else if (resultado.status == LoginStatus.cancelled) {
      return null;
    } else {
      throw Exception(
        resultado.message ?? 'Error al iniciar sesión con Facebook',
      );
    }
  }

  /// Cierra sesión en Firebase, Google y Facebook
  Future<void> cerrarSesion() async {
    await _autenticacion.signOut();

    if (!kIsWeb) {
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
    }
  }

  /// Traduce los errores de FirebaseAuth a mensajes legibles en español
  static String mensajeDeError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No existe ningún usuario registrado con este correo.';
        case 'wrong-password':
          return 'La contraseña es incorrecta.';
        case 'invalid-credential':
          return 'Credenciales incorrectas. Verifica tu correo y contraseña.';
        case 'email-already-in-use':
          return 'Este correo ya se encuentra registrado. Inicia sesión.';
        case 'weak-password':
          return 'La contraseña debe tener al menos 6 caracteres.';
        case 'invalid-email':
          return 'El formato del correo electrónico no es válido.';
        case 'user-disabled':
          return 'Esta cuenta ha sido inhabilitada por un administrador.';
        case 'too-many-requests':
          return 'Demasiados intentos fallidos. Por favor espera unos minutos.';
        case 'operation-not-allowed':
          return 'Este método de autenticación no está habilitado en Firebase.';
        case 'account-exists-with-different-credential':
          return 'Ya existe una cuenta con este correo vinculada a otro proveedor.';
        case 'popup-closed-by-user':
          return 'Ventana de inicio de sesión cerrada antes de completar.';
        default:
          return error.message ?? 'Ocurrió un error (${error.code}).';
      }
    }
    return error.toString().replaceFirst('Exception: ', '');
  }
}
