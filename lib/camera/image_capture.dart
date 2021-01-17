import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {

  //Create new instance of the picker
  final _picker = ImagePicker();

  //Active image file
  File _imageFile;

 //Select image by gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await _picker.getImage(source: source);

    setState(() {
      if (selected != null) {
        _imageFile = File(selected.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //Cropper plugin
  Future<void> _cropImage() async {
    PickedFile cropped = (await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
//      maxHeight: 10,
//      maxWidth: 5,

    )) as PickedFile;


    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  //Remove file
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: SizedBox(height: height*0.1,
        child: BottomAppBar(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height*0.065,
                width: width*0.4,
                child: RaisedButton.icon(label: Text('Camera', style: TextStyle(fontSize: 16),),
                  color: Colors.blueGrey[400],
                  splashColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                  ),
                  icon: Icon(Icons.photo_camera, size: 30,),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ),
              SizedBox(
                height: height*0.065,
                width: width*0.4,
                child: RaisedButton.icon(label: Text('Photos', style: TextStyle(fontSize: 16),),
                  color: Colors.blueGrey[400],
                  splashColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  icon: Icon(Icons.photo, size: 30,),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: width,
        child: ListView(
          children: [
            if (_imageFile != null) ...[

              Image.file(_imageFile),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 60, width: 100,
                    child: FlatButton(
                      child: Icon(Icons.crop, size: 30,),
                      onPressed: _cropImage,
                    ),
                  ),
                  SizedBox(height: 60, width: 100,
                    child: FlatButton(
                      child: Icon(Icons.refresh, size: 30,),
                      onPressed: _clear,
                    ),
                  ),
                  SizedBox(/*height: 60, width: 100,*/
                      child: Uploader(file: _imageFile)
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, @required this.file}) :super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://ibuy-mac-1.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent = event != null
              ? event.bytesTransferred / event.totalByteCount
              : 0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_uploadTask.isComplete)
                FlatButton(
                  child: Text('Done', style: TextStyle(fontSize: 16),),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/home');
                  },
                ),

              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow, size: 30,),
                  onPressed: _uploadTask.resume,
              ),

              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause, size: 30,),
                  onPressed: _uploadTask.pause,
              ),

              // SizedBox(
              //   height: 10,
              //   width: 100,
              //   child: LinearProgressIndicator(minHeight: 5,
              //       value: progressPercent
              //   ),
              // ),
             // Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
            ],

          );
        }
      );

    } else {
      return FlatButton(
        child: Text("Save", style: TextStyle(fontSize: 16),),
        onPressed: _startUpload,
      );
    }
  }
}
