import 'package:get/get.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/controller/questionController.dart';
import 'package:sofiqe/model/ingredients_model.dart';

// Models
import 'package:sofiqe/model/make_over_question_model.dart';
import 'package:sofiqe/model/response.model.dart';
import 'package:sofiqe/utils/api/questionnaire_api.dart';

class MakeOverProvider extends GetxController {
  static MakeOverProvider instance = Get.find();

  var questions = <MakeOverQuestion>[].obs;
  var ingredients = <Ingredients>[].obs;
  var ingredientsfilteredlist = <Ingredients>[].obs;
  RxBool tryitOn = false.obs;
  List<String> selectedIngredients = <String>[];
  RxBool isSearchenable = false.obs;
  RxBool questionairecompleted = false.obs;
  final QuestionsController ques = Get.find();
  late List<Map> response = List.filled(12, {});
  var currentQuestion = 0.obs;
  late var currentPrompt;
  var question;
  late var prompt;
  RxInt screen = 1.obs;
  late var images;
  var hairColor = '';
  var hairColorCode = '';
  var selectedEye = '';
  var selectedEyeCode = '';
//tab related to questionairre tab and face scan tab
  late var tab = 0.obs;
  var responseList = <ResponseElement>[].obs;
  RxBool colorAna = false.obs;
  RxInt type = 0.obs;
  RxBool isFirstques = true.obs;
  RxBool underDocCare = false.obs;
  RxBool foundAny = true.obs;
  RxString foundData = ''.obs;
  RxBool fromMed = false.obs;

  final List<Map<String, String>> prompts = [
    {
      'text': 'Thank you! Take Selfie',
      'subtext':
          'We will store this as your morning profile. Be sure the light is good on the photo',
      'file': 'front_facing',
    },
  ];

  MakeOverProvider() {
   _initData();
  }

  _initData() async{
    questions.value = questionsController.makeover;
    await getIngredeints();
    images = [].obs;
    currentQuestion = 0.obs;
    currentPrompt = 0.obs;
    tab = 0.obs;

    prompt = prompts[0].obs;
    screen = 1.obs;
    // getQuestionnaireList();
  }

  void reset() {
    questions.value = [];
    images = [].obs;
    currentQuestion = 0.obs;
    currentPrompt = 0.obs;
    tab = 0.obs;
    prompt = prompts[0].obs;
    // getQuestionnaireList();
  }

  void changeTab(var newTab) {
    tab.value = newTab;
  }

  void switchType([int type = 1]) {
    this.type.value = type;
  }

  onSearchTextChanged(
    String queryString,
  ) async {
    isSearchenable.value = true;
    //foundAny.value = false;
    ingredientsfilteredlist.clear();
    if (queryString.isEmpty) {
      // foundAny.value = true;
      // update();
      return;
    }
    foundAny.value = false;
    ingredients.forEach((data) {
      if (data.ingredient.toLowerCase().contains(queryString.toLowerCase())) {
        ingredientsfilteredlist.add(data);
        foundAny.value = true;
      }
    });
    update();
  }
  //Function for getting Questionairre list from server on AdminBearerId

  Future<bool> getQuestionnaireList() async {
    if (questions.isNotEmpty) {
      question = questions[currentQuestion.value.toInt()].obs;
      return true;
    }
    questions.value = questionsController.makeover;
    // questions.value.forEach((element) {
    //   print("questions----->"+element.question.toString());
    //   print("multiSelect----->"+element.multiSelect.toString());
    //   print("id----->"+element.id.toString());
    // });


    // update();
    return true;
  }

// previous question and cases according to conditions
  void previousQuestion(bool manual) {
    // ignore: unrelated_type_equality_checks
    if (tab == 0) {
      //  recordResponse();
      if (currentQuestion.value > 0 && currentQuestion.value != 6) {
        currentQuestion.value--;
        if (currentQuestion.value >= 0 &&
            currentQuestion.value < questions.length) {
          question.value = questions[currentQuestion.value.toInt()];
        }
      } else if (currentQuestion.value == 6) {
        currentQuestion.value = 0;
        colorAna.value = false;
      }

      // ignore: unrelated_type_equality_checks
    } else if (tab == 1) {
      if (currentPrompt.value > 0) {
        currentPrompt.value--;
        if (currentPrompt.value >= 0 && currentPrompt.value < prompts.length) {
          prompt.value = prompts[currentPrompt.value.toInt()];
        }
      } else {
        tab.value = 0;
        question.value = questions[currentQuestion.value.toInt()];
        if ((currentQuestion.value == 5 &&
            questions[0].getAnswer().isNotEmpty)) {
          if (questions[0].getAnswer()[0]!.toLowerCase() == 'no') {
            previousQuestion(true);
            return;
          }
        }
      }
    }
  }
//Function for next question and cases according to conditions

  void nextQuestion(bool manual) async {
    await recordResponse();

    // ignore: unrelated_type_equality_checks
    if (tab == 0) {
      if (question!.value.multiSelect && !manual) {
        return;
      }

      if (currentQuestion.value + 1 == 4 && underDocCare.value == true) {
        currentQuestion.value = currentQuestion.value + 2;
        question.value = questions[currentQuestion.value.toInt()];
      } else if (currentQuestion.value == 5 && underDocCare.value == true) {
        fromMed.value = true;
        currentQuestion.value = 4;
        question.value = questions[currentQuestion.value.toInt()];
      } else if (currentQuestion.value == 4) {
        currentQuestion.value = 6;
        question.value = questions[currentQuestion.value.toInt()];
      } else if (currentQuestion.value + 1 >= 12) {
        tab.value = 1;
        update();
        currentQuestion.value = 0;
        question.value = questions[currentQuestion.value];
        prompt.value = prompts[currentPrompt.value.toInt()];
      } else {
        //  await recordResponse();
        if (question.value.question ==
            'What recommendations have you received?') {
          // currentQuestion.value++;
          if (questions[0].getAnswer()[0]!.toLowerCase() == 'yes') {
            tab.value = -1;
          }
        }
        currentQuestion.value++;
        if (currentQuestion.value >= 0 &&
            currentQuestion.value < questions.length) {
          question.value = questions[currentQuestion.value.toInt()];
        }
        if ((question.value.question ==
                'What recommendations have you received?' &&
            questions[0].getAnswer().isNotEmpty)) {
          if (questions[0].getAnswer()[0]!.toLowerCase() == 'no') {
            nextQuestion(true);
            return;
          }
        }
      }
    } else if (tab.value == 1) {
      screen.value = 2;
    }
    update();
  }

  // Future<void> addResponseToDatabase() async {
  //   sfDBAddAnswerToDatabase(response);
  // }
//recording each question response
  Future<void> recordResponse() async {
    var rq = question.value;

    if (rq.id == "5") {
      List<String> selectedIngredients = [];
      ingredients.forEach((element) {
        if (element.isSelect == true) {
          selectedIngredients.add("\"${element.ingredient}\"");
        }
      });
      selectedIngredients.forEach((element) {
        print(element);
      });
      response[(int.parse(rq.id)) - 1] = {
        '"${rq.id}"': "${selectedIngredients.toString()}",
      };
    } else {
      response[(int.parse(rq.id)) - 1] = {
        '"${rq.id}"': "${rq.answer.toString()}",
      };
    }

    print(response.toString());

    if (rq.id == "1") {
      if (rq.answer.toString().contains('es')) {
        print('Under doc care');
        underDocCare.value = true;
      } else
        underDocCare.value = false;
    }
  }

  Future<void> sendResponse(int customerId) async {
    response[10] = {
      '"11"': "[\"$selectedEyeCode\"]",
    };
    response[11] = ({
      '"12"': "[\"$hairColorCode\"]",
    });
    await sfAPISendQuestionnaireResponse(
        customerId.toString(), response.toString());
    // saveIngredients(ingredients);
  }

  Future<void> getIngredeints() async {
    ingredients.value = await sfAPIgetIngredients();
    ingredients.insert(0, Ingredients(ingredient: 'None', isSelect: false));
  }

  Future<bool> saveNewIngredients(String newIngredient) async {
    if (await sfApiPostIngredients(newIngredient)) {
      return true;
    }
    return false;
  }

//check
  Future<bool> saveIngredients(List<Ingredients> ingredient) async {
    String ingredientsString = '';
    ingredient.forEach((element) {
      if (element.isSelect == true) {
        ingredientsString += element.ingredient.toString() + ',';
      }
    });
    print(ingredientsString);
    if (await sfApiPostIngredients(ingredientsString)) {
      return true;
    }
    return false;
  }
}
