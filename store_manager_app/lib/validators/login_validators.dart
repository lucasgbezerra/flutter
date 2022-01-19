import 'dart:async';

class LoginValidators{

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData:(email, sink) {
      if(email.contains("@")){
          sink.add(email);
      }else{
        sink.addError("Invalid Email! This address email is not avaliable.");
      }
    }, 
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.length >= 7 ){
        sink.add(password);
      }else{
        sink.addError("Password must be at least 7 characters.");
      }
    },
  );  

}