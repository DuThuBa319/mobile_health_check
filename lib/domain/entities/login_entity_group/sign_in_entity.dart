import 'package:mobile_health_check/domain/entities/login_entity_group/token_entity.dart';

import '../../../presentation/common_widget/enum_common.dart';
import 'account_entity.dart';

class SignInEntity {
  TokenEntity? token;

  AccountEntity? accountInfor;

  UserRole? role;

  SignInEntity({this.accountInfor, this.role, this.token});
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity  