// ignore_for_file: file_names

class TarReportModel {
  double amountOfTheMonth;
  double amountUpTotheMonth;
  double noOfCasesUpToTheMonth;
  double noOfCasesOfTheMonth;
  double openingBalance;
  double closingBalance;
  TarReportModel({
    required this.amountOfTheMonth,
    required this.amountUpTotheMonth,
    required this.noOfCasesOfTheMonth,
    required this.noOfCasesUpToTheMonth,
    required this.openingBalance,
    required this.closingBalance,
  });
  factory TarReportModel.fromJson(Map<String, dynamic> json) {
    return TarReportModel(
        amountUpTotheMonth: json['amountUpTotheMonth'] ?? 0.0,
        amountOfTheMonth: json['amountOfTheMonth'] ?? 0.0,
        noOfCasesOfTheMonth: json['noOfCasesOfTheMonth'] ?? 0.0,
        noOfCasesUpToTheMonth: json['noOfCasesUpToTheMonth'] ?? 0.0,
        openingBalance: json['openingBalance'] ?? 0.0,
        closingBalance: json['closingBalance'] ?? 0.0);
  }
  Map<String, dynamic> toJson() {
    return {
      "amountUpTotheMonth": amountUpTotheMonth,
      "amountOfTheMonth": amountOfTheMonth,
      "noOfCasesOfTheMonth": noOfCasesOfTheMonth,
      "noOfCasesUpToTheMonth": noOfCasesUpToTheMonth,
      "openingBalance": openingBalance,
      "closingBalance": closingBalance
    };
  }
}

class TocModel {
  double openingBalance;
  double closingBalance;
  double numberOfClosingCases;
  double numberOfOpeningCases;
  TocModel(
      {required this.closingBalance,
      required this.openingBalance,
      required this.numberOfClosingCases,
      required this.numberOfOpeningCases});
  factory TocModel.fromJson(Map<String, dynamic> json) {
    return TocModel(
      closingBalance: json["closingBalance"]??0.0,
      openingBalance: json["openingBalance"]??0.0,
      numberOfClosingCases: json["numberOfClosingCases"]??0.0,
      numberOfOpeningCases: json["numberOfOpeningCases"]??0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "closingBalance": closingBalance,
      "openingBalance": openingBalance,
      "numberOfClosingCases": numberOfClosingCases,
      "numberOfOpeningCases": numberOfOpeningCases,
    };
  }
}
