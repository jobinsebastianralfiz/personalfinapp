import 'package:hive_flutter/adapters.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 2)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String uid;
  @HiveField(2)
  late double amount;
  @HiveField(3)
  late String description;
  @HiveField(4)
  late String category;
  @HiveField(5)
  late DateTime createdat;

  ExpenseModel(
      {required this.id,
        required this.uid,
        required this.amount,
        required this.description,
        required this.category,
        required this.createdat});
}
