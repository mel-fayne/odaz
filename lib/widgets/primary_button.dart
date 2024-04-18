import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final RxBool isLoading;
  final String? imagePath;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoading.value
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imagePath != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            imagePath ?? "",
                            height: 40,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    label,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18),
                  ),
                ],
              ),
            ),
    );
  }
}
