import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      try {
        await launchUrl(Uri.parse(googleUrl));
      } catch (e) {
        print(e.toString());
      }
    } else {
      throw 'Could not open the map.';
    }
  }
}
