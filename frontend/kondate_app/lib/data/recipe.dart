// recipe.dart
import 'package:kondate_app/models/recipe.dart';

List<Recipe> recipes = [
  Recipe(1, 'ペペロンチーノ', '洋食', {'ベーコン': 300, 'ニンニク': 4}, '''
    手順1: パスタを茹でます。
    手順2: フライパンでニンニクを炒めます。
    手順3: ベーコンを加え、パスタが茹であがったら一緒に炒めます。
    手順4: 塩とこしょうで味を調えます。
    手順5: 盛り付けて完成です。
    '''),
  Recipe(2, 'カレーライス', '和食',
      {'牛肉': 500, 'じゃがいも': 3, 'にんじん': 2, '玉ねぎ': 1, 'カレールー': 1}, '''
    手順1: じゃがいもとにんじんを切り、玉ねぎをみじん切りにします。
    手順2: 牛肉を炒め、野菜を加えて炒めます。
    手順3: 鍋に水とカレールーを加え、混ぜながら煮ます。
    手順4: 野菜と肉の炒めたものを加えて煮込みます。
    手順5: ご飯の上にカレーをかけて完成です。
    '''),
  Recipe(3, '寿司', '和食', {'しゃけ': 300, 'ご飯': 2, '海苔': 5, '酢飯': 1}, '''
    手順1: ご飯を握り、しゃけをのせます。
    手順2: 海苔で巻きます。
    手順3: 切り分けます。
    手順4: 酢飯を添えます。
    手順5: 盛り付けて完成です。
    '''),
  Recipe(4, 'オムライス', '和食', {'鶏むね肉': 300, '玉ねぎ': 1, 'ご飯': 2, 'ケチャップ': 3, '卵': 4},
      '''
    手順1: 鶏むね肉と玉ねぎをみじん切りにします。
    手順2: フライパンで鶏むね肉を炒め、玉ねぎを加えて炒めます。
    手順3: ご飯を加え、ケチャップで炒めます。
    手順4: オムレツを作り、ご飯の上にのせます。
    手順5: 盛り付けて完成です。
    '''),
  Recipe(5, 'カルボナーラ', '洋食',
      {'スパゲッティ': 200, 'ベーコン': 150, '卵黄': 2, 'パルメザンチーズ': 50}, '''
    手順1: スパゲッティを茹でます。
    手順2: フライパンでベーコンを炒めます。
    手順3: 卵黄を加え、茹でたスパゲッティと混ぜます。
    手順4: パルメザンチーズを加え、さらに混ぜます。
    手順5: 盛り付けて完成です。
    '''),
  Recipe(6, 'チキンカレー', '和食',
      {'鶏もも肉': 400, 'じゃがいも': 3, 'にんじん': 2, '玉ねぎ': 1, 'カレールー': 1}, '''
    手順1: じゃがいもとにんじんを切り、玉ねぎをみじん切りにします。
    手順2: 鶏もも肉を炒め、野菜を加えて炒めます。
    手順3: 鍋に水とカレールーを加え、混ぜながら煮ます。
    手順4: 野菜と肉の炒めたものを加えて煮込みます。
    手順5: ご飯の上にカレーをかけて完成です。
    '''),
  Recipe(7, '和風サラダ', '和食', {'レタス': 1, 'トマト': 2, 'きゅうり': 1, 'ごまドレッシング': 3}, '''
    手順1: レタス、トマト、きゅうりを切ります。
    手順2: ボウルで野菜を混ぜ、ごまドレッシングをかけます。
    手順3: よく混ぜて完成です。
    手順4: グリルチキンやエビを加えても美味しいです。
    手順5: お好みでごまや青ねぎをトッピングしても良いです。
    '''),
  Recipe(8, 'マルゲリータピザ', '洋食',
      {'ピザ生地': 1, 'トマトソース': 2, 'モッツァレラチーズ': 150, 'バジル': 5}, '''
    手順1: ピザ生地をのばし、トマトソースを塗ります。
    手順2: モッツァレラチーズを散らし、バジルをのせます。
    手順3: 180℃のオーブンで10分焼いて完成です。
    手順4: トマトや生ハムを加えても美味しいです。
    手順5: オリーブオイルをかけても良いです。
    '''),
  Recipe(
      9, 'エビチリ', '中華', {'えび': 300, 'ピーマン': 5, '赤唐辛子': 2, '醤油': 3, '砂糖': 2}, '''
    手順1: えびは殻をむいておきます。
    手順2: ピーマンと赤唐辛子を薄切りにします。
    手順3: フライパンでえびを炒め、野菜を加えて炒めます。
    手順4: 醤油と砂糖を加え、絡めて完成です。
    手順5: お好みで青ねぎをトッピングしても良いです。
    '''),
  Recipe(10, 'カプレーゼサラダ', 'イタリアン',
      {'トマト': 2, 'モッツァレラチーズ': 150, 'バジル': 10, 'オリーブオイル': 3}, '''
    手順1: トマトとモッツァレラチーズを薄切りにします。
    手順2: 交互にトマトとチーズを並べ、バジルを散らします。
    手順3: オリーブオイルをかけて完成です。
    手順4: 塩とこしょうで味を調えても美味しいです。
    手順5: アクセントにバルサミコ酢を垂らしても良いです。
    '''),
  // ... (他のレシピ)
];
