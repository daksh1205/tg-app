import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tg_app/controller/controller.dart';
import 'package:tg_app/model/model.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  final ItemController _controller = ItemController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadItems();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadItems();
    }
  }

  Future<void> _loadItems() async {
    try {
      await _controller.fetchItems();
      setState(() {});
    } catch (e) {
      print('Error loading items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(
          Icons.explore_rounded,
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          'Discover',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Scrollbar(
        thickness: 4,
        child: ListView.builder(
          itemCount: _controller.items.length + 1,
          itemBuilder: (context, index) {
            if (index < _controller.items.length) {
              final Item item = _controller.items[index];
              return Card(
                color: Color.fromARGB(255, 38, 37, 37),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    item.title,
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    item.description,
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      item.imageUrl,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
          controller: _scrollController,
        ),
      ),
    );
  }
}
