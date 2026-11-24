class VideoItem {
  final String id;
  final String videoSource;
  final bool isAsset;
  final String username;
  final String description;
  final String songTitle;
  int likesCount;
  int commentsCount;
  int sharesCount;
  bool isLiked;

  VideoItem({
    required this.id,
    required this.videoSource,
    this.isAsset = false,
    required this.username,
    required this.description,
    required this.songTitle,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    this.isLiked = false,
  });

  static List<VideoItem> getSampleVideos() {
    return [
      VideoItem(
        id: '1',
        videoSource: 'assets/videos/video1.mp4',
        isAsset: true,
        username: '@miguel_dev',
        description:
            'Mi primer video para la app del parcial 📱🔥 #desarrollomovil #flutter',
        songTitle: 'Audio original - Miguel',
        likesCount: 1540,
        commentsCount: 95,
        sharesCount: 42,
      ),
      VideoItem(
        id: '2',
        videoSource: 'assets/videos/video2.mp4',
        isAsset: true,
        username: '@miguel_dev',
        description:
            'Segundo video desde la app 🚀 #flutter #mobile #dart',
        songTitle: 'Audio original - Miguel',
        likesCount: 2810,
        commentsCount: 134,
        sharesCount: 76,
      ),
      VideoItem(
        id: '3',
        videoSource: 'assets/videos/video3.mp4',
        isAsset: true,
        username: '@miguel_dev',
        description:
            'Tercer video en el feed vertical 🎥✨ #flutter #app',
        songTitle: 'Audio original - Miguel',
        likesCount: 6200,
        commentsCount: 310,
        sharesCount: 205,
      ),
      VideoItem(
        id: '4',
        videoSource: 'assets/videos/video4.mp4',
        isAsset: true,
        username: '@miguel_dev',
        description:
            'Cuarto video funcionando en la aplicación 🚀📱 #desarrollo #mobile',
        songTitle: 'Audio original - Miguel',
        likesCount: 9400,
        commentsCount: 540,
        sharesCount: 410,
      ),
    ];
  }
}
