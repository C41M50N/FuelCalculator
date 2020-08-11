import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: 0)
class Profile {

  @HiveField(0)
  String name;
  @HiveField(1)
  double percentToFull;
  @HiveField(2)
  double gallonsToFull;

  double get capacity {
    if (this.percentToFull != 0.0) return (1.0 / (1.0 - this.percentToFull)) * this.gallonsToFull;
    else return this.gallonsToFull;
  }

  Profile({this.name, this.percentToFull, this.gallonsToFull});

  Profile.init() {
    this.name = '';
    this.percentToFull = 0.5;
    this.gallonsToFull = 1;
  }

  @override
  String toString() {
    return "Name: ${this.name}\n" + 
            "PercentToFull: ${this.percentToFull}\n" + 
            "GallonsToFull: ${this.gallonsToFull}\n" + 
            "Capacity: ${this.capacity}";
  }
}