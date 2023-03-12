import 'package:qtc_motoboy/app/data/models/custos_model.dart';
import 'package:qtc_motoboy/app/data/models/veiculo_model.dart';

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class User {
/*
{
  "veiculo": "50",
  "custos": "50",
  "percentualLucro": ""
} 
*/

  Veiculo? veiculo;
  Custos? custos;
  String? percentualLucro;

  User({
    this.veiculo,
    this.custos,
    this.percentualLucro,
  });
  User.fromJson(Map<String, dynamic> json) {
    if (json['veiculo'] != null) {
      veiculo = Veiculo.fromJson(json['veiculo']);
    }
    if (json['custos'] != null) {
      custos = Custos.fromJson(json['custos']);
    }

    percentualLucro = json['percentualLucro']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['veiculo'] = veiculo;
    data['custos'] = custos;
    data['percentualLucro'] = percentualLucro;
    return data;
  }
}
