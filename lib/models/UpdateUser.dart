class UpdateUser {
  
  late final String name;
  final int age;
  final List<String> imageUrls;
  late final String bio;
  final List<String> interested;
  
  

  UpdateUser(
      {
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.bio,
    required this.interested,
    
    });
}