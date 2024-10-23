class ItemModel {
  final String publisher;
  final String title;
  final String sourceUrl;
  final String recipeId;
  final String imageUrl;
  final double socialRank;
  final String publisherUrl;

  ItemModel({
    required this.publisher,
    required this.title,
    required this.sourceUrl,
    required this.recipeId,
    required this.imageUrl,
    required this.socialRank,
    required this.publisherUrl,
  });

  // Método para converter um JSON em um objeto ItemModel
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      publisher: json['publisher'] as String,
      title: json['title'] as String,
      sourceUrl: json['source_url'] as String,
      recipeId: json['recipe_id'] as String,
      imageUrl: json['image_url'] as String,
      socialRank: (json['social_rank'] as num).toDouble(),
      publisherUrl: json['publisher_url'] as String,
    );
  }

  // Método para converter um objeto ItemModel em JSON
  Map<String, dynamic> toJson() {
    return {
      'publisher': publisher,
      'title': title,
      'source_url': sourceUrl,
      'recipe_id': recipeId,
      'image_url': imageUrl,
      'social_rank': socialRank,
      'publisher_url': publisherUrl,
    };
  }
}
