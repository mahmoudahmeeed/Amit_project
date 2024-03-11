import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/app_images.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search messages....',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(209, 213, 219, 1),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(Assets.imagesLargeImagesNoMessage),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You have not received any messages',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(17, 24, 39, 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Once your application has reached the interview stage, you will get a message from the recruiter.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(107, 114, 128, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
