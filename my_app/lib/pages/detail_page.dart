import 'package:flutter/material.dart';
import 'package:my_app/models/produk_nft.dart';
import 'package:my_app/service/api_everej.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final String email;

  const DetailPage({super.key, required this.product, required this.email});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController commentController = TextEditingController();
  List<Map<String, String>> comments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadComments();
  }

  void loadComments() async {
    final data = await ApiEverej.getComment(widget.product.id);

    if (!mounted) {
      return;
    }

    setState(() {
      comments = data.map<Map<String, String>>((objek) {
        return {
          "id": objek['id'].toString(),
          "user": objek['user'],
          "comment": objek['comment'],
        };
      }).toList();
    });
  }

  void addComment() async {
    String komen = commentController.text.trim();

    if (komen.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Comment cannot be empty")));
      return;
    }

    bool possukses = await ApiEverej.postComment(
      widget.product.id,
      widget.email,
      komen,
    );

    if (!mounted) {
      return;
    }

    if (possukses) {
      commentController.clear();
      loadComments();
    }
  }

  void deleteComment(int index) async {
    final id = int.parse(comments[index]['id']!);
    bool deleteSukeses = await ApiEverej.deleteComment(id);

    if (!mounted) {
      return;
    }
    if (deleteSukeses) {
      loadComments();
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Comment deleted")));
  }

  void updateComment(int index) {
    TextEditingController editController = TextEditingController(
      text: comments[index]["comment"],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Comment"),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () async {
              if (editController.text.trim().isEmpty) return;

              final id = comments[index]['id'];
              if (id == null) {
                return;
              }
              
              final parseId = int.parse(id);
              bool updateSukse = await ApiEverej.updateComment(
                parseId,
                editController.text.trim(),
              );

              if (!context.mounted) {
                return;
              }

              if (updateSukse) {
                loadComments();
              }

              Navigator.pop(context);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Comment updated")));
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void buyNft() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Success Buy")));
  }

  void sellNft() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Item Listed for Sale")));
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.info), text: "Detail"),
            Tab(icon: Icon(Icons.comment), text: "Reviews"),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(product.image),

                const SizedBox(height: 15),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  "${product.price} ETH",
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),

                const SizedBox(height: 15),
                Text(product.description),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: buyNft, child: const Text("BUY")),

                    ElevatedButton(
                      onPressed: sellNft,
                      child: const Text("SELL"),
                    ),
                  ],
                ),

                const Divider(height: 40),
                const Text(
                  "Write Review",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your comment",
                  ),
                ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addComment,
                  child: const Text("Post Review"),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final data = comments[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["user"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 5),
                      Text(data["comment"]!),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => updateComment(index),
                            child: const Text("UPDATE"),
                          ),

                          TextButton(
                            onPressed: () => deleteComment(index),
                            child: const Text("DELETE"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
