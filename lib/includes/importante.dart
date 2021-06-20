// Ejm : Include
// https://stackoverflow.com/a/57076207

String logo = 'assets/images/logo.png';
String logo_texto_blanco = 'assets/images/sendpost-texto-blanco.png';
var apirest = "http://192.168.0.103:8000";

bool validarInputs(String input){
  if(input.trim() != ''){
    return true;
  }else{
    return false;
  }
}