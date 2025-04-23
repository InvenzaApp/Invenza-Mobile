enum Permissions{
  addUser,
  listUser,
  showUser,
  updateUser,
  deleteUser,
  addGroup,
  listGroup,
  showGroup,
  updateGroup,
  deleteGroup,
  addTask,
  listTask,
  showTask,
  updateTask,
  deleteTask;

  static Permissions fromSingleJson(dynamic json){
    return Permissions.values.byName(json as String);
  }

  static List<Permissions> fromJson(List<dynamic> json) {
    return json
        .map((e) => Permissions.values.byName(e as String))
        .toList();
  }
}
