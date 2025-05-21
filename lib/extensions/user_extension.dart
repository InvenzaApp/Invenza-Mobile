import 'package:app/features/user/models/user.dart';

extension UserExtension on User{
  bool hasAccessToGroup(int groupId){
    return groupsIdList.contains(groupId);
  }
}
