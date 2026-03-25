enum Role {
  unregistered,
  new_user,
  guest,
  user,
  ;

  static Role fromString(String s) {
    for (Role role in Role.values) {
      if (role.name == s) {
        return role;
      }
    }
    throw "No Role";
  }
}
