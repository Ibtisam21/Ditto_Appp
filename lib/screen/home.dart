import 'package:ditto/model/profile.dart';
import 'package:ditto/screen/event.dart';
import 'package:ditto/screen/profil.dart';
// import '../../../../Desktop/Flutter_App/chatbot-chatgpt/lib/widgets/the_wall.dart';
import 'package:ditto/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import '../constants/constants.dart';
import 'package:sqlite3/sqlite3.dart';

import '../widget/the_wall.dart';

final db = sqlite3.openInMemory();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String projectUrl = 'https://github.com/ethicnology/dispute';
    final profil = context.watch<MProfile>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('nostr dispute'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(),
            const Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 25, left: 10, right: 10),
              child: SelectableText(
                'A dispute is a disagreement or argument about something. It can refer to a disagreement between individuals or groups, or it can refer to a disagreement about a specific issue or topic.',
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 25,
                left: 10,
                right: 10,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackgroundColor,
                  minimumSize: const Size(400, 40),
                  maximumSize: const Size(400, 40),
                ),
                onPressed: () {},
                child: InkWell(
                  child: Text(projectUrl),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: projectUrl));
                    displaySnackBar(
                        context, 'copied to clipboard: $projectUrl');
                  },
                ),
              ),
            ),
            TheWallWidget(
              channel: WebSocketChannel.connect(Uri.parse(profil.relay)),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: buttonBorderColor, width: 3),
                borderRadius: BorderRadius.circular(100)),
            tooltip: 'Send an event',
            heroTag: "send_event",
            child: const Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: buttonBorderColor, width: 3),
                borderRadius: BorderRadius.circular(100)),
            tooltip: 'Edit your profile',
            heroTag: "profil",
            child: const Icon(Icons.vpn_key),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
