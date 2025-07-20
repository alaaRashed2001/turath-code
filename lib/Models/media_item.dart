enum MediaType { youtube, scratch, canva }

class MediaItem {
  final String titleAr;
  final String titleEn;
  final String image;
  final String url;
  final MediaType type;

  MediaItem({
    required this.titleAr,
    required this.titleEn,
    required this.image,
    required this.url,
    required this.type,
  });

 
  String getTitle(String localeCode) {
    return localeCode == 'ar' ? titleAr : titleEn;
  }
}