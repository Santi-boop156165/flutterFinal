import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/color_utils.dart';
import '../utils/ui_utils.dart';

class UploadFileWidget extends HookConsumerWidget {
  final Uint8List? image;

  final void Function(Uint8List) callbackFunc;

  final bool isUploading;


  const UploadFileWidget({
    super.key,
    required this.image,
    required this.callbackFunc,
    required this.isUploading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            color: ColorUtils.greyLight,
            child: isUploading
                ? Center(child: UIUtils.loader)
                : image != null
                    ? Image.memory(image!, fit: BoxFit.cover)
                    : Text(
                        AppLocalizations.of(context)!
                            .profile_picture_select_please,
                      ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(ColorUtils.main),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () async {
      final picker = ImagePicker(); // ✅ aquí lo creas
final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

            if (pickedImage == null) return;

            // --- NUEVA API image_cropper ≥ 8.0 ---
            final CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: pickedImage.path,
              uiSettings: [
AndroidUiSettings(
  toolbarTitle: 'Cropper',
  toolbarColor: ColorUtils.main,
  toolbarWidgetColor: Colors.white,
  initAspectRatio: CropAspectRatioPreset.square,
  lockAspectRatio: false,
  aspectRatioPresets: [
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ],
),
IOSUiSettings(
  title: 'Cropper',
  aspectRatioPresets: [
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ],
),
              ],
            );

            if (croppedFile != null) {
              final Uint8List bytes = await croppedFile.readAsBytes();
              callbackFunc(bytes);
            }
          },
          child: Text(
            AppLocalizations.of(context)!.profile_picture_select,
          style: const TextStyle(color: Colors.white),

          ),
        ),
      ],
    );
  }
}
