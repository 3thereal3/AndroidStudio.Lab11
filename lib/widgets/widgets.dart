import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../color_provider.dart';

class RGBSliderSection extends StatelessWidget {
  const RGBSliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Column(
      children: [
        RGBSlider(
          label: 'Red',
          value: colorProvider.red,
          color: Colors.red,
          onChanged: (value) => colorProvider.updateRed(value),
        ),
        RGBSlider(
          label: 'Green',
          value: colorProvider.green,
          color: Colors.green,
          onChanged: (value) => colorProvider.updateGreen(value),
        ),
        RGBSlider(
          label: 'Blue',
          value: colorProvider.blue,
          color: Colors.blue,
          onChanged: (value) => colorProvider.updateBlue(value),
        ),
      ],
    );
  }
}

class RGBSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const RGBSlider({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              value.toInt().toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.3),
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            trackHeight: 4.0,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ColorProvider>(context).color;
    final hexCode = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Прямоугольник для предварительного просмотра цвета
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16), // Отступ между блоком и HEX-кодом
        // Блок с HEX-кодом и функцией копирования
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: hexCode));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('HEX-код скопирован: $hexCode'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                hexCode,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.copy,
                color: Colors.grey.shade700,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
