import 'package:flutter/material.dart';
import 'package:ttlock_flutter/ttlock.dart';
import 'package:bmprogresshud/progresshud.dart';
import 'package:ttlock_flutter_example/api/locks/delete_lock.dart';
import 'package:ttlock_flutter_example/api/locks/get_lock_list.dart';
import 'package:ttlock_flutter_example/phurin/add_device.dart';

import 'phurin/oder_press.dart';
import 'phurin/order_lock.dart';
import 'phurin/setting_lock.dart';

class LockPage extends StatefulWidget {
  LockPage(
      {Key? key,
      required this.title,
      required this.lockData,
      required this.lockMac,
      required this.lockId})
      : super(key: key);
  final String title;
  final String lockData;
  final String lockMac;
  final String lockId;
  @override
  _LockPageState createState() => _LockPageState(lockData, lockMac, lockId);
}

enum Command {
  resetLock,
  unlock,
  resetEkey,
  modifyAdminPasscode,
  getLockTime,
  setLockTime,
  getLockPower,
  getLockOperateRecord,
  getLockSwitchState,
  customPasscode,
  modifyPasscode,
  deletePasscode,
  resetPasscode,
  getAllValidPasscode,
  addCard,
  modifyCard,
  deleteCard,
  clearCard,
  getAllValidCard,
  addFingerprint,
  modifyFingerprint,
  deleteFingerprint,
  clearFingerprint,
  getAllValidFingerprint,

  getLockAutomaticLockingPeriodicTime,
  setLockAutomaticLockingPeriodicTime,
  getLockRemoteUnlockSwitchState,
  setLockRemoteUnlockSwitchState,
  getLockAudioSwitchState,
  setLockAudioSwitchState,
  getLockSoundVolumeType,
  setLockSoundVolumeType,
  addPassageMode,
  clearAllPassageModes,

  activateLiftFloors,
  setLiftControlableFloors,
  setLiftWorkMode,

  setPowerSaverWorkMode,
  setPowerSaverControlableLock,

  // setDoorSensorSwitch,
  // getDoorSensorSwitch,
  // getDoorSensorState,

  setHotelCardSector,
  setHotelData,

  getLockSystemInfo,

  setNBServerInfo,
  getAdminPasscode,

  getPasscodeVerificationParams,
  recoveryCard,
  getLockVersion,
  scanWifi,
  configWifi,
  configServer,
  getWifiInfo,
  configIp
}

class _LockPageState extends State<LockPage> {
  bool isLoading = false;
  List<Map<String, Command>> _commandList = [
    {"Reset Lock": Command.resetLock},
    {"Unlock": Command.unlock},
    {"Get Power": Command.getLockPower},
    {"Get Lock Time": Command.getLockTime},
    {"Set Lock Time": Command.setLockTime},
    {"Get Lock Operate Record": Command.getLockOperateRecord},
    {"Reset EKey": Command.resetEkey},
    {"Modify Admin Passcode To 1234": Command.modifyAdminPasscode},
    {"Get Lock Switch State": Command.getLockSwitchState},
    {"Custom Passcode 6666": Command.customPasscode},
    {"Modify Passcode 6666 -> 7777": Command.modifyPasscode},
    {"Get All Passcode": Command.getAllValidPasscode},
    {"Delete Passcode 7777": Command.deletePasscode},
    {"Reset Passcode": Command.resetPasscode},
    {"Add Card": Command.addCard},
    {"Modify Card valid Date": Command.modifyCard},
    {"Get All Cards": Command.getAllValidCard},
    {"Delete Card": Command.deleteCard},
    {"Clear All Cards": Command.clearCard},
    {"Add Fingerprint": Command.addFingerprint},
    {"Modify Fingerprint": Command.modifyFingerprint},
    {"Get All Fingerprints": Command.getAllValidFingerprint},
    {"Delete Fingerprint": Command.deleteFingerprint},
    {"Cleaer All Fingerprints": Command.clearFingerprint},
    {
      "Get Lock Automatic Locking Periodic Time":
          Command.getLockAutomaticLockingPeriodicTime
    },
    {
      "Set Lock Automatic Locking Periodic Time":
          Command.setLockAutomaticLockingPeriodicTime
    },
    {
      "Get Lock Remote Unlock Switch State":
          Command.getLockRemoteUnlockSwitchState
    },
    {
      "Set Lock Remote Unlock Switch State":
          Command.setLockRemoteUnlockSwitchState
    },
    {"Get Lock Audio Switch State": Command.getLockAudioSwitchState},
    {"Set Lock Audio Switch State": Command.setLockAudioSwitchState},
    {"Get Lock Sound Volume Type": Command.getLockSoundVolumeType},
    {"Set Lock Sound Volume Type": Command.setLockSoundVolumeType},
    {"Add Passage Mode": Command.addPassageMode},
    {"Clear All Passage Mode": Command.clearAllPassageModes},
    {"Activate Lift Floors": Command.activateLiftFloors},
    {"Set Lift Controlable Floors": Command.setLiftControlableFloors},
    {"Set Lift Work Mode": Command.setLiftWorkMode},
    {"Set Power Saver Work Mode": Command.setPowerSaverWorkMode},
    {"Set Power Saver Controlable": Command.setPowerSaverControlableLock},
    // {"Set Door Sensor Switch": Command.setDoorSensorSwitch},
    // {"Get Door Sensor Switch": Command.getDoorSensorSwitch},
    // {"Get Door Sensor State": Command.getDoorSensorState},
    {"Set Hotel Card Sector": Command.setHotelCardSector},
    {"Set Hotel Data": Command.setHotelData},
    {"Get Lock System Info": Command.getLockSystemInfo},
    {"Set Nb Server Info": Command.setNBServerInfo},
    {"Get Admin Passcode": Command.getAdminPasscode},
    {"Get Passcode Verification Param": Command.getPasscodeVerificationParams},
    {"Recovery Card Data": Command.recoveryCard},
    {"Get LockVersion": Command.getLockVersion},
    {"Wifi lock scan nearby wifi": Command.scanWifi},
    {"Wifi lock config wifi": Command.configWifi},
    {"Wifi lock config server": Command.configServer},
    {"Wifi lock get wifi info": Command.getWifiInfo},
    {"Wifi lock config ip": Command.configIp}
  ];

  String note =
      'Note: You need to reset the lock befor pop current page,otherwise the lock will can\'t be initialized again';

  String lockData = '';
  String lockMac = '';
  String lockId = '';
  String? addCardNumber;
  String? addFingerprintNumber;
  BuildContext? _context;

  _LockPageState(String lockData, String lockMac, String lockId) {
    super.initState();
    this.lockData = lockData;
    this.lockMac = lockMac;
    this.lockId = lockId;
  }

  void _showLoading(String text) {
    ProgressHud.of(_context!).showLoading(text: text);
  }

  void _showSuccessAndDismiss(String text) {
    ProgressHud.of(_context!).showSuccessAndDismiss(text: text);
  }

  void _showErrorAndDismiss(TTLockError errorCode, String errorMsg) {
    ProgressHud.of(_context!).showErrorAndDismiss(
        text: 'errorCode:$errorCode errorMessage:$errorMsg');
  }

  @override
  void dispose() {
    //You need to reset lock, otherwise the lock will can't be initialized again
    //TTLock.resetLock(lockData, () {}, (errorCode, errorMsg) {});
    super.dispose();
  }

  void commandClick(Command command, BuildContext context,
      {String? passcode, String? oldPasscode, String? newPasscode}) async {
    _showLoading('');
    int startDate = DateTime.now().millisecondsSinceEpoch;
    int endDate = startDate + 3600 * 24 * 30 * 1000;

    switch (command) {
      case Command.resetLock:
        print(lockData);
        TTLock.resetLock(lockData, () async {
          print("Reset lock success");
          String message = await deleteLock(lockId);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AddDevice()),
            (route) => false, // Remove all existing routes from the stack
          );
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.unlock:
        //Note: the lockData is not contain userId and valid date.
        //If you want to get lockData contain userId and valid date please get lockData from api https://open.ttlock.com/doc/api/v3/key/list
        TTLock.controlLock(lockData, TTControlAction.unlock,
            (lockTime, electricQuantity, uniqueId) {
          _showSuccessAndDismiss(
              "Unlock Success lockTime:$lockTime electricQuantity:$electricQuantity uniqueId:$uniqueId");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getLockPower:
        TTLock.getLockPower(lockData, (electricQuantity) {
          _showSuccessAndDismiss("The power: $electricQuantity ");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getLockTime:
        TTLock.getLockTime(lockData, (lockTimestamp) {
          _showSuccessAndDismiss("Time: $lockTimestamp ");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setLockTime:
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        TTLock.setLockTime(timestamp, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.getLockOperateRecord:
        TTLock.getLockOperateRecord(TTOperateRecordType.latest, lockData,
            (operateRecord) {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.resetEkey:
        TTLock.resetEkey(lockData, (lockData) {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.modifyAdminPasscode:
        TTLock.modifyAdminPasscode('1234', lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.getLockSwitchState:
        TTLock.getLockSwitchState(lockData, (state) {
          _showSuccessAndDismiss(state.toString());
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.customPasscode:
        TTLock.supportFunction(TTLockFuction.managePasscode, lockData,
            (isSupport) {
          // not support
          if (!isSupport) {
            _showErrorAndDismiss(
                TTLockError.fail, "not support custom passcode");
            return;
          }

          TTLock.createCustomPasscode(
              passcode ?? "6666", startDate, endDate, lockData, () {
            _showSuccessAndDismiss("Success");
          }, (errorCode, errorMsg) {
            _showErrorAndDismiss(errorCode, errorMsg);
          });
        });

        break;

      case Command.modifyPasscode:
        TTLock.supportFunction(TTLockFuction.managePasscode, lockData,
            (isSupport) {
          // not support
          if (!isSupport) {
            _showErrorAndDismiss(
                TTLockError.fail, "Not support modify passcode");
            return;
          }
          TTLock.modifyPasscode(
              oldPasscode ?? '', newPasscode, startDate, endDate, lockData, () {
            _showSuccessAndDismiss("Success");
          }, (errorCode, errorMsg) {
            _showErrorAndDismiss(errorCode, errorMsg);
          });
        });

        break;
      case Command.deletePasscode:
        TTLock.supportFunction(TTLockFuction.managePasscode, lockData,
            (isSupport) {
          if (isSupport) {
            TTLock.deletePasscode(passcode ?? '', lockData, () {
              _showSuccessAndDismiss("Success");
            }, (errorCode, errorMsg) {
              _showErrorAndDismiss(errorCode, errorMsg);
            });
          } else {
            _showErrorAndDismiss(
                TTLockError.fail, 'Not support delete passcode');
          }
        });
        break;

      case Command.resetPasscode:
        TTLock.resetPasscode(lockData, (lockData) {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.addCard:
        TTLock.addCard(null, startDate, endDate, lockData, () {
          _showLoading('Waiting for add card ...');
        }, (cardNumber) {
          addCardNumber = cardNumber;
          _showSuccessAndDismiss("cardNumber: $cardNumber");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.modifyCard:
        if (addCardNumber == null) {
          _showErrorAndDismiss(
              TTLockError.cardNotExist, 'please add an ic card first');
          return;
        }
        TTLock.modifyCardValidityPeriod(
            addCardNumber!, null, startDate, endDate, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.deleteCard:
        if (addCardNumber == null) {
          _showErrorAndDismiss(
              TTLockError.cardNotExist, 'please add an ic card first');
          return;
        }
        TTLock.deleteCard(addCardNumber!, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.clearCard:
        TTLock.clearAllCards(lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.addFingerprint:
        TTLock.addFingerprint(null, startDate, endDate, lockData,
            (currentCount, totalCount) {
          _showLoading("currentCount:$currentCount  totalCount:$totalCount");
        }, (fingerprintNumber) {
          this.addFingerprintNumber = fingerprintNumber;
          _showSuccessAndDismiss("fingerprintNumber: $fingerprintNumber");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.modifyFingerprint:
        if (addFingerprintNumber == null) {
          _showErrorAndDismiss(
              TTLockError.fingerprintNotExist, 'please add fingerprint first');
          return;
        }
        TTLock.modifyFingerprintValidityPeriod(
            addFingerprintNumber!, null, startDate, endDate, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.deleteFingerprint:
        if (addFingerprintNumber == null) {
          _showErrorAndDismiss(
              TTLockError.fingerprintNotExist, 'please add fingerprint first');
          return;
        }
        TTLock.deleteFingerprint(addFingerprintNumber!, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.clearFingerprint:
        TTLock.clearAllFingerprints(lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.getLockAutomaticLockingPeriodicTime:
        TTLock.getLockAutomaticLockingPeriodicTime(lockData,
            (currentTime, minTime, maxTime) {
          _showSuccessAndDismiss(
              "currentTime:$currentTime minTime:$minTime maxTime:$maxTime");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.setLockAutomaticLockingPeriodicTime:
        TTLock.setLockAutomaticLockingPeriodicTime(8, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.getLockRemoteUnlockSwitchState:
        TTLock.getLockRemoteUnlockSwitchState(lockData, (isOn) {
          _showSuccessAndDismiss("SwitchOn: $isOn");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.setLockRemoteUnlockSwitchState:
        TTLock.setLockRemoteUnlockSwitchState(true, lockData, (lockData) {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.getLockAudioSwitchState:
        TTLock.getLockConfig(TTLockConfig.audio, lockData, (isOn) {
          _showSuccessAndDismiss("SwitchOn: $isOn");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.setLockAudioSwitchState:
        TTLock.setLockConfig(TTLockConfig.audio, true, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.setLockSoundVolumeType:
        TTLock.setLockSoundWithSoundVolume(
            TTSoundVolumeType.fouthLevel, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.getLockSoundVolumeType:
        TTLock.getLockSoundWithSoundVolume(lockData, (ttLocksoundVolumeType) {
          _showSuccessAndDismiss("sound volume type: $ttLocksoundVolumeType");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;

      case Command.addPassageMode:
        int startTime = 8 * 60; //8:00 am
        int endTime = 17 * 60; //17:00 pm
        List<int> weekly = [1, 2]; // [Monday，Tuesday]

        TTLock.addPassageMode(TTPassageModeType.weekly, weekly, null, startTime,
            endTime, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.clearAllPassageModes:
        TTLock.clearAllPassageModes(lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.activateLiftFloors:
        TTLock.activateLift("1,2,3", lockData,
            (lockTime, electricQuantity, uniqueId) {
          _showSuccessAndDismiss(
              "Active lift florrs success lockTime:$lockTime electricQuantity:$electricQuantity uniqueId:$uniqueId");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setLiftControlableFloors:
        TTLock.setLiftControlable("3", lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setLiftWorkMode:
        TTLock.setLiftWorkMode(TTLiftWorkActivateType.allFloors, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setPowerSaverWorkMode:
        TTLock.setPowerSaverWorkMode(TTPowerSaverWorkType.allCards, lockData,
            () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setPowerSaverControlableLock:
        TTLock.setPowerSaverControlableLock(this.lockMac, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      // case Command.setDoorSensorSwitch:
      //   TTLock.setDoorSensorLockingSwitchState(true, lockData, () {
      //     _showSuccessAndDismiss("Success");
      //   }, (errorCode, errorMsg) {
      //     _showErrorAndDismiss(errorCode, errorMsg);
      //   });
      //   break;
      // case Command.getDoorSensorSwitch:
      //   TTLock.getDoorSensorLockingSwitchState(lockData, (isOn) {
      //     _showSuccessAndDismiss(isOn.toString());
      //   }, (errorCode, errorMsg) {
      //     _showErrorAndDismiss(errorCode, errorMsg);
      //   });
      //   break;
      // case Command.getDoorSensorState:
      //   TTLock.getDoorSensorState(lockData, (isOn) {
      //     _showSuccessAndDismiss(isOn.toString());
      //   }, (errorCode, errorMsg) {
      //     _showErrorAndDismiss(errorCode, errorMsg);
      //   });
      //   break;
      case Command.setHotelCardSector:
        TTLock.setHotelCardSector("1,4", lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setHotelData:
        String hotelData = "";
        int building = 0;
        int floor = 0;
        TTLock.setHotel(hotelData, building, floor, lockData, () {
          _showSuccessAndDismiss("Success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getAllValidPasscode:
        TTLock.getAllValidPasscode(lockData, (passcodeList) {
          _showSuccessAndDismiss(passcodeList.toString());
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getAllValidCard:
        TTLock.getAllValidCards(lockData, (cardList) {
          _showSuccessAndDismiss(cardList.toString());
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getAllValidFingerprint:
        TTLock.getAllValidFingerprints(lockData, (fingerprintList) {
          _showSuccessAndDismiss(fingerprintList.toString());
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getLockSystemInfo:
        TTLock.getLockSystemInfo(lockData, (lockSystemInfoModel) {
          _showSuccessAndDismiss(lockSystemInfoModel.modelNum!);
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.setNBServerInfo:
        String port = "5683";
        String ip = "117.60.157.137";
        TTLock.setLockNbAddress(ip, port, lockData, (electricQuantity) {
          _showSuccessAndDismiss("electricQuantity: $electricQuantity");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getAdminPasscode:
        TTLock.getAdminPasscode(lockData, (adminPasscode) {
          _showSuccessAndDismiss("AdminPasscode: $adminPasscode");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getPasscodeVerificationParams:
        TTLock.getPasscodeVerificationParams(lockData, (lockData) {
          _showSuccessAndDismiss("Get Passcode Verification Params success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.recoveryCard:
        String cardNumber = "123458970";
        int startDate = DateTime.now().millisecondsSinceEpoch;
        int endDate =
            DateTime.now().millisecondsSinceEpoch + 24 * 60 * 60 * 1000;
        TTLock.recoverCard(cardNumber, startDate, endDate, lockData, () {
          _showSuccessAndDismiss("success:$cardNumber");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getLockVersion:
        TTLock.getLockVersion(lockMac, (lockVersion) {
          _showSuccessAndDismiss("Get LockVersion success:$lockVersion");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.scanWifi:
        TTLock.scanWifi(lockData, (finished, wifiList) {
          _showSuccessAndDismiss("scan wifi");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.configWifi:
        TTLock.configWifi("sciener", "sciener.com", lockData, () {
          _showSuccessAndDismiss("Config wifi success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.configServer:
        TTLock.configServer("wifilock.ttlock.com", "4999", lockData, () {
          _showSuccessAndDismiss("Config server success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.getWifiInfo:
        TTLock.getWifiInfo(lockData, (wifiInfo) {
          _showSuccessAndDismiss(wifiInfo.toString());
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      case Command.configIp:
        Map paramMap = Map();
        paramMap["type"] = TTIpSettingType.DHCP.index;
        //for static ip setting
        // paramMap["type"] = TTIpSettingType.STATIC_IP.index;
        // paramMap["ipAddress"] = "192.168.1.100";
        // paramMap["subnetMask"] = "255.255.255.0";
        // paramMap["router"] = "192.168.1.1";
        // paramMap["preferredDns"] = "xxx.xxx.xxx.xxx";
        // paramMap["alternateDns"] = "xxx.xxx.xxx.xxx";

        TTLock.configIp(paramMap, lockData, () {
          _showSuccessAndDismiss("config ip success");
        }, (errorCode, errorMsg) {
          _showErrorAndDismiss(errorCode, errorMsg);
        });
        break;
      default:
    }
  }

  Widget getListView() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 2, color: Colors.green);
        },
        itemCount: _commandList.length,
        itemBuilder: (context, index) {
          Map<String, Command> map = _commandList[index];
          String title = '${map.keys.first}';
          String subtitle = index == 0 ? note : '';
          return ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            onTap: () {
              commandClick(map.values.first, context);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
            weight: 500,
          ),
        ),
        title: Center(
          child: Text(
            'TTlock',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              commandClick(Command.resetLock, context);
            },
            icon: Icon(Icons.wifi_off),
          )
        ],
      ),
      body: Material(
        child: ProgressHud(
          child: Container(
            child: Builder(builder: (context) {
              _context = context;
              return Center(
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Register_lock',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 50,
                  ),
                  Transform.scale(
                    scale: 4,
                    child: GestureDetector(
                      onTap: () {
                        commandClick(Command.unlock, context);
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade100,
                              child: Image.asset(
                                // you can replace this with Image.asset
                                'assets/image/lockLogo.png',
                                fit: BoxFit.cover,
                                height: 27,
                                width: 27,
                              ),
                            ),
                            // you can replace
                            isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue.shade600),
                                    strokeWidth: 2,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.4),
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue.shade600.withOpacity(0)),
                                    strokeWidth: 2,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.4),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Touch to Unlock, Hold to Lock',
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(),
                  Row(
                    children: [
                      SizedBox(width: 18),
                      OrderItem('assets/image/ekey.png', 'eKeys', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPress(
                                    'eKeys',
                                    'Send eKey',
                                    lockId: lockId,
                                  )),
                        );
                        print('555');
                      }),
                      OrderItem('assets/image/passcode.png', 'Passcodes', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPress(
                                    'Passcodes',
                                    'Generate Passcode',
                                    lockId: lockId,
                                  )),
                        );
                      }),
                      OrderItem('assets/image/card.png', 'Cards', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPress(
                                    'Cards',
                                    'Generate Passcode',
                                    lockId: lockId,
                                  )),
                        );
                      }),
                      OrderItem('assets/image/finger.png', 'Fingerprints', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPress(
                                    'Fingerprint',
                                    'Add Fingerprint',
                                    lockId: lockId,
                                  )),
                        );
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 18),
                      OrderItem('assets/image/remoteicon.png', 'Remote', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPress(
                                    'Remote',
                                    'Add Remote',
                                    lockId: lockId,
                                  )),
                        );
                      }),
                      OrderItem(
                          'assets/image/authorized.png', 'Authorized Admin',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPress(
                                    'Authorized Admin',
                                    'Create Admin',
                                    lockId: lockId,
                                  )),
                        );
                      }),
                      OrderItem('assets/image/records.png', 'Records', () {}),
                      OrderItem('assets/image/setting.png', 'Settings', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingLock()),
                        );
                      }),
                    ],
                  ),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
