import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/service/service.dart';
import 'package:firebase/themes/shared.dart';
import 'package:firebase/utils/detection/google_ml_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

part 'ui/home_page.dart';
part 'auth/sign_in_page.dart';
part 'auth/sign_up_page.dart';
part 'ui/note_page.dart';
part 'ui/profile_page.dart';
part 'ui/change_password_page.dart';
part 'ui/attendance/attendance/attendance_page.dart';
part 'ui/attendance/history/history_page.dart';
part 'ui/attendance/home_attendance_page.dart';
part 'ui/attendance/permit/leave_page.dart';
part 'ui/attendance/attendance/camera_page.dart';