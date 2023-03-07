import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

encrypt(String str) async{
  final publicPem  = await rootBundle.loadString('assets/rsa/public.pem');
  dynamic parse = RSAKeyParser().parse(publicPem);
  final encryptor = Encrypter(RSA(publicKey: parse));
  final encrypted = encryptor.encrypt(str);
  return encrypted.base64;
}