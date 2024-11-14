enum UploadCategory {
  notes,
  questionPaper,
  memo,
  practical,
  materials,
  assignment,
  activity
}

extension UploadCategoryConverter on UploadCategory {
  String get asString {
    switch (this) {
      case UploadCategory.notes:
        return "Notes";
      case UploadCategory.questionPaper:
        return "Question Paper";
      case UploadCategory.memo:
        return "Memorandum";
      case UploadCategory.practical:
        return "Practical";
      case UploadCategory.materials:
        return "Materials";
      case UploadCategory.assignment:
        return "Assignment";
      default:
        return 'Activity';
    }
  }

  int get asInt {
    switch (this) {
      case UploadCategory.notes:
        return 0;
      case UploadCategory.questionPaper:
        return 1;
      case UploadCategory.memo:
        return 2;
      case UploadCategory.practical:
        return 3;
      case UploadCategory.materials:
        return 4;
      case UploadCategory.assignment:
        return 5;
      default:
        return 6;
    }
  }

  static UploadCategory fromInt(int access) {
    switch (access) {
      case 0:
        return UploadCategory.notes;
      case 1:
        return UploadCategory.questionPaper;
      case 2:
        return UploadCategory.memo;
      case 3:
        return UploadCategory.practical;
      case 4:
        return UploadCategory.materials;
      case 5:
        return UploadCategory.assignment;
      default:
        return UploadCategory.activity;
    }
  }
}
