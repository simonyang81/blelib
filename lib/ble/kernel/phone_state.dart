import 'dart:io';

import 'package:blelib/ble/log.dart';
import 'package:blelib/blelib.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class PhoneState {
  factory PhoneState() => _getInstance();
  static PhoneState get instance => _getInstance();
  static PhoneState? _instance;
  static PhoneState _getInstance() {
    _instance ??= PhoneState._internal();
    return _instance!;
  }

  void init() {
    PhoneState._getInstance();
  }

  PhoneState._internal() {
    _listenPhoneBLEStatus();
  }
  _listenPhoneBLEStatus() {
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState event) async {
      ekLog('new ble state = $event');
      switch (event) {
        case BluetoothAdapterState.turningOff:
          {
            WorkingDevice workingDevice = Get.find();
            var curDevice = workingDevice.getConnectedDevice();
            if (curDevice != null) {
              if (curDevice.device != null) {
                await BleConnector.instance.disconnectDevice(curDevice);

                ekLog('ble: --->>turning off disconnect done...');
              }
              await BleConnector.instance.switchToDisconnected(curDevice);
            }
          }
          break;
        case BluetoothAdapterState.off:
          {
            if (Platform.isIOS) {
              WorkingDevice workingDevice = Get.find();

              var curDevice = workingDevice.getConnectedDevice();
              if (curDevice != null) {
                if (curDevice.device != null) {
                  await BleConnector.instance.disconnectDevice(curDevice);

                  ekLog('ble: --->>turn off disconnect done...');
                }
                await BleConnector.instance.switchToDisconnected(curDevice);
              }
            }

            break;
          }
        default:
          break;
      }
    });
  }
}
