import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/my_icons_class/my_icons_class.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:flutter/material.dart';

class DefaultCategoriesData {
  static const Map<String, IconData> iconsMap = {
    'cash_bundle_1214102': MyIconsClass.cash_bundle_1214102,
    'credit_card_1214100': MyIconsClass.credit_card_1214100,
    'dollar_1214095': MyIconsClass.dollar_1214095,
    'dollar_1214096': MyIconsClass.dollar_1214096,
    'dollar_1214097': MyIconsClass.dollar_1214097,
    'dollar_1214098': MyIconsClass.dollar_1214098,
    'dollar_coin_1214099': MyIconsClass.dollar_coin_1214099,
    'euro_1214092': MyIconsClass.euro_1214092,
    'euro_coin_1214093': MyIconsClass.euro_coin_1214093,
    'focus_1214119': MyIconsClass.focus_1214119,
    'goal_1215931': MyIconsClass.goal_1215931,
    'growth_graph_1214091': MyIconsClass.growth_graph_1214091,
    'increase_money_1214090': MyIconsClass.increase_money_1214090,
    'invoice_1214071': MyIconsClass.invoice_1214071,
    'invoice_1214077': MyIconsClass.invoice_1214077,
    'light_bulb_1214117': MyIconsClass.light_bulb_1214117,
    'light_bulb_1214118': MyIconsClass.light_bulb_1214118,
    'list_format_1214115': MyIconsClass.list_format_1214115,
    'money_1214076': MyIconsClass.money_1214076,
    'money_1214122': MyIconsClass.money_1214122,
    'money_1214123': MyIconsClass.money_1214123,
    'money_withdrawal_1214094': MyIconsClass.money_withdrawal_1214094,
    'office_bag_1214074': MyIconsClass.office_bag_1214074,
    'office_bag_1214075': MyIconsClass.office_bag_1214075,
    'office_bag_1214085': MyIconsClass.office_bag_1214085,
    'office_bag_1214086': MyIconsClass.office_bag_1214086,
    'office_bag_1214087': MyIconsClass.office_bag_1214087,
    'office_bag_1214089': MyIconsClass.office_bag_1214089,
    'office_bag_1214114': MyIconsClass.office_bag_1214114,
    'percentage_1408655': MyIconsClass.percentage_1408655,
    'office_bag_1214088': MyIconsClass.office_bag_1214088,
    'pie_chart_1214073': MyIconsClass.pie_chart_1214073,
    'pound_1214083': MyIconsClass.pound_1214083,
    'pound_coin_1214084': MyIconsClass.pound_coin_1214084,
    'presentation_board_1214082': MyIconsClass.presentation_board_1214082,
    'puzzle_1214124': MyIconsClass.puzzle_1214124,
    'rupee_1784374': MyIconsClass.rupee_1784374,
    'show_chart_1214081': MyIconsClass.show_chart_1214081,
    'sitemap_1215929': MyIconsClass.sitemap_1215929,
    'target_1215930': MyIconsClass.target_1215930,
    'turkish_lira_2055954': MyIconsClass.turkish_lira_2055954,
    'visualisation_graph_1784373': MyIconsClass.visualisation_graph_1784373,
    'withdrawal_1214072': MyIconsClass.withdrawal_1214072,
    'yen_coin_1214080': MyIconsClass.yen_coin_1214080,
    'yen_1214079': MyIconsClass.yen_1214079,
    'add_panel_1784372': MyIconsClass.add_panel_1784372,
    'aim_1215932': MyIconsClass.aim_1215932,
    'bank_1408654': MyIconsClass.bank_1408654,
    'bar_graph_1214106': MyIconsClass.bar_graph_1214106,
    'bar_graph_1214107': MyIconsClass.bar_graph_1214107,
    'bar_graph_1214108': MyIconsClass.bar_graph_1214108,
    'bar_graph_1214110': MyIconsClass.bar_graph_1214110,
    'bar_graph_1214109': MyIconsClass.bar_graph_1214109,
    'bar_graph_1214111': MyIconsClass.bar_graph_1214111,
    'bar_graph_1214112': MyIconsClass.bar_graph_1214112,
    'bar_graph_1214113': MyIconsClass.bar_graph_1214113,
    'bill_1214078': MyIconsClass.bill_1214078,
    'bill_1214105': MyIconsClass.bill_1214105,
    'bitcoin_1214103': MyIconsClass.bitcoin_1214103,
    'bitcoin_1214104': MyIconsClass.bitcoin_1214104,
    'computer_mouse_1214270': MyIconsClass.computer_mouse_1214270,
    'hard_disk_1214627': MyIconsClass.hard_disk_1214627,
    'mobile_1214267': MyIconsClass.mobile_1214267,
    'mobile_1214268': MyIconsClass.mobile_1214268,
    'modem_1214626': MyIconsClass.modem_1214626,
    'modem_1214630': MyIconsClass.modem_1214630,
    'monitor_1214265': MyIconsClass.monitor_1214265,
    'monitor_1214266': MyIconsClass.monitor_1214266,
    'mouse_1214264': MyIconsClass.mouse_1214264,
    'printer_1214263': MyIconsClass.printer_1214263,
    'screen_1214629': MyIconsClass.screen_1214629,
    'tab_1214262': MyIconsClass.tab_1214262,
    'webcam_1214628': MyIconsClass.webcam_1214628,
    'weight_scale_1215873': MyIconsClass.weight_scale_1215873,
    'chip_1215874': MyIconsClass.chip_1215874,
    'circuit_1215875': MyIconsClass.circuit_1215875,
    'computer_1214269': MyIconsClass.computer_1214269,
    'computer_mouse_1214261': MyIconsClass.computer_mouse_1214261,
    'book_1214151': MyIconsClass.book_1214151,
    'book_1214152': MyIconsClass.book_1214152,
    'book_1214158': MyIconsClass.book_1214158,
    'bookmark_in_book_1215959': MyIconsClass.bookmark_in_book_1215959,
    'brain_1214150': MyIconsClass.brain_1214150,
    'cells_1214163': MyIconsClass.cells_1214163,
    'conical_flask_1214149': MyIconsClass.conical_flask_1214149,
    'conical_flask_1214162': MyIconsClass.conical_flask_1214162,
    'dna_1214146': MyIconsClass.dna_1214146,
    'hierarchy_1215952': MyIconsClass.hierarchy_1215952,
    'library_1214161': MyIconsClass.library_1214161,
    'mathemetics_calculation_1214169':
        MyIconsClass.mathemetics_calculation_1214169,
    'medal_1215956': MyIconsClass.medal_1215956,
    'mortarboard_1214168': MyIconsClass.mortarboard_1214168,
    'notes_1214160': MyIconsClass.notes_1214160,
    'open_book_1215958': MyIconsClass.open_book_1215958,
    'play_presentation_1215955': MyIconsClass.play_presentation_1215955,
    'podium_1214167': MyIconsClass.podium_1214167,
    'presentation_1215957': MyIconsClass.presentation_1215957,
    'presentation_board_1214148': MyIconsClass.presentation_board_1214148,
    'presentation_board_1214153': MyIconsClass.presentation_board_1214153,
    'presentation_board_1214154': MyIconsClass.presentation_board_1214154,
    'presentation_board_1214155': MyIconsClass.presentation_board_1214155,
    'presentation_board_1214156': MyIconsClass.presentation_board_1214156,
    'presentation_board_1214157': MyIconsClass.presentation_board_1214157,
    'presentation_board_1214166': MyIconsClass.presentation_board_1214166,
    'robot_1239434': MyIconsClass.robot_1239434,
    'school_bag_1214159': MyIconsClass.school_bag_1214159,
    'sperm_1215953': MyIconsClass.sperm_1215953,
    'telescope_1215954': MyIconsClass.telescope_1215954,
    'atomic_molecules_1214147': MyIconsClass.atomic_molecules_1214147,
    'award_1214165': MyIconsClass.award_1214165,
    'badge_1214164': MyIconsClass.badge_1214164,
    'bell_1214170': MyIconsClass.bell_1214170,
    'cheese_burger': MyIconsClass.cheese_burger,
    'flatware': MyIconsClass.flatware,
    'pizza': MyIconsClass.pizza,
    'assistive_listening_systems_1237464':
        MyIconsClass.assistive_listening_systems_1237464,
    'bandage_1214173': MyIconsClass.bandage_1214173,
    'care_1921392': MyIconsClass.care_1921392,
    'doctor_1921402': MyIconsClass.doctor_1921402,
    'ear_1237463': MyIconsClass.ear_1237463,
    'face_1921391': MyIconsClass.face_1921391,
    'health_1214171': MyIconsClass.health_1214171,
    'health_1214172': MyIconsClass.health_1214172,
    'health_1921390': MyIconsClass.health_1921390,
    'health_security_1921401': MyIconsClass.health_security_1921401,
    'heart_beat_1214186': MyIconsClass.heart_beat_1214186,
    'heart_rate_machine_1214185': MyIconsClass.heart_rate_machine_1214185,
    'hospital_sign_1921388': MyIconsClass.hospital_sign_1921388,
    'hospital_sign_1921389': MyIconsClass.hospital_sign_1921389,
    'mask_1921386': MyIconsClass.mask_1921386,
    'man_1921387': MyIconsClass.man_1921387,
    'medical_equipment_1921383': MyIconsClass.medical_equipment_1921383,
    'medical_1214188': MyIconsClass.medical_1214188,
    'medical_equipment_1921384': MyIconsClass.medical_equipment_1921384,
    'medical_equipment_1921385': MyIconsClass.medical_equipment_1921385,
    'medical_kit_1214183': MyIconsClass.medical_kit_1214183,
    'medical_file_1214184': MyIconsClass.medical_file_1214184,
    'medical_sign_board_1214175': MyIconsClass.medical_sign_board_1214175,
    'medicine_1214181': MyIconsClass.medicine_1214181,
    'medicine_1214182': MyIconsClass.medicine_1214182,
    'medicine_bottle_1214187': MyIconsClass.medicine_bottle_1214187,
    'no_virus_1921382': MyIconsClass.no_virus_1921382,
    'pulse_1215960': MyIconsClass.pulse_1215960,
    'nurse_1921381': MyIconsClass.nurse_1921381,
    'social_distance_1921399': MyIconsClass.social_distance_1921399,
    'shop_1921400': MyIconsClass.shop_1921400,
    'stay_in_home_1921397': MyIconsClass.stay_in_home_1921397,
    'social_distancing_1921398': MyIconsClass.social_distancing_1921398,
    'stretcher_1214180': MyIconsClass.stretcher_1214180,
    'syringe_1214179': MyIconsClass.syringe_1214179,
    'thermometer_1214178': MyIconsClass.thermometer_1214178,
    'virus_1921395': MyIconsClass.virus_1921395,
    'wheel_chair_1214177': MyIconsClass.wheel_chair_1214177,
    'tissue_paper_1921396': MyIconsClass.tissue_paper_1921396,
    'add_book_1214176': MyIconsClass.add_book_1214176,
    'alcohol_based_sanitizer_1921393':
        MyIconsClass.alcohol_based_sanitizer_1921393,
    'alcohol_based_sanitizer_1921394':
        MyIconsClass.alcohol_based_sanitizer_1921394,
    'ambulance_1214174': MyIconsClass.ambulance_1214174,
    'cart_1214047': MyIconsClass.cart_1214047,
    'gift_1215928': MyIconsClass.gift_1215928,
    'label_1214054': MyIconsClass.label_1214054,
    'qr_code_scan_1784370': MyIconsClass.qr_code_scan_1784370,
    'shop_1214046': MyIconsClass.shop_1214046,
    'shop_1214052': MyIconsClass.shop_1214052,
    'shop_1214053': MyIconsClass.shop_1214053,
    'shopping_bag_1214045': MyIconsClass.shopping_bag_1214045,
    'tag_1214044': MyIconsClass.tag_1214044,
    'tag_1214049': MyIconsClass.tag_1214049,
    'tag_1214050': MyIconsClass.tag_1214050,
    'tag_1214051': MyIconsClass.tag_1214051,
    'archive_1215927': MyIconsClass.archive_1215927,
    'basket_1214048': MyIconsClass.basket_1214048,
    'card_search_1784369': MyIconsClass.cardSearch_1784369,
    'card_to_card_transaction_1784371':
        MyIconsClass.cardToCardTransaction_1784371,
    'cart_1214043': MyIconsClass.cart_1214043,
    'hand_truck_1214380': MyIconsClass.handTruck_1214380,
    'luggage_1214387': MyIconsClass.luggage_1214387,
    'package_1214379': MyIconsClass.package_1214379,
    'metro_1408700': MyIconsClass.metro_1408700,
    'school_bus_1214385': MyIconsClass.schoolBus_1214385,
    'school_bus_1214386': MyIconsClass.schoolBus_1214386,
    'shipping_truck_1214384': MyIconsClass.shippingTruck1214384,
    'train_1214382': MyIconsClass.train_1214382,
    'train_1214383': MyIconsClass.train_1214383,
    'truck_1214381': MyIconsClass.truck_1214381,
    'boat_1214378': MyIconsClass.boat_1214378,
    'bus_1214377': MyIconsClass.bus_1214377,
    'car_1214375': MyIconsClass.car_1214375,
    'car_1214376': MyIconsClass.car_1214376,
  };

  static List<Category> listOfTempExpenseCategories = [];
  static List<Category> listOfTempIncomeCategories = [];

  static List<Category> listOfExpenseCategories = [
    Category(
      name: 'Продукты',
      color: '0xff34dbeb',
      icon: 'shopping_bag_1214045',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Техника',
      color: '0xff34eb40',
      icon: 'monitor_1214265',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Развлечения',
      color: '0xffd666e3',
      icon: 'cheese_burger',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Долг',
      color: '0xffe31414',
      icon: 'dollar_1214095',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Транспорт',
      color: '0xff893dd1',
      icon: 'bus_1214377',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Такси',
      color: '0xffc9d91e',
      icon: 'truck_1214381',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Здоровье',
      color: '0xffa30e0b',
      icon: 'heart_beat_1214186',
      categoryClassIndex: CategoryClass.expense.index,
    ),
    Category(
      name: 'Подарок',
      color: '0xfff02677',
      icon: 'gift_1215928',
      categoryClassIndex: CategoryClass.expense.index,
    ),
  ];

  static List<Category> listOfIncomesCategories = [
    Category(
      name: 'Зарплата',
      color: '0xff49c520',
      icon: 'invoice_1214071',
      categoryClassIndex: CategoryClass.income.index,
    ),
    Category(
      name: 'Стипендия',
      color: '0xff2068c5',
      icon: 'mortarboard_1214168',
      categoryClassIndex: CategoryClass.income.index,
    ),
  ];
}
