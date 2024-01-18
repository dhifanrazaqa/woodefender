import 'package:flutter/material.dart';

class AuthoritiesScreen extends StatefulWidget {
  const AuthoritiesScreen({super.key});

  @override
  State<AuthoritiesScreen> createState() => _AuthoritiesScreenState();
}

class _AuthoritiesScreenState extends State<AuthoritiesScreen> {
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'The Authorities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black,
                  child: const Text(
                    'Article of Law',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
                const Text(
                  'UU ITE (Electronic Information and Transactions) Article 27 paragraphs 1 - 4',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('1. Every person intentionally and without right distributes and/or transmits and/or makes accessible Electronic Information and/or Electronic Documents containing content that violates decency.\n2. Every person intentionally and without right distributes and/or transmits and/or makes accessible Electronic Information and/or Electronic Documents containing gambling content.\n3. Every person intentionally, and without right, distributes and/or transmits and/or makes accessible Electronic Information and/or Electronic Documents containing content of insult and/or defamation of character.\n4. Every person intentionally and without right distributes and/or transmits and/or makes accessible Electronic Information and/or Electronic Documents containing extortion and/or threats.\n\nViolation of Article 27 paragraphs (1), (2), and (4) of the ITE Law is punishable by imprisonment for a maximum of 6 years and/or a fine of up to Rp1 billion. Meanwhile, the violation of Article 27 paragraph (3) of the ITE Law is punishable by a maximum prison sentence of 4 years and/or a maximum fine of Rp750 million.',
                      maxLines: descTextShowFlag ? 30 : 2,textAlign: TextAlign.justify),
                    InkWell(
                      onTap: () {
                        setState(() {
                          descTextShowFlag = !descTextShowFlag; 
                        }); 
                      },
                      child: descTextShowFlag ?
                      const Text("Show Less",style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline, decorationColor: Colors.grey),)
                      :
                      const Text("Show More",style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline, decorationColor: Colors.grey)),
                    ),
                  ],
                ),
                Divider(color: Colors.grey[200],),
                const SizedBox(height: 18,),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black,
                  child: const Text(
                    'Independent Rehabilitation Tips',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
                const Text(
                  'Psychic trauma is a condition that can arise due to several factors, including having had a bad experience in the past. This condition must be treated immediately!\nHere are the initial recovery steps you can take:\n1. Think Positive and Focus on the Important Things\n2. Breathing Exercises\n3. Stop Blaming Yourself\n4. Return to Daily Routine\n5. Consult an expert (Psychologist or Psychiatrist)',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify
                ),
                Divider(color: Colors.grey[200],),
                const SizedBox(height: 18,),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black,
                  child: const Text(
                    'Reporting Procedure',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
                const Text(
                  'By Kominfo: \n1. Visit the aduankonten.id page\n2. Create an account by filling in the requested data, such as name, email address, ID number, and telephone number\n3. Once the account has been successfully created, log in to your account\n4. Click the "Create New Complaint" button\n5. Select the content category you want to report\n6. Enter the URL or link of the content you want to report\n7. Write a brief description of the content you wish to report\n8. Click the "Submit" button',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify
                ),
                Divider(color: Colors.grey[200],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}