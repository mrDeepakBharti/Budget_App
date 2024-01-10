class UserModel {
  int? id;
  String? title;
  double? amount;
  String? date;

  UserModel(
      {this.id, required this.title, required this.amount, required this.date});

  UserModel.formap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        amount = map['amount'],
        date = map['date'];
  Map<String, Object?> tomap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
    };
  }
}
