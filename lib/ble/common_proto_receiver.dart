import 'package:blelib/blelib.dart';
import 'package:blelib/interface/ble_recv_interface.dart';
import 'package:blelib/interface/ble_recv_unpack_interface.dart';
import 'package:flutter/services.dart';

import 'log.dart';

// 对所接收的业务包内容进行解析，并回调给上层
class CommonProtoReceiver implements BleCommonRecvUnpackInterface {
  void setCallbackReceiver(BleCommonRecvInterface callbackObj) {
    _callbackObj = callbackObj;
  }

  BleCommonRecvInterface? _callbackObj;

  @override
  void onRecvGetDeviceName(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetDeviceName content len ${content.length}');
      return;
    }

    bool bOk = (content[0] == 0);

    _callbackObj?.onRecvGetDeviceName(bleDevice, bOk, content.sublist(1));
  }

  void onRecvSetDeviceName(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetDeviceName content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetDeviceName(bleDevice, bOk);
  }

  void onRecvGetEIKCode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty || content.length < 2) {
      errLog('onRecvGetEIKCode content len ${content.length}');
      return;
    }
    //result(1) code len(1) EIK code(n)
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetEIKCode(bleDevice, bOk, content.sublist(2));
  }

  void onRecvGetFWVersion(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetFWVersion content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetFWVersion(bleDevice, bOk, content.sublist(1));
  }

  void onRecvSyncTime(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSyncTime content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSyncTime(bleDevice, bOk);
  }

  void onRecvSetTestFlag(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetTestFlag content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetTestFlag(bleDevice, bOk);
  }

  void onRecvGetTestFlag(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetTestFlag content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetTestFlag(bleDevice, bOk, content.sublist(1));
  }

  void onRecvGetDevStatus(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetDevStatus content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetDevStatus(bleDevice, bOk, content.sublist(1));
  }

  void onRecvStart(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvStart content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvStart(bleDevice, bOk);
  }

  void onRecvNotifyStart(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvNotifyStart(bleDevice);
  }

  void onRecvPause(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvPause content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvPause(bleDevice, bOk);
  }

  void onRecvNotifyPause(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvNotifyPause(bleDevice);
  }

  void onRecvStop(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvStop content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvStop(bleDevice, bOk);
  }

  void onRecvNotifyStop(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvNotifyStop(bleDevice);
  }

  void onRecvShutdown(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvShutdown content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvShutdown(bleDevice, bOk);
  }

  void onRecvNotifyShutdown(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvNotifyShutdown(bleDevice);
  }

  void onRecvSetMode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetMode content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetMode(bleDevice, bOk, content.sublist(1));
  }

  void onRecvGetMode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetMode content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetMode(bleDevice, bOk, content.sublist(1));
  }

  void onRecvNotifyMode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvNotifyMode content len ${content.length}');
      return;
    }
    _callbackObj?.onRecvNotifyMode(bleDevice, content);
  }

  void onRecvSetDefaultMode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetDefaultMode content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetDefaultMode(bleDevice, bOk);
  }

  void onRecvGetDefaultMode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetDefaultMode content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetDefaultMode(bleDevice, bOk, content.sublist(1));
  }

  void onRecvSetLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetLevel content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetLevel(bleDevice, bOk, content.sublist(1));
  }

  void onRecvGetLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetLevel content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetLevel(bleDevice, bOk, content.sublist(1));
  }

  void onRecvNotifyLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvNotifyLevel content len ${content.length}');
      return;
    }
    _callbackObj?.onRecvNotifyLevel(bleDevice, content);
  }

  void onRecvSetDefaultLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetDefaultLevel content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetDefaultLevel(bleDevice, bOk);
  }

  void onRecvGetDefaultLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetDefaultLevel content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetDefaultLevel(bleDevice, bOk, content.sublist(1));
  }

  void onRecvSetTimeLen(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvSetTimeLen content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvSetTimeLen(bleDevice, bOk, content.sublist(1));
  }

  void onRecvGetTimeLen(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetTimeLen content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetTimeLen(bleDevice, bOk, content.sublist(1));
  }

  void onRecvNotifyTimeLen(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvNotifyTimeLen content len ${content.length}');
      return;
    }
    _callbackObj?.onRecvNotifyTimeLen(bleDevice, content);
  }

  void onRecvGetBatteryLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetBatteryLevel content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvGetBatteryLevel(bleDevice, bOk, content.sublist(1));
  }

  void onRecvNotifyBatteryLevel(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvNotifyBatteryLevel content len ${content.length}');
      return;
    }
    _callbackObj?.onRecvNotifyBatteryLevel(bleDevice, content);
  }

  void onRecvBigDataTest(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvBigData content len ${content.length}');
      return;
    }
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvBigData(bleDevice, bOk, content.sublist(1));
  }

  void onRecvPropertyCode(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty || content.length < 2) {
      errLog('onRecvPropertyCode content len ${content.length}');
      return;
    }
    //result(1) code len(1) PROPERTY code(n)
    bool bOk = (content[0] == 0);
    _callbackObj?.onRecvPropertyCode(bleDevice, bOk, content.sublist(2));
  }

  /*

  @override
  void onRecvStartSession(BleDevice bleDevice, Uint8List content) {
    // start session resp
    Uint8List sessionKeyAck = Uint8List(4);
    for (int i = 0; i < 4; i++) {
      sessionKeyAck[i] = content[4 + i];
    }

    final sessionKey = bleDevice.sessionKey;

    if (sessionKey != null) {
      bleDevice.sessionKey = doXor(sessionKey, sessionKeyAck, 4);
    }

    bleDevice.bleState.value = BleStatus.sessionKeyReady;
    WorkingDevice workingDevice = Get.find();
    workingDevice.updateUI();

    _callbackObj?.onRecvStartSession(bleDevice, content);
  }

  @override
  void onRecvReadStatus(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvReadStatus(bleDevice, content);
  }

  @override
  void onRecvSetDeviceName(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetDeviceName(bleDevice, content[0] == 1)
        : errLog('onRecvSetDeviceName content len ${content.length}');
  }

  @override
  void onRecvSetDevicePin(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetDevicePin(bleDevice, content[0] == 1)
        : errLog('onRecvSetDevicePin content len ${content.length}');
  }

  @override
  void onRecvKeyAuth(BleDevice bleDevice, Uint8List content) {
    int totalLen = content.length;
    if (totalLen < 2) {
      errLog('onRecvKeyAuth content len ${content.length}');
      return;
    }

    int len = (content[0] << 8) + content[1];
    if (totalLen != len) {
      errLog('onRecvKeyAuth totalLen ${totalLen},Len $len ,totalLen!=buffLen');
      return;
    }
    Uint8List ans = Uint8List(len - 2);
    for (int i = 0; i < len - 2; i++) {
      ans[i] = content[i + 2];
    }
    _callbackObj?.onRecvKeyAuth(bleDevice, ans);
  }

  @override
  void onRecvReverseKeyAuth(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvReverseKeyAuth(bleDevice, content);
  }

  @override
  void onRecvGetVersion(BleDevice bleDevice, Uint8List content) {
    if (content.isEmpty) {
      errLog('onRecvGetVersion content isEmpty');
      return;
    }
    int versionLen = content[0];
    if (versionLen + 1 != content.length) {
      errLog(
          'onRecvGetVersion content len ${content.length},versionLen $versionLen');
      return;
    }
    var version = Uint8List.fromList(content.sublist(1, versionLen + 1));

    _callbackObj?.onRecvGetVersion(bleDevice, utf8.decode(version));
  }

  @override
  void onRecvSyncTime(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSyncTime(bleDevice, content[0] == 1)
        : errLog('onRecvSyncTime content len ${content.length}');
  }

  @override
  void onRecvReadDeviceCode(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvReadDeviceCode(bleDevice, content);
  }

  @override
  void onRecvSetModeParam(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetModeParam(bleDevice, content[0] == 1)
        : errLog('onRecvSetModeParam content len ${content.length}');
  }

  @override
  void onRecvSetStrengthParam(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetStrengthParam(bleDevice, content[0] == 1)
        : errLog('onRecvSetStrengthParam content len ${content.length}');
  }

  @override
  void onRecvSetTimeLenParams(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetTimeLenParams(bleDevice, content[0] == 1)
        : errLog('onRecvSetTimeLenParams content len ${content.length}');
  }

  @override
  void onRecvNotifyModeParam(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvNotifyModeParam(bleDevice, content[0])
        : errLog('onRecvNotifyModeParam content len ${content.length}');
  }

  @override
  void onRecvNotifyStrengthParam(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvNotifyStrengthParam(bleDevice, content[0])
        : errLog('onRecvNotifyStrengthParam content len ${content.length}');
  }

  @override
  void onRecvReadModeParam(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvReadModeParam(bleDevice, content[0])
        : errLog('onRecvReadModeParam content len ${content.length}');
  }

  @override
  void onRecvReadStrengthParam(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvReadStrengthParam(bleDevice, content[0])
        : errLog('onRecvReadStrengthParam content len ${content.length}');
  }

  @override
  void onRecvSetStart(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetStart(bleDevice, content[0] == 1)
        : errLog('onRecvSetStart content len ${content.length}');
  }

  @override
  void onRecvSetStop(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetStop(bleDevice, content[0] == 1)
        : errLog('onRecvSetStop content len ${content.length}');
  }

  @override
  void onRecvNotifyStart(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvNotifyStart(bleDevice);
  }

  @override
  void onRecvNotifyStop(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvNotifyStop(bleDevice);
  }

  @override
  void onRecvSetDefaultMode(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetDefaultMode(bleDevice, content[0] == 1)
        : errLog('onRecvSetDefaultMode content len ${content.length}');
  }

  @override
  void onRecvReadDefaultModeParam(BleDevice bleDevice, Uint8List content) {
    _callbackObj?.onRecvReadDefaultModeParam(bleDevice, content);
  }

  @override
  void onRecvShutdown(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvShutdown(bleDevice, content[0] == 1)
        : errLog('onRecvShutdown content len ${content.length}');
  }

  @override
  void onRecvNotifyShutdown(BleDevice bleDevice, Uint8List content) {
    if (content.length == 1) {
      _callbackObj?.onRecvNotifyShutdown(bleDevice, content[0]);
      Future.delayed(Duration(seconds: content[0]), () {
        BleManager.instance.disconnectDevice(bleDevice);
      });
    } else {
      errLog('onRecvNotifyShutdown content len ${content.length}');
    }
  }

  @override
  void onRecvSetDeviceCode(BleDevice bleDevice, Uint8List content) {
    content.length == 1
        ? _callbackObj?.onRecvSetDeviceCode(bleDevice, content[0] == 1)
        : errLog('onRecvSetDeviceCode content len ${content.length}');
  }
  */
}
