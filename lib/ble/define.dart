// ignore_for_file: constant_identifier_names

class CmdOrder {
  /// 获取设备名称
  static const CMD_GET_DEVICE_NAME = 0x0001;
  static const CMD_GET_DEVICE_NAME_CONFIRM = 0x8001;

  /// 设置设备名称
  static const CMD_SET_DEVICE_NAME = 0x0002;
  static const CMD_SET_DEVICE_NAME_CONFIRM = 0x8002;

  /// 读取先天码
  static const CMD_GET_PROPERTY_CODE = 0x0003;
  static const CMD_GET_PROPERTY_CODE_CONFIRM = 0x8003;

  /// 读取固件版本
  static const CMD_GET_FW_VERSION = 0x0004;
  static const CMD_GET_FW_VERSION_CONFIRM = 0x8004;

  /// 同步设备时间
  static const CMD_SYNC_TIME = 0x0005;
  static const CMD_SYNC_TIME_CONFIRM = 0x8005;

  /// 设置产测标志位
  static const CMD_SET_TEST_FLAG = 0x0006;
  static const CMD_SET_TEST_FLAG_CONFIRM = 0x8006;

  /// 读取产测标志位
  static const CMD_GET_TEST_FLAG = 0x0007;
  static const CMD_GET_TEST_FLAG_CONFIRM = 0x8007;

  /// 发送大量数据测试
  static const CMD_BIG_DATA_TEST_RECV = 0x0008;
  static const CMD_BIG_DATA_TEST_RECV_CONFIRM = 0x8008;

  /// 读取易客编码
  static const CMD_GET_EIK_CODE = 0x0009;
  static const CMD_GET_EIK_CODE_CONFIRM = 0x8009;

  /// 设置先天码
  static const CMD_SET_PROPERTY_CODE_TEST = 0x000A;
  static const CMD_SET_PROPERTY_CODE_TEST_CONFIRM = 0x800A;

  /// 设置易客码
  static const CMD_SET_EIKER_CODE_TEST = 0x000B;
  static const CMD_SET_EIKER_CODE_TEST_CONFIRM = 0x800B;

//optional;
  static const CMD_GET_DEV_STATUS = 0x2000; //读取设备的状态;
  static const CMD_GET_DEV_STATUS_CONFIRM = 0xA000;

  static const CMD_START = 0x2001;
  static const CMD_START_CONFIRM = 0xA001;
  static const CMD_NOTIFY_START = 0xA002;
  static const CMD_NOTIFY_START_CONFIRM = 0x2002;

  static const CMD_PAUSE = 0x2003;
  static const CMD_PAUSE_CONFIRM = 0xA003;
  static const CMD_NOTIFY_PAUSE = 0xA004;
  static const CMD_NOTIFY_PAUSE_CONFIRM = 0x2004;

  static const CMD_STOP = 0x2005;
  static const CMD_STOP_CONFIRM = 0xA005;
  static const CMD_NOTIFY_STOP = 0xA006;
  static const CMD_NOTIFY_STOP_CONFIRM = 0x2006;
  static const CMD_SHUTDOWN = 0x2007;
  static const CMD_SHUTDOWN_CONFIRM = 0xA007;
  static const CMD_NOTIFY_SHUTDOWN = 0xA008;
  static const CMD_NOTIFY_SHUTDOWN_CONFIRM = 0x2008;
  static const CMD_SET_MODE = 0x200A;
  static const CMD_SET_MODE_CONFIRM = 0xA00A;
  static const CMD_GET_MODE = 0x200B;
  static const CMD_GET_MODE_CONFIRM = 0xA00B;
  static const CMD_NOTIFY_MODE = 0xA00C;
  static const CMD_NOTIFY_MODE_CONFIRM = 0x200C;
  static const CMD_SET_DEFAULT_MODE = 0x200D;
  static const CMD_SET_DEFAULT_MODE_CONFIRM = 0xA00D;
  static const CMD_GET_DEFAULT_MODE = 0x200E;
  static const CMD_GET_DEFAULT_MODE_CONFIRM = 0xA00E;

  static const CMD_SET_LEVEL = 0x200F;
  static const CMD_SET_LEVEL_CONFIRM = 0xA00F;
  static const CMD_GET_LEVEL = 0x2010;
  static const CMD_GET_LEVEL_CONFIRM = 0xA010;
  static const CMD_NOTIFY_LEVEL = 0xA011;
  static const CMD_NOTIFY_LEVEL_CONFIRM = 0x2011;
  static const CMD_SET_DEFAULT_LEVEL = 0x2012;
  static const CMD_SET_DEFAULT_LEVEL_CONFIRM = 0xA012;
  static const CMD_GET_DEFAULT_LEVEL = 0x2013;
  static const CMD_GET_DEFAULT_LEVEL_CONFIRM = 0xA013;

  static const CMD_SET_TIME_LEN = 0x2014;
  static const CMD_SET_TIME_LEN_CONFIRM = 0xA014;
  static const CMD_GET_TIME_LEN = 0x2015;
  static const CMD_GET_TIME_LEN_CONFIRM = 0xA015;
  static const CMD_NOTIFY_TIME_LEN = 0xA016;
  static const CMD_NOTIFY_TIME_LEN_CONFIRM = 0x2016;

  static const CMD_GET_BATTERY_LEVEL = 0x2017;
  static const CMD_GET_BATTERY_LEVEL_CONFIRM = 0xA017;
  static const CMD_NOTIFY_BATTERY_LEVEL = 0xA018;
  static const CMD_NOTIFY_BATTERY_LEVEL_CONFIRM = 0x2018;
}
