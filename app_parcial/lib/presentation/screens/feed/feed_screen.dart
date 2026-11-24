import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../models/video_item.dart';
import '../../../services/auth_service.dart';
import 'feed_video_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _controladorPagina = PageController();
  final AuthService _servicioAuth = AuthService();
  final List<VideoItem> _videos = VideoItem.getSampleVideos();

  int _indiceActual = 0;
  bool _cerrando = false;

  @override
  void dispose() {
    _controladorPagina.dispose();
    super.dispose();
  }

  Future<void> _manejarCierreSesion() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'Cerrar sesión',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Estás seguro de que deseas cerrar tu sesión?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contexto).pop(false),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white60),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () => Navigator.of(contexto).pop(true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    setState(() => _cerrando = true);

    await _servicioAuth.cerrarSesion();
    // GoRouter detecta el cambio de auth y redirige a /login
  }

  @override
  Widget build(BuildContext context) {
    final User? usuario = _servicioAuth.usuarioActual;
    final String nombreMostrado =
        (usuario?.displayName != null &&
                usuario!.displayName!.trim().isNotEmpty)
            ? usuario.displayName!
            : (usuario?.email ?? 'Usuario');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Stack(
            children: [
              // PageView vertical de videos — habilita drag con mouse en web
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                    PointerDeviceKind.trackpad,
                  },
                ),
                child: PageView.builder(
                controller: _controladorPagina,
                scrollDirection: Axis.vertical,
                itemCount: _videos.length,
                onPageChanged: (indice) {
                  setState(() {
                    _indiceActual = indice;
                  });
                },
                itemBuilder: (contexto, indice) {
                  return FeedVideoItem(
                    key: ValueKey(_videos[indice].id),
                    video: _videos[indice],
                    esVisible: indice == _indiceActual,
                  );
                },
              ),
              ),

              // Barra superior con usuario y botón de logout
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 4,
                          top: 4,
                          bottom: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.account_circle,
                              color: Colors.pinkAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 120),
                              child: Text(
                                nombreMostrado,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 28,
                                minHeight: 28,
                              ),
                              tooltip: 'Cerrar sesión',
                              onPressed: _cerrando ? null : _manejarCierreSesion,
                              icon: _cerrando
                                  ? const SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.logout_rounded,
                                      color: Colors.redAccent,
                                      size: 18,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
