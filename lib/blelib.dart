library blelib;

import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:blelib/ble/ble_packet.dart';
import 'package:blelib/ble/common_proto_receiver.dart';
import 'package:blelib/ble/define.dart';
import 'package:blelib/ble/kernel/phone_state.dart';
import 'package:blelib/ble/kernel/tool.dart';
import 'package:blelib/ble/product_config.dart';
import 'package:blelib/ble/util.dart';
import 'package:blelib/interface/ble_recv_interface.dart';
import 'package:blelib/ble/common_proto_content_packer.dart';
import 'package:blelib/interface/ble_send_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import 'ble/ble_format.dart';
import 'ble/ble_segment_buf.dart';
import 'ble/data_receiver.dart';
import 'ble/log.dart';
import 'db/local_db.dart';
import 'gps/gps_manager.dart';

part 'ble/config.dart';
part 'ble/kernel/ble_device.dart';
part 'ble/kernel/ble_manager.dart';
part 'ble/kernel/connector.dart';
part 'ble/kernel/scanner.dart';
part 'ble/kernel/data_channel.dart';
part 'ble/data_sender.dart';
part 'ble/common_proto_sender.dart';
part 'models/connect_list.dart';
part 'models/scan_list.dart';
