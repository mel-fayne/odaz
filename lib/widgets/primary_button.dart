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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 5),
      ),
      child: Obx(
        () => isLoading.value
            ? const CircularProgressIndicator(
                strokeWidth: 2.0,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imagePath != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            imagePath ?? "",
                            height: 30,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    label,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
