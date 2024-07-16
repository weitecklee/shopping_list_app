import 'package:flutter_dotenv/flutter_dotenv.dart';

final kFirebaseUrl =
    Uri.https(dotenv.env['FIREBASE_URL']!, 'shopping-list.json');

Uri deleteUrl(String id) =>
    Uri.https(dotenv.env['FIREBASE_URL']!, 'shopping-list/$id.json');
