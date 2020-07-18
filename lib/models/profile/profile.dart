class Profile {

  String name;
  double percentToFull;
  double gallonsToFull;
  double capacity;

  Profile({this.name, this.percentToFull, this.gallonsToFull}) {
    if (this.percentToFull != 0.0) this.capacity = (1.0 / this.percentToFull) * this.gallonsToFull;
    else this.capacity = this.gallonsToFull;
  }
}