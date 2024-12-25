// ignore_for_file: non_constant_identifier_names, constant_identifier_names

const List<String> CATEGORY = [
  "Arrear in litigation",
  "Restrained arrear",
  "Arrears where appeal period not over",
  "Recoverable arrears",
  "Arrears pending for write-off"
];

Map<String, List<String>> SUBCATEGORY = {
  CATEGORY[0]: [
    "Supreme Court", "High Court", "CESTAT", "Commissioner Appeal", "Additional Secretary"
  ],
  CATEGORY[1]: ["OL", "DRT", "BIFR", "NCLT Units"],
  CATEGORY[2]: ["Cases"],
  CATEGORY[3]: [
    "Appeal period over but no appeal field",
    "Settlement commission cases",
    "Unit closed",
    "Arrear under section 11",
    "Arrear under section 142"
  ],
  CATEGORY[4]: ["Cases"],
};

List<String> DOCNAME = [
  "receipts",
  "Disposal in favour of the department",
  "Disposal against the department",
  "Disposal order for denovo",
  "Disposal formations changed",
  "Arrears realised"
];

const List<String> USERTYPE = ['Admin', 'Others'];
const List<String> FORMATION = [
  "Air Cargo Complex Indore",
  "Customs Circle Bhopal",
  "Customs Circle Indore",
  "Customs Circle Raipur",
  "Customs Circle Ujjain",
  "Customs Circle Jabalpur",
  "Customs Hqrs Indore",
  "DABH International Airport Indore",
  "ICD Dhannad",
  "ICD Kheda",
  "ICD Malanpur",
  "ICD Mandideep",
  "ICD Powerkheda",
  "ICD Raipur",
  "ICD Tihi",
];

Map<String, List<String>> LITIGATIONKEYS = {
  "Supreme Court": [
    "Supreme Courtreceipts",
    "Supreme CourtDisposal in favour of the department",
    "Supreme CourtDisposal against the department",
    "Supreme CourtDisposal order for denovo",
    "Supreme CourtDisposal formations changed",
    "Supreme CourtArrears realised",
  ],
  "High Court": [
    "High Courtreceipts",
    "High CourtDisposal in favour of the department",
    "High CourtDisposal against the department",
    "High CourtDisposal order for denovo",
    "High CourtDisposal formations changed",
    "High CourtArrears realised",
  ],
  "CESTAT": [
    "CESTATreceipts",
    "CESTATDisposal in favour of the department",
    "CESTATDisposal against the department",
    "CESTATDisposal order for denovo",
    "CESTATDisposal formations changed",
    "CESTATArrears realised",
  ],
  "Commissioner Appeal": [
    "Commissioner Appealreceipts",
    "Commissioner AppealDisposal in favour of the department",
    "Commissioner AppealDisposal against the department",
    "Commissioner AppealDisposal order for denovo",
    "Commissioner AppealDisposal formations changed",
    "Commissioner AppealArrears realised",
    "Commissioner Appealtoc"
  ],
  "Additional Secretary": [
    "Additional Secretaryreceipts",
    "Additional SecretaryDisposal in favour of the department",
    "Additional SecretaryDisposal against the department",
    "Additional SecretaryDisposal order for denovo",
    "Additional SecretaryDisposal formations changed",
    "Additional SecretaryArrears realised",
    "Additional Secretarytoc"
  ]
};
// ["ol", "drt", "bifr", "nclt units"]
Map<String, List<String>> RESTRAINEDKEYS = {
  "OL": [
    "OLreceipts",
    "OLDisposal in favour of the department",
    "OLDisposal against the department",
    "OLDisposal order for denovo",
    "OLDisposal formations changed",
    "OLArrears realised"
  ],
  "DRT": [
    "DRTreceipts",
    "DRTDisposal in favour of the department",
    "DRTDisposal against the department",
    "DRTDisposal order for denovo",
    "DRTDisposal formations changed",
    "DRTArrears realised"
  ],
  "BIFR": [
    "BIFRreceipts",
    "BIFRDisposal in favour of the department",
    "BIFRDisposal against the department",
    "BIFRDisposal order for denovo",
    "BIFRDisposal formations changed",
    "BIFRArrears realised"
  ],
  "NCLT Units": [
    "NCLT Unitsreceipts",
    "NCLT UnitsDisposal in favour of the department",
    "NCLT UnitsDisposal against the department",
    "NCLT UnitsDisposal order for denovo",
    "NCLT UnitsDisposal formations changed",
    "NCLT UnitsArrears realised"
  ]
};

// [
//     "appeal period over but no appeal field",
//     "settlement commision cases",
//     "arrear under section 11",
//     "arrear under section 142"
//   ],
Map<String, List<String>> RECOVERABLEKEYS = {
  "Appeal period over but no appeal field": [
    "Appeal period over but no appeal fieldreceipts",
    "Appeal period over but no appeal fieldDisposal in favour of the department",
    "Appeal period over but no appeal fieldDisposal against the department",
    "Appeal period over but no appeal fieldDisposal order for denovo",
    "Appeal period over but no appeal fieldDisposal formations changed",
    "Appeal period over but no appeal fieldArrears realised"
  ],
  "Settlement commission cases": [
    "Settlement commission casesreceipts",
    "Settlement commission casesDisposal in favour of the department",
    "Settlement commission casesDisposal against the department",
    "Settlement commission casesDisposal order for denovo",
    "Settlement commission casesDisposal formations changed",
    "Settlement commission casesArrears realised"
  ],
  "Unit closed" :[
    "Unit closedreceipts",
    "Unit closedDisposal in favour of the department",
    "Unit closedDisposal against the department",
    "Unit closedDisposal order for denovo",
    "Unit closedDisposal formations changed",
    "Unit closedArrears realised"
  ],
  "Arrear under section 11": [
    "Arrear under section 11receipts",
    "Arrear under section 11Disposal in favour of the department",
    "Arrear under section 11Disposal against the department",
    "Arrear under section 11Disposal order for denovo",
    "Arrear under section 11Disposal formations changed",
    "Arrear under section 11Arrears realised"
  ],
  "Arrear under section 142": [
    "Arrear under section 142receipts",
    "Arrear under section 142Disposal in favour of the department",
    "Arrear under section 142Disposal against the department",
    "Arrear under section 142Disposal order for denovo",
    "Arrear under section 142Disposal formations changed",
    "Arrear under section 142Arrears realised"
  ]
};

Map<String, List<String>> PERIODNOTOVERKEYS = {
  "Cases": [
    "Casesreceipts",
    "CasesDisposal in favour of the department",
    "CasesDisposal against the department",
    "CasesDisposal order for denovo",
    "CasesDisposal formations changed",
    "CasesArrears realised"
  ],
};

// ["cases"]
Map<String, List<String>> WRITEOFFKEYS = {
  "Cases": [
    "Casesreceipts",
    "CasesDisposal in favour of the department",
    "CasesDisposal against the department",
    "CasesDisposal order for denovo",
    "CasesDisposal formations changed",
    "CasesArrears realised"
  ],
};

//toc all subcateogry data
List<String> TOCKEY = [
  'Supreme Courttoc',
  'High Courttoc',
  'CESTATtoc',
  'Commissioner Appealtoc',
  'Additional Secretarytoc',
  'OLtoc',
  'DRTtoc',
  'BIFRtoc',
  'NCLT Unitstoc',
  'Casestoc',
  'Appeal period over but no appeal fieldtoc',
  'Settlement commission casestoc',
  'Arrear under section 11toc',
  'Unit closedtoc',
  'Arrear under section 142toc',
  'Arrears pending for write-offtoc'
];

bool isloaded = false;
