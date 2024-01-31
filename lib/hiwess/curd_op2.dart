import 'package:hive/hive.dart';
part 'curd_op2.g.dart';

@HiveType(typeId: 0)
class datas extends HiveObject
{
  @HiveField(0)
  String name;

  @HiveField(1)
  String contact;

  datas(this.name,this.contact);

  @override
  String toString() {
    return 'datas{name: $name, contact: $contact}';
  }
}