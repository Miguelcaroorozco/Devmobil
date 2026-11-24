import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../models/video_item.dart';

class FeedVideoItem extends StatefulWidget {
  final VideoItem video;
  final bool esVisible;

  const FeedVideoItem({
    super.key,
    required this.video,
    required this.esVisible,
  });

  @override
  State<FeedVideoItem> createState() => _FeedVideoItemState();
}

class _FeedVideoItemState extends State<FeedVideoItem> {
  late VideoPlayerController _controlador;
  bool _estaInicializado = false;
  bool _tieneError = false;
  bool _mostrarIcono = false;
  bool _estaLikeado = false;

  @override
  void initState() {
    super.initState();
    _estaLikeado = widget.video.isLiked;
    _inicializarVideo();
  }

  void _inicializarVideo() {
    if (widget.video.isAsset) {
      _controlador = VideoPlayerController.asset(widget.video.videoSource);
    } else {
      _controlador = VideoPlayerController.networkUrl(
        Uri.parse(widget.video.videoSource),
      );
    }

    _controlador.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _estaInicializado = true;
      });
      _controlador.setLooping(true);
      _controlador.setVolume(1.0);
      if (widget.esVisible) {
        _controlador.play();
      }
    }).catchError((_) {
      if (!mounted) return;
      setState(() {
        _tieneError = true;
      });
    });

    _controlador.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant FeedVideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.esVisible != widget.esVisible) {
      if (widget.esVisible) {
        if (_estaInicializado) _controlador.play();
      } else {
        if (_estaInicializado) _controlador.pause();
      }
    }
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  void _alternarReproduccion() {
    if (!_estaInicializado) return;

    setState(() {
      if (_controlador.value.isPlaying) {
        _controlador.pause();
      } else {
        _controlador.play();
      }
      _mostrarIcono = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _mostrarIcono = false);
      }
    });
  }

  void _alternarLike() {
    setState(() {
      _estaLikeado = !_estaLikeado;
      if (_estaLikeado) {
        widget.video.likesCount += 1;
      } else {
        widget.video.likesCount -= 1;
      }
      widget.video.isLiked = _estaLikeado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Fondo negro base
        Container(color: Colors.black),

        // Capa del video con overlay transparente para capturar taps en web
        if (_tieneError)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.broken_image_rounded,
                  color: Colors.white54,
                  size: 46,
                ),
                const SizedBox(height: 10),
                Text(
                  'No se pudo reproducir este video',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                ),
              ],
            ),
          )
        else if (_estaInicializado)
          Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _controlador.value.aspectRatio,
                  child: VideoPlayer(_controlador),
                ),
              ),
              // Overlay transparente encima del video para capturar el tap en web
              Positioned.fill(
                child: GestureDetector(
                  onTap: _alternarReproduccion,
                  behavior: HitTestBehavior.translucent,
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          )
        else
          const Center(
            child: CircularProgressIndicator(color: Colors.pinkAccent),
          ),

        // Gradiente oscuro inferior
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 240,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),

        // Área superior e inferior negra también captura taps
        Positioned.fill(
          child: GestureDetector(
            onTap: _alternarReproduccion,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),

        // Icono temporal de Play/Pausa al tocar
        if (_mostrarIcono)
          IgnorePointer(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    color: Colors.black.withValues(alpha: 0.5),
                    child: Icon(
                      _controlador.value.isPlaying
                          ? Icons.play_arrow_rounded
                          : Icons.pause_rounded,
                      color: Colors.white,
                      size: 54,
                    ),
                  ),
                ),
              ),
            ),
          ),

        // Información del video (usuario y descripción)
        Positioned(
          left: 18,
          bottom: 26,
          right: 85,
          child: IgnorePointer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      widget.video.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.pinkAccent.withValues(alpha: 0.6),
                        ),
                      ),
                      child: const Text(
                        'Seguir',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.video.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white70, size: 15),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.video.songTitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Barra lateral de interacción (Glassmorphism)
        Positioned(
          right: 14,
          bottom: 26,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar del creador
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.pinkAccent, width: 2),
                  gradient: const LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pinkAccent],
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.video.username.isNotEmpty
                        ? widget.video.username[1].toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Botón Me Gusta
              _construirBoton(
                icono: _estaLikeado
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                colorIcono: _estaLikeado ? Colors.redAccent : Colors.white,
                conteo: '${widget.video.likesCount}',
                alPresionar: _alternarLike,
              ),
              const SizedBox(height: 14),

              // Botón Comentarios
              _construirBoton(
                icono: Icons.chat_bubble_outline_rounded,
                colorIcono: Colors.white,
                conteo: '${widget.video.commentsCount}',
                alPresionar: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Comentarios de ${widget.video.username}',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),

              // Botón Compartir
              _construirBoton(
                icono: Icons.share_outlined,
                colorIcono: Colors.white,
                conteo: '${widget.video.sharesCount}',
                alPresionar: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enlace copiado al portapapeles'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Barra de progreso inferior
        if (_estaInicializado)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: VideoProgressIndicator(
                _controlador,
                allowScrubbing: false,
                colors: VideoProgressColors(
                  playedColor: Colors.pinkAccent,
                  bufferedColor: Colors.white24,
                  backgroundColor: Colors.white10,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
      ],
    );
  }

  Widget _construirBoton({
    required IconData icono,
    required Color colorIcono,
    required String conteo,
    required VoidCallback alPresionar,
  }) {
    return GestureDetector(
      onTap: alPresionar,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white12),
                ),
                child: Icon(icono, color: colorIcono, size: 24),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            conteo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
