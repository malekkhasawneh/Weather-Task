abstract class UsersAuthClasses {}

class InitialUsersAuthClasses extends UsersAuthClasses {}

/* User Register */

class UserRegister extends UsersAuthClasses {}

class UserRegisterSuccess extends UsersAuthClasses {}

class PickImage extends UsersAuthClasses {}

class UserRegisterFailed extends UsersAuthClasses {
  String error;

  UserRegisterFailed(this.error);
}

/*User Login*/

class UserLogin extends UsersAuthClasses {}

class UserLoginSuccess extends UsersAuthClasses {}

class UserLoginFailed extends UsersAuthClasses {
  String error;

  UserLoginFailed(this.error);
}

class UserLogout extends UsersAuthClasses{}
