class FaqModel {
  String question;
  String answer;

  FaqModel({required this.question, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  static List<FaqModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FaqModel.fromJson(json)).toList();
  }
}
