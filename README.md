

## 使用步骤：

### 父项目中导入blelib依赖

    pubspec.yaml文件中
```
    dependencies: 
        blelib:
            git:
                url: https://gogs.icheer.cn/flutter_lib/blelib.git
                ref: new_protocol
                version: ^0.0.2
```

### 导入blelib库

   ` import 'package:blelib/blelib.dart';`

### 指定BLE基本参数

```
    var productConfig = ProductConfig(
        'name', // 产品客户名称，如'欧宝科技'，该字符是区分各个不同的客户的，是给自己看的，不作为蓝牙过滤或判断的参数
        'aesKey',
        'serviceUuid',
        'characterUuid',
        'notifyCharacterUuid',
        "ABC_",   // 前缀，无前缀过滤的情况，可置空
        '00000005-0000-1000-8000-00805f9b34fb' // uuid过滤参数，前面的32位是设备编码。老项目可不填
        );
    Config.configList.clear();
    Config.addProductConfig(productConfig);
```
        

### 监听BLE连接状态，并设置监听回调处理

```
    BleConnector.instance.listenBleConnectionState(ConnectionStateChange.onConnectionStateChange);
```
```
    // 定义连接状态监听回调
    class ConnectionStateChange {
      static void onConnectionStateChange(ConnectionState state, BleDevice device) async {
        switch (state) {
          case ConnectionState.connected:
            ...
            break;
          case ConnectionState.disconnected:
            ...
            break;
          case ConnectionState.channelReady:
            ...
            break;
        }
      }
    }
```

### 监听共有协议数据，设置数据回调事件处理
```
    class CommonProtoEvent implements BleCommonRecvInterface {

        @override
        void onRecvGetBatteryLevel(BleDevice bleDevice, bool result, Uint8List batteryLevel) {
            // TODO: implement onRecvGetBatteryLevel
        }
        ...
    }
    CommonProtoEvent appDataCallbackTest = CommonProtoEvent();
    BleDataChannel.instance.setCallbackReceiver(appDataCallbackTest);
```
### 监听BLE私有协议数据，并设置数据回调处理

```
    BleDataChannel.instance.listenBleReceiverData(dispatchCmd);
```
    
```
    // 定义接收私有协议数据的回调
    void dispatchCmd(BleDevice device, int cmd, Uint8List content) {
      switch (cmd) {
        case CmdName.temperature:
          break;
        default:
          return;
      }
    }
```
    
### 发起扫描
```
    BleScanner.instance.startScan();
```
```
    // 当扫描到新的设备时，会在ScanModel的scanList中插入新数据并触发RxList的通知
    // 所以用户只需要监视ScanModel.scanList的变化即可知道扫描的结果
    class ScanModel extends GetxController {
         RxList<BleDevice> scanList = <BleDevice>[].obs;
    }
```
### 发起连接
```
    // 用这个接口，会自动断开之前已连接的设备
    BleConnector.instance.switchToDevice(device);
    
    // 用这个接口，不会断开之前已连接的设备
    BleConnector.instance.connectDevice(device);
```
```
    // 当某设备转为连接状态，它会插入到WorkingDevice的bindDevices数组中
    // 所以用户只需要监视WorkingDevice.bindDevices的变化即可知道连接的结果
    class WorkingDevice extends GetxController {
        RxList<BleDevice> bindDevices = <BleDevice>[].obs;
    }
```
### 在UI界面中监听设备数据示例
```
    
    // 监视设备数组变化
    Obx(() => Container(decoration: BoxDecoration(
                        color: (workingDevice.bindDevices.length +scanModel.count() ==0)
                        
    ...
    
    // 监视状态变化
    WorkingDevice workingDevice = Get.find();
    GetBuilder<WorkingDevice>(
      id: 'connect-status',
      builder: (_) {
        return workingDevice.bindDevices[index].bleState.value == BleStatus.matchedCharacteristic
            ? Text("已连接")
    ...        
            
```
### 向BLE发送公用协议数据
```
    CommonProtoSender.instance.sendReadDeviceCode(device);
    
```

### 向BLE发送私有协议数据
```
    sendMessage(device, CmdName.XXX, content);
    
    // 如果在指定某个BLE service中发送，则使用接口：
    sendMessageByUuid(BleDevice device, String serviceUuid, String charaUuid, Uint8List data);
```
    
    
    
### 判断蓝牙是否开启，需要同时判断位置限权是否打开
```
    bool isBleOn = await BleManager.instance.isBleOn();
    bool isGPSOn = await GPSManager.instance.isGPSOn();
    if (!isBleOn || !isGPSOn) {
      ekLog('ble: you should enable bluetooth and location permission');
    }
```

## 最佳实践

1. 需要捕获APP切换到后台并滑动退出的事件，在该事件中明确做disconnect的动作，让设备能及时感知BLE蓝牙的退出。

2. BLE蓝牙设备重命名之后，在收到重命名指令回复之后，需主动做disconnect动作，并将device状态切换到未连接状态。
