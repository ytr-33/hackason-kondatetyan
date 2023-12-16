import 'package:kondate_app/services/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ai_answer_provider.g.dart';

// スプラッシュ画面で準備したデータを残しておくために keepAlive する
@Riverpod(keepAlive: true)
class AiAnswerNotifier extends _$AiAnswerNotifier {
  @override
  Future<String> build(List<num> selectedIngredients) async {
    return await postRecipeAiProposalFromApi(selectedIngredients);
  } 
}
