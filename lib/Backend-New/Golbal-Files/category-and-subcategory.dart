// ignore_for_file: non_constant_identifier_names, constant_identifier_names

const List<String> CATEGORY = [
  "arrear in litigation",
  "restrained arrear",
  "arrears where appeal period not over",
  "recoverable arrears",
  "arrears pending for write-off"
];

Map<String, List<String>> SUBCATEGORY = {
  CATEGORY[0]: ["sc", "hc", "cestat", "commissioner appleal"],
  CATEGORY[1]: ["ol", "drt", "bifr", "nclt units"],
  CATEGORY[2]: ["cases"],
  CATEGORY[3]: [
    "appeal period over but no appeal field",
    "settlement commision cases",
    "arrear under section 11",
    "arrear under section 142"
  ],
  CATEGORY[4]: ["cases"],
};

List<String> DOCNAME = [
  "receipts",
  "disposal in favour of the department",
  "disposal against the department",
  "disposal order for denovo",
  "disposal formations changed",
  "arrearss realised"
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
  "ICD Mandideep ",
  "ICD Powerkheda ",
  "ICD Raipur",
  "ICD Tihi",

];

Map<String, List<String>> LITIGATIONKEYS = {
  "sc": [
    "screceipts",
    "scdisposal in favour of the department",
    "scdisposal against the department",
    "scdisposal order for denovo",
    "scdisposal formations changed",
    "scarrearss realised",
  ],
  "hc": [
    "hcreceipts",
    "hcdisposal in favour of the department",
    "hcdisposal against the department",
    "hcdisposal order for denovo",
    "hcdisposal formations changed",
    "hcarrearss realised",
  ],
  "cestat": [
    "cestatreceipts",
    "cestatdisposal in favour of the department",
    "cestatdisposal against the department",
    "cestatdisposal order for denovo",
    "cestatdisposal formations changed",
    "cestatarrearss realised",
  ],
  "commissioner appleal": [
    "commissioner applealreceipts",
    "commissioner applealdisposal in favour of the department",
    "commissioner applealdisposal against the department",
    "commissioner applealdisposal order for denovo",
    "commissioner applealdisposal formations changed",
    "commissioner applealarrearss realised",
    "commissioner appealtoc"
  ]
};
// ["ol", "drt", "bifr", "nclt units"]
Map<String, List<String>> RESTRAINEDKEYS = {
  "ol": [
    "olreceipts",
    "oldisposal in favour of the department",
    "oldisposal against the department",
    "oldisposal order for denovo",
    "oldisposal formations changed",
    "olarrearss realised"
  ],
  "drt": [
    "drtreceipts",
    "drtdisposal in favour of the department",
    "drtdisposal against the department",
    "drtdisposal order for denovo",
    "drtdisposal formations changed",
    "drtarrearss realised"
  ],
  "bifr": [
    "bifrreceipts",
    "bifrdisposal in favour of the department",
    "bifrdisposal against the department",
    "bifrdisposal order for denovo",
    "bifrdisposal formations changed",
    "bifrarrearss realised"
  ],
  "nclt units": [
    "nclt unitsreceipts",
    "nclt unitsdisposal in favour of the department",
    "nclt unitsdisposal against the department",
    "nclt unitsdisposal order for denovo",
    "nclt unitsdisposal formations changed",
    "nclt unitsarrearss realised"
  ]
};

// [
//     "appeal period over but no appeal field",
//     "settlement commision cases",
//     "arrear under section 11",
//     "arrear under section 142"
//   ],
Map<String, List<String>> RECOVERABLEKEYS = {
  "appeal period over but no appeal field": [
    "appeal period over but no appeal fieldreceipts",
    "appeal period over but no appeal fielddisposal in favour of the department",
    "appeal period over but no appeal fielddisposal against the department",
    "appeal period over but no appeal fielddisposal order for denovo",
    "appeal period over but no appeal fielddisposal formations changed",
    "appeal period over but no appeal fieldarrearss realised"
  ],
  "settlement commision cases": [
    "settlement commision casesreceipts",
    "settlement commision casesdisposal in favour of the department",
    "settlement commision casesdisposal against the department",
    "settlement commision casesdisposal order for denovo",
    "settlement commision casesdisposal formations changed",
    "settlement commision casesarrearss realised"
  ],
  "arrear under section 11": [
    "arrear under section 11receipts",
    "arrear under section 11disposal in favour of the department",
    "arrear under section 11disposal against the department",
    "arrear under section 11disposal order for denovo",
    "arrear under section 11disposal formations changed",
    "arrear under section 11arrearss realised"
  ],
  "arrear under section 142": [
    "arrear under section 142receipts",
    "arrear under section 142disposal in favour of the department",
    "arrear under section 142disposal against the department",
    "arrear under section 142disposal order for denovo",
    "arrear under section 142disposal formations changed",
    "arrear under section 142arrearss realised"
  ]
};

Map<String, List<String>> PERIODNOTOVERKEYS = {
  "cases": [
    "casesreceipts",
    "casesdisposal in favour of the department",
    "casesdisposal against the department",
    "casesdisposal order for denovo",
    "casesdisposal formations changed",
    "casesarrearss realised"
  ],
};

// ["cases"]
Map<String, List<String>> WRITEOFFKEYS = {
  "cases": [
    "casesreceipts",
    "casesdisposal in favour of the department",
    "casesdisposal against the department",
    "casesdisposal order for denovo",
    "casesdisposal formations changed",
    "casesarrearss realised"
  ],
};

//toc all subcateogry data
    List<String> TOCKEY = ['sctoc','hctoc','cestattoc','commissioner applealtoc','oltoc','drttoc','bifrtoc','nclt unitstoc','casestoc','appeal period over but no appeal fieldtoc','settlement commision casestoc','arrear under section 11toc','arrear under section 142toc','arrears pending for write-offtoc'];
//checkloader

bool isloaded = false;
