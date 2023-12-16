import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiRoute = dotenv.get('API_ROUTE');
List<String> pageTitles = ['Choice', 'My Recipes', 'Setting'];
List<String> menuCategories = ['和食', '洋食', '中華', 'その他'];
List<String> ingredientCategories = ['肉類', '魚介類', '野菜類', 'その他'];
