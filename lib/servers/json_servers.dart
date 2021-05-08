import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class AssetUnit {
  Future<dynamic>get(String url) async {
    return await rootBundle.loadString(url);
  }
}
final AssetUnit asset = new AssetUnit();