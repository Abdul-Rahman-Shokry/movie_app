class AppUtils {
  static String formatRating(double? rating) {
    if (rating == null) return 'N/A';
    return rating.toStringAsFixed(1);
  }
}
