class Profile {
  String name;
  String email;
  String password;
  var dob;
  List<String> interest = [];

  Profile(
      {required this.name,
      required this.email,
      required this.password,
      required this.dob,
      required this.interest});
}
