
module Constants
# https://wiperecord.com/california-felony-reductions-and-wobbler-criminal-offenses/#gref
  WOBBLERS = [
    "PC 32",
    "PC 69",
    "PC 71",
    "PC 72",
    "PC 95",
    "PC 95.1",
    "PC 96",
    "PC 99",
    "PC 100",
    "PC 107",
    "PC 115.1",
    "PC 118.1",
    "PC 136.1(a)",
    "PC 136.1(b)",
    "PC 136.5",
    "PC 148.10",
    "PC 149",
    "PC 166(c)(4)",
    "PC 166(d)",
    "PC 168",
    "PC 171b",
    "PC 171c",
    "PC 171d",
    "PC 182(a)(1)",
    "PC 182(a)(2)",
    "PC 182(a)(3)",
    "PC 182(a)(4)",
    "PC 182(a)(5)",
    "PC 182.5",
    "PC 186.22(a)",
    "PC 186.22(a)",
    "PC 186.22(b)(1)",
    "PC 186.22(c)",
    "PC 186.22(d)",
    "PC 186.26(a)",
    "PC 186.26(b)",
    "PC 186.28",
    "PC 192(c)(1)",
    "PC 192(c)(3)",
    "PC 192.5(a)",
    "PC 192.5(c)(3)",
    "PC 227",
    "PC 231",
    "PC 227",
    "PC 231/227",
    "PC 241.1",
    "PC 241.4",
    "PC 241.7",
    "PC 243(c)",
    "PC 243(c)(1)",
    "PC 243(c)(2)",
    "PC 243(d)",
    "PC 243.3",
    "PC 243.4(a)(d)",
    "PC 243.6",
    "PC 243.7",
    "PC 243.9(a)",
    "PC 244.5(b)",
    "PC 244.5(c)",
    "PC 245(a)(1)",
    "PC 245(a)(2)",
    "PC 245.5(b)",
    "PC 245.5(c)",
    "PC 246",
    "PC 247(b)",
    "PC 247.5",
    "PC 261.5",
    "PC 261.5(c)",
    "PC 261.5(d)",
    "PC 262",
    "PC 266",
    "PC 266c",
    "PC 267",
    "PC 270",
    "PC 271",
    "PC 271a",
    "PC 273(c)",
    "PC 273a(1)",
    "PC 273a(a)(1)",
    "PC 273a(a)",
    "PC 273d",
    "PC 273d(a)",
    "PC 273.5",
    "PC 273.5(a)",
    "PC 273.5(e)",
    "PC 273.5(e)(1)",
    "PC 273.5(e)(2)",
    "PC 273.6(c)",
    "PC 273.6(d)",
    "PC 273.6(d)",
    "PC 273.6(e)",
    "PC 273.55",
    "PC 273.65(d)",
    "PC 273.65(e)",
    "PC 276",
    "PC 278",
    "PC 278.5",
    "PC 280(b)",
    "PC 283",
    "PC 284",
    "PC 286(b)(1)",
    "PC 286(e)",
    "PC 286(h)",
    "PC 288(c)",
    "PC 288(c)(1)",
    "PC 288(c)(2)",
    "PC 288.2",
    "PC 288.2(a)",
    "PC 288.2(b)",
    "PC 288a(b)(1)",
    "PC 288a(e)",
    "PC 288a(h)",
    "PC 289(c)",
    "PC 289(c)",
    "PC 289(h)",
    "PC 289(h)",
    "PC 289.6(a)(2)",
    "PC 289.6(a)(3)",
    "PC 290(g)(2)",
    "PC 290(g)(2)",
    "PC 290(g)(3)",
    "PC 290(g)(5)",
    "PC 290(g)(5)",
    "PC 299.5(g)",
    "PC 311.1",
    "PC 311.2(d)",
    "PC 311.2(d)",
    "PC 311.10",
    "PC 314(1)",
    "PC 332",
    "PC 334(a)",
    "PC 337a",
    "PC 337b",
    "PC 337c",
    "PC 337d",
    "PC 337e",
    "PC 337f(c)",
    "PC 337f(d)",
    "PC 337i",
    "PC 337.3",
    "PC 337.7",
    "PC 347(b)",
    "PC 350(a)(2)",
    "PC 350(a)(2)",
    "PC 350(b)",
    "PC 350(b)",
    "PC 350(d)(1)",
    "PC 350(d)(2)",
    "PC 350(d)(30)",
    "PC 367f",
    "PC 368(a)",
    "PC 368(b)",
    "PC 368(c)",
    "PC 368(d)",
    "PC 368(e)",
    "PC 374.2",
    "PC 374.8",
    "PC 382.5",
    "PC 382.6",
    "PC 387",
    "PC 399(b)",
    "PC 399.5",
    "PC 404.6(c)",
    "PC 417(b)",
    "PC 417(b)",
    "PC 417(c)",
    "PC 417.1",
    "PC 417.6",
    "PC 422",
    "PC 422.7",
    "PC 452(a)",
    "PC 452(b)",
    "PC 452(c)",
    "PC 453(a)",
    "PC 453(a)",
    "PC 453(b)",
    "PC 461(2)",
    "PC 463(a)",
    "PC 463(a)",
    "PC 463(b)",
    "PC 463(b)",
    "PC 463(b)",
    "PC 470",
    "PC 470a",
    "PC 470b",
    "PC 471",
    "PC 472",
    "PC 474",
    "PC 475",
    "PC 475a",
    "PC 476",
    "PC 476a",
    "PC 483.5(d)",
    "PC 484b",
    "PC 484e(a)",
    "PC 484e(b)",
    "PC 484e(d)",
    "PC 484g",
    "PC 484g",
    "PC 484h",
    "PC 484i(b)",
    "PC 484i(b)",
    "PC 484i(c)",
    "PC 487(1)",
    "PC 487(2)",
    "PC 487(3)",
    "PC 487(3)",
    "PC 487(a)",
    "PC 487(b)(1)",
    "PC 487(b)(2)",
    "PC 487(b)(3)",
    "PC 487(c)",
    "PC 487(d)",
    "PC 487(d)",
    "PC 487a",
    "PC 487e",
    "PC 487g",
    "PC 487g",
    "PC 487h(a)",
    "PC 487h(a)",
    "PC 496(1)",
    "PC 496(a)",
    "PC 496(b)",
    "PC 496(e)",
    "PC 496(d)",
    "PC 496a",
    "PC 496c",
    "PC 496d",
    "PC 497",
    "PC 499(a)",
    "PC 499(b)",
    "PC 499b.1(a)",
    "PC 499b.1(b)",
    "PC 499c",
    "PC 499d",
    "PC 502(d)",
    "PC 502(d)",
    "PC 502.5",
    "PC 502.7(a)",
    "PC 502.7(a)",
    "PC 502.7(b)",
    "PC 502.7(b)",
    "PC 502.7(d)",
    "PC 502.7(g)",
    "PC 502.8(c)",
    "PC 502.8(d)",
    "PC 503",
    "PC 504",
    "PC 504a",
    "PC 504b",
    "PC 505",
    "PC 506",
    "PC 506b",
    "PC 507",
    "PC 508",
    "PC 524",
    "PC 529",
    "PC 530",
    "PC 530.5",
    "PC 532",
    "PC 532a(4)",
    "PC 535",
    "PC 537(a)(2)",
    "PC 537e(a)",
    "PC 538",
    "PC 538.5",
    "PC 540",
    "PC 541",
    "PC 542",
    "PC 549",
    "PC 550(a)(6)",
    "PC 550(b)(1)",
    "PC 550(b)(2)",
    "PC 551",
    "PC 560",
    "PC 560.4",
    "PC 566",
    "PC 570",
    "PC 577",
    "PC 578",
    "PC 580",
    "PC 581",
    "PC 587",
    "PC 591",
    "PC 592(b)",
    "PC 593",
    "PC 593d(b)",
    "PC 594(b)(1)",
    "PC 594(b)(1)",
    "PC 594(b)(2)",
    "PC 594.3(a)",
    "PC 594.3(a)",
    "PC 594.35",
    "PC 594.4",
    "PC 594.7",
    "PC 597",
    "PC 600(a)",
    "PC 601",
    "PC 601",
    "PC 607",
    "PC 620",
    "PC 621",
    "PC 625b(b)",
    "PC 626.9(b)",
    "PC 626.10(a)",
    "PC 626.10(a)",
    "PC 626.10(b)",
    "PC 626.10(b)",
    "PC 626.95",
    "PC 629.84",
    "PC 631",
    "PC 632",
    "PC 632.5",
    "PC 632.6",
    "PC 632.7",
    "PC 634",
    "PC 635",
    "PC 636(b)",
    "PC 637",
    "PC 637.1",
    "PC 641.3",
    "PC 642",
    "PC 646.9(a)",
    "PC 646.9(b)",
    "PC 646.9(c)",
    "PC 646.9(c)(1)",
    "PC 647.6",
    "PC 653f(a)",
    "PC 653f(d)",
    "PC 653f(e)",
    "PC 653h(b)",
    "PC 653h(c)",
    "PC 653h(d)",
    "PC 666",
    "PC 666",
    "PC 1319.4",
    "PC 1320(b)",
    "PC 1320.5",
    "PC 1370.5",
    "PC 4011.7",
    "PC 4131.5",
    "PC 4133",
    "PC 4501.1",
    "PC 4532(a)",
    "PC 4532(b)",
    "PC 4532(b)",
    "PC 4532(d)",
    "PC 4532(d)",
    "PC 4536",
    "PC 4550(2)",
    "PC 11411(b)",
    "PC 14411(c)",
    "PC 11411(c)",
    "PC 11418(d)",
    "PC 11418.1",
    "PC 11418.5",
    "PC 12020",
    "PC 12020",
    "PC 12021(c)",
    "PC 12021(d)",
    "PC 12021(e)",
    "PC 12021(g)",
    "PC 12021.3",
    "PC 12023",
    "PC 12025(a)",
    "PC 12025(a)",
    "PC 12025(b)",
    "PC 12031(a)",
    "PC 12031(a)",
    "PC 12031.5(a)",
    "PC 12034(b)",
    "PC 12034(d)",
    "PC 12035(b)(1)",
    "PC 12040",
    "PC 12072",
    "PC 12072",
    "PC 12072(a)",
    "PC 12100",
    "PC 12100",
    "PC 12101",
    "PC 12220",
    "PC 12220(a)",
    "PC 12220(b)",
    "PC 12303",
    "PC 12304",
    "PC 12316(b)",
    "PC 12320",
    "PC 12321",
    "PC 12355(b)",
    "PC 12403.7",
    "PC 12422",
    "PC 12520",
    "PC 14166",
    "BPC 580",
    "BPC 581",
    "BPC 582",
    "BPC 583",
    "BPC 584",
    "BPC 650",
    "BPC 729",
    "BPC 729",
    "BPC 729",
    "BPC 729",
    "BPC 729",
    "BPC 1282.3",
    "BPC 2052(a)",
    "BPC 2052(b)",
    "BPC 2053",
    "BPC 4324",
    "BPC 6126(b)",
    "BPC 6126(c)",
    "BPC 6152",
    "BPC 7026.10",
    "BPC 7027.3",
    "BPC 7028.16",
    "BPC 10238.6",
    "BPC 10250.56",
    "BPC 11010.1",
    "BPC 11013.1",
    "BPC 11013.2",
    "BPC 11013.4",
    "BPC 11018.2",
    "BPC 11019",
    "BPC 11022",
    "BPC 17511.9",
    "BPC 22430(d)",
    "COM 892",
    "COM 1695.8",
    "COM 1812.116(b)",
    "COM 1812.217",
    "COM 2945.4",
    "COM 2985.2",
    "COM 2985.3",
    "CORP 2255",
    "CORP 2256",
    "CORP 6811",
    "CORP 6812",
    "CORP 6813",
    "CORP 6814",
    "CORP 8812",
    "CORP 8813",
    "CORP 8814",
    "CORP 8815",
    "CORP 12672",
    "CORP 12673",
    "CORP 12674",
    "CORP 12675",
    "CORP 22002",
    "CORP 25110",
    "CORP 25120",
    "CORP 25130",
    "CORP 25164",
    "CORP 25166",
    "CORP 25210",
    "CORP 25214(a)",
    "CORP 25216",
    "CORP 25218",
    "CORP 25230",
    "CORP 25232.2",
    "CORP 25234(a)",
    "CORP 25235",
    "CORP 25243",
    "CORP 25245",
    "CORP 25246",
    "CORP 25300(a)",
    "CORP 25400",
    "CORP 25401",
    "CORP 25402",
    "CORP 25403",
    "CORP 25404"
  ]

  REDUCIBLE_TO_INFRACTION = [
    "PC 193.8",
    "PC 330",
    "PC 415",
    "PC 485",
    "PC 490.7",
    "PC 555",
    "PC 602.13",
    "PC 853.7",
    "PC 532b(c)",
    "PC 602(o)",
    "BPC 25658(b)",
    "BPC 21672",
    "BPC 25661",
    "BPC 25662",
    "GOV 27204",
    "VC 23109(c)",
    "VC 5201.1",
    "VC 12500",
    "VC 14601.1",
    "VC 27150.1",
    "VC 40508",
    "VC 42005"
  ]
end
