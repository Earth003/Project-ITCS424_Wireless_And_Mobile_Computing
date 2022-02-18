// NOTUSED, JUST REFERENCE
class Overview {
  String label;
  String imageUrl;
  int number;
  List<Detail> details;
  // TODO: Add servings and ingredients here

  Overview(
      this.label,
      this.imageUrl,
      this.number,
      this.details,
      );
  static List<Overview> samples = [
    Overview(
      'Microphone',
      'images/microphone.png',
      1,
      [
        Detail('      Microphone or voice censor is needed for the application to receive input. '
            'It is mandatory to have this tool permitted by the user so that the program can utilize it.',),
        Detail('      The microphone function is the main function for user to transcribe speech into text'
            'The speech will be computed by Android Speech recognition API and display the result on the screen.'),
        Detail('      Additionally, user can append the text into their note file as well.',),
      ]
    ),
    Overview(
        'Add file',
        'images/add-file.png',
        2,
        [
          Detail('  This is the file creation function which allow user to note on different files, edit, save, or delete content.'
            'This function can be access through main page of the program locating at the bottom right of the screen',),

        ]
    ),
    Overview(
        'Settings',
        'images/settings.png',
        3,
        [
          Detail('      User can make several adjustments by clicking at the cog icon located at the top right of the screen.',),

        ]
    ),
  ];

}

// TODO: Add Ingredient() here
class Detail {
  String desc;

  Detail(
      this.desc,
      );
}

