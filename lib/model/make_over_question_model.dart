class MakeOverQuestion {
  int index;
  String question;
  Map<String, dynamic>  ? choices;
  List<String?> answer = [];

  bool multiSelect;
  String exclusive;
  String id;

  MakeOverQuestion({
    required this.index,
    required this.question,
     this.choices,
    required this.answer,
    required this.multiSelect,
    required this.exclusive,
    required this.id,
  });

  void setAnswer(String a) {
    print("multiSelect--2222-"+multiSelect.toString());
    if (!multiSelect && answer.isNotEmpty) {
      print('1111');
      answer.removeAt(0);
    }
    if (a.compareTo(exclusive) == 0) {
      print('2222');
      answer.removeWhere((element) => true);
    } else {
      print('3333');
      answer.remove(exclusive);
    }
    if (answer.contains(a)) {
      print('44444');
      answer.remove(a);
    } else {
      print('5555');
      if(answer.isNotEmpty){
        if(answer.contains("\"$a\"")){
          answer.remove("\"$a\"");
        }else{
          answer.add("\"$a\"");
        }
      }else{
        answer.add("\"$a\"");
      }


    }
  }

  List<String?> getAnswer() {
    return this.answer;
  }
}
