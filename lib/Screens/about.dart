import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final String t1 = 'Dear Hostellers,\n\n';
  final String t2 =
      'Spread your wings and soar! “Be like the bird that, pausing in her flight awhile on boughs too slight, feels them give way beneath her, and yet sings, knowing that she hath wings.” The world has your name on it! \n\n';
  final String t3 =
      'The Heritage of Jesuit Education! By joining in Loyola Hostel, you share in a heritage nearly five hundred years old, a gift given to thousands of students across the ages by St. Ignatius Loyola, the founder of the Jesuits. The campus is about nothing less than empowerment and transformation: Cared! “CuraPersonalis!” “Personal Care of the Individual” is a hallmark of Jesuit education. You are “Challenged - Awakened-Empowered” to be “Men of Competence, Conscience and Commitment to the cause of Human Family with a difference and to make a difference.” “The measure of Jesuit universities is not what our students do but who they become.” - V. Rev. Peter- Hans Kolvenbach, S.J. Remember that this hostel is not “Jesuit” just because there are Jesuits walking around campus. Ignatius legacy is for all men and women. As partners in the heritage of Ignatius something you share with hundreds of thousands of other students educated at Jesuit universities and colleges around the world. With this heritage comes a certain privilege, to be responsible! You must help shape the living tradition of which you are now an important part.\n\n ';
  final String t4 =
      'In all you do, strive for the magis, for excellence, not as the world defines it, but as it is illustrated in the rules and regulations. Ignatius wrote thousands of letters in his lifetime, offering direction to Jesuits whom he sent throughout the world on various missions. He often closed his letters with words intended to challenge as much as to inspire. They are fitting words to leave you with now as you look forward to your years at Hostel: “Go, and set the world on fire!” and I add with another “Spread your wings and soar!';
  final String t5 =
      '\n\n\n                    "LET THE LIGHT BE WITH YOU!!!"\n';

  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'OUR LEGACY',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 600,
              child: ListView(
                children: <Widget>[
                  Image.asset('images/loyola.jpg'),
                  Text(
                    t1 + t2 + t3 + t4 + t5,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
