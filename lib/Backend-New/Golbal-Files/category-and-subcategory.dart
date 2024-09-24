// ignore_for_file: non_constant_identifier_names, constant_identifier_names

const List<String> CATEGORY = [
    "arrear in litigation",
    "restrained arrear",
    "arrears where appeal period not over",
    "recoverable arrears",
    "arrears pending for write-off"
  ];

 Map<String,List<String>>SUBCATEGORY={
  CATEGORY[0]:["sc","hc","cestat","commissioner appleal"],
  CATEGORY[1]:["ol","drt","bifr","nclt units"],
  CATEGORY[2]:["cases"],
  CATEGORY[3]:["appeal period over but no appeal field","settlement commision cases","arrear under section 11","arrear under section 142"],
  CATEGORY[4]:["cases"],
};

 List<String> DOCNAME = [
    "receipts",
    "disposal in favour of the department",
    "disposal against the department",
    "disposal order for denovo",
    "disposal formations changed",
    "arrearss realised"
  ];
