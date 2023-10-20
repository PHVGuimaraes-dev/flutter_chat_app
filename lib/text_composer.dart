import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TextComposer extends StatefulWidget {
  const TextComposer({super.key, required this.sendMessage});

  final Function({String? text, File? imgFile}) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
              onPressed: () async{
                final XFile? img =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                if(img == null) return;
                widget.sendMessage(imgFile:File(img.path));
              },
              icon: const Icon(Icons.photo_camera)
          ),
          Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration.collapsed(hintText: 'enviar msg'),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  widget.sendMessage(text:text);
                  _reset();
                },
              )
          ),
          IconButton(
              onPressed: _isComposing ? (){
                widget.sendMessage(text:_controller.text);
                _reset();
              } : null,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
