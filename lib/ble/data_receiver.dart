import 'dart:typed_data';

import 'package:blelib/ble/ble_packet.dart';
import 'package:blelib/ble/log.dart';
import 'package:blelib/blelib.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import 'define.dart';

void handleRespond(BluetoothDevice device, List<int>? buf) {
  if (buf == null || buf.isEmpty) return;

  WorkingDevice lockModel = Get.find();
  BleDevice? bleDevice = lockModel.getByBleRawDevice(device);
  if (bleDevice == null) return;

  Uint8List data = Uint8List.fromList(buf);
  var packet = BlePacket.unpack(bleDevice, data);
  if (packet != null) {
    BlePacket.store(bleDevice, packet);
  }
}

// 共用协议层解析处理
void postCommonProcess(BleDevice bleDevice, int cmd, Uint8List content) {
  ekLog("cmd=$cmd  $content");
  switch (cmd) {
    // case CmdOrder.startSession:
    //   // start session resp
    //   BleDataChannel.instance.commonProtoReceiver
    //       .onRecvStartSession(bleDevice, dataProcess);
    //   break;
    case CmdOrder.CMD_GET_DEVICE_NAME_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetDeviceName(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_DEVICE_NAME_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDeviceName(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_EIK_CODE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetEIKCode(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_FW_VERSION_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetFWVersion(bleDevice, content);
      break;
    case CmdOrder.CMD_SYNC_TIME_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSyncTime(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_TEST_FLAG_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetTestFlag(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_TEST_FLAG_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetTestFlag(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_DEV_STATUS_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetDevStatus(bleDevice, content);
      break;
    case CmdOrder.CMD_START_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvStart(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_START:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyStart(bleDevice, content);
      break;
    case CmdOrder.CMD_PAUSE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvPause(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_PAUSE:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyPause(bleDevice, content);
      break;
    case CmdOrder.CMD_STOP_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvStop(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_STOP:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyStop(bleDevice, content);
      break;
    case CmdOrder.CMD_SHUTDOWN_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvShutdown(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_SHUTDOWN:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyShutdown(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_MODE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetMode(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_MODE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetMode(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_MODE:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyMode(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_DEFAULT_MODE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDefaultMode(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_DEFAULT_MODE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetDefaultMode(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_LEVEL_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_LEVEL_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_LEVEL:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_DEFAULT_LEVEL_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDefaultLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_DEFAULT_LEVEL_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetDefaultLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_SET_TIME_LEN_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetTimeLen(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_TIME_LEN_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetTimeLen(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_TIME_LEN:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyTimeLen(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_BATTERY_LEVEL_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetBatteryLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_NOTIFY_BATTERY_LEVEL:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyBatteryLevel(bleDevice, content);
      break;
    case CmdOrder.CMD_BIG_DATA_TEST_RECV_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvBigDataTest(bleDevice, content);
      break;
    case CmdOrder.CMD_GET_PROPERTY_CODE_CONFIRM:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvPropertyCode(bleDevice, content);
      break;
/*
    case CmdOrder.readStatus:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvReadStatus(bleDevice, content);
      break;

    case CmdOrder.setDeviceName:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDeviceName(bleDevice, content);
      break;

    case CmdOrder.setDevicePin:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDevicePin(bleDevice, content);
      break;

    case CmdOrder.keyAuth:
      BleDataChannel.instance.commonProtoReceiver.onRecvKeyAuth(bleDevice, content);
      break;

    case CmdOrder.reverseKeyAuth:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvReverseKeyAuth(bleDevice, content);
      break;

    case CmdOrder.getVersion:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvGetVersion(bleDevice, content);
      break;

    case CmdOrder.syncTime:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSyncTime(bleDevice, content);
      break;

    case CmdOrder.readDeviceCode:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvReadDeviceCode(bleDevice, content);
      break;

    case CmdOrder.setModeParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetModeParam(bleDevice, content);
      break;

    case CmdOrder.setStrengthParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetStrengthParam(bleDevice, content);
      break;

    case CmdOrder.setTimeLenParams:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetTimeLenParams(bleDevice, content);
      break;

    case CmdOrder.notifyModeParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyModeParam(bleDevice, content);
      break;

    case CmdOrder.notifyStrengthParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyStrengthParam(bleDevice, content);
      break;

    case CmdOrder.readModeParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvReadModeParam(bleDevice, content);
      break;

    case CmdOrder.readStrengthParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvReadStrengthParam(bleDevice, content);
      break;

    case CmdOrder.setStart:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetStart(bleDevice, content);
      break;

    case CmdOrder.setStop:
      BleDataChannel.instance.commonProtoReceiver.onRecvSetStop(bleDevice, content);
      break;
    case CmdOrder.notifyStart:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyStart(bleDevice, content);
      break;

    case CmdOrder.notifyStop:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyStop(bleDevice, content);
      break;

    case CmdOrder.setDefaultModeParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDefaultMode(bleDevice, content);
      break;

    case CmdOrder.readDefaultModeParam:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvReadDefaultModeParam(bleDevice, content);
      break;

    case CmdOrder.shutdown:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvShutdown(bleDevice, content);
      break;

    case CmdOrder.notifyShutdown:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvNotifyShutdown(bleDevice, content);
      break;

    case CmdOrder.setDeviceCode:
      BleDataChannel.instance.commonProtoReceiver
          .onRecvSetDeviceCode(bleDevice, content);
      break;
      */
  }
}
