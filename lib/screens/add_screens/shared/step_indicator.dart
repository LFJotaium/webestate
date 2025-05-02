import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int maxSteps;

  const StepIndicator({required this.currentStep,required this.maxSteps});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(maxSteps, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: currentStep == index ? 24 : 12,
            height: 12,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: currentStep == index
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
          );
        }),
      ),
    );
  }
}