import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(createToJson: false)
class Address extends Equatable {
  const Address({
    required this.street,
    required this.buildingNumber,
    required this.postCode,
    required this.city,
    required this.country,
    this.apartmentNumber,
  });

  factory Address.fromJson(Json json) => _$AddressFromJson(json);

  final String street;
  final String buildingNumber;
  final String? apartmentNumber;
  final String postCode;
  final String city;
  final String country;

  @override
  List<Object?> get props => [
        street,
        buildingNumber,
        apartmentNumber,
        postCode,
        city,
        country,
      ];
}
