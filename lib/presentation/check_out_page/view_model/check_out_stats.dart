// ignore_for_file: must_be_immutable

part of 'check_out_cubit.dart';

@immutable
sealed class CheckOutStates {}


final class Initial extends CheckOutStates {}

final class CheckOutUpdatedState extends CheckOutStates {}


