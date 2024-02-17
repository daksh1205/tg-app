import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tg_app/model/model.dart';

class ItemController {
  final String apiUrl = 'https://api-stg.together.buzz/mocks/discovery';
  List<Item> items = [];
  int page = 1;
  int limit = 10;
  bool _loading = false;
  bool _hasReachedEnd = false;

  Future<void> fetchItems() async {
    if (_loading || _hasReachedEnd) return;

    _loading = true;

    final response =
        await http.get(Uri.parse('$apiUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data'];
      if (data.isNotEmpty) {
        items.addAll(data.map((json) => Item.fromJson(json)));
        page++;
      } else {
        // Stop loading when response is empty
        _hasReachedEnd = true;
        print("No items to load");
      }
    } else {
      throw Exception('Failed to load items');
    }

    _loading = false;
  }
}
