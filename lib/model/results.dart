class Results {
  String? type;
  String? difficulty;
  String? category;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  Results(
      {this.type,
        this.difficulty,
        this.category,
        this.question,
        this.correctAnswer,
        this.incorrectAnswers});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      question: json['question'] as String?,
      correctAnswer: json['correct_answer'] as String?,
      incorrectAnswers: (json['incorrect_answers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    data['category'] = this.category;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['incorrect_answers'] = this.incorrectAnswers;
    return data;
  }
}