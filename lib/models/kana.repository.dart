import 'dart:math';

import 'package:simple_kana_recognizer/controllers/kana.dart';
import 'package:simple_kana_recognizer/controllers/kana.interface.repository.dart';

class KanaRepository implements IKanaRepository {
  @override
  Kana getRandomKana() {
    return _kanas.values.elementAt(Random().nextInt(_kanas.length));
  }
}

final _kanas = {
  'ぁ': Kana('ぁ', 3),
  'あ': Kana('あ', 3),
  'ぃ': Kana('ぃ', 2),
  'い': Kana('い', 2),
  'ぅ': Kana('ぅ', 2),
  'う': Kana('う', 2),
  'ぇ': Kana('ぇ', 2),
  'え': Kana('え', 2),
  'ぉ': Kana('ぉ', 3),
  'お': Kana('お', 3),
  'か': Kana('か', 3),
  'が': Kana('が', 5),
  'き': Kana('き', 4),
  'ぎ': Kana('ぎ', 6),
  'く': Kana('く', 1),
  'ぐ': Kana('ぐ', 3),
  'け': Kana('け', 3),
  'げ': Kana('げ', 5),
  'こ': Kana('こ', 2),
  'ご': Kana('ご', 4),
  'さ': Kana('さ', 3),
  'ざ': Kana('ざ', 5),
  'し': Kana('し', 1),
  'じ': Kana('じ', 3),
  'す': Kana('す', 2),
  'ず': Kana('ず', 4),
  'せ': Kana('せ', 3),
  'ぜ': Kana('ぜ', 5),
  'そ': Kana('そ', 1),
  'ぞ': Kana('ぞ', 3),
  'た': Kana('た', 4),
  'だ': Kana('だ', 6),
  'ち': Kana('ち', 2),
  'ぢ': Kana('ぢ', 4),
  'っ': Kana('っ', 1),
  'つ': Kana('つ', 1),
  'づ': Kana('づ', 3),
  'て': Kana('て', 1),
  'で': Kana('で', 3),
  'と': Kana('と', 2),
  'ど': Kana('ど', 4),
  'な': Kana('な', 4),
  'に': Kana('に', 3),
  'ぬ': Kana('ぬ', 2),
  'ね': Kana('ね', 2),
  'の': Kana('の', 1),
  'は': Kana('は', 3),
  'ば': Kana('ば', 5),
  'ぱ': Kana('ぱ', 4),
  'ひ': Kana('ひ', 1),
  'び': Kana('び', 3),
  'ぴ': Kana('ぴ', 2),
  'ふ': Kana('ふ', 4),
  'ぶ': Kana('ぶ', 6),
  'ぷ': Kana('ぷ', 5),
  'へ': Kana('へ', 1),
  'べ': Kana('べ', 3),
  'ぺ': Kana('ぺ', 2),
  'ほ': Kana('ほ', 4),
  'ぼ': Kana('ぼ', 6),
  'ぽ': Kana('ぽ', 5),
  'ま': Kana('ま', 3),
  'み': Kana('み', 2),
  'む': Kana('む', 3),
  'め': Kana('め', 2),
  'も': Kana('も', 3),
  'ゃ': Kana('ゃ', 3),
  'や': Kana('や', 3),
  'ゅ': Kana('ゅ', 2),
  'ゆ': Kana('ゆ', 2),
  'ょ': Kana('ょ', 2),
  'よ': Kana('よ', 2),
  'ら': Kana('ら', 2),
  'り': Kana('り', 2),
  'る': Kana('る', 1),
  'れ': Kana('れ', 2),
  'ろ': Kana('ろ', 1),
  'わ': Kana('わ', 2),
  'を': Kana('を', 3),
  'ん': Kana('ん', 1),
  'ゔ': Kana('ゔ', 4),
  'ゝ': Kana('ゝ', 1),
  'ゞ': Kana('ゞ', 3),
  'ァ': Kana('ァ', 2),
  'ア': Kana('ア', 2),
  'ィ': Kana('ィ', 2),
  'イ': Kana('イ', 2),
  'ゥ': Kana('ゥ', 3),
  'ウ': Kana('ウ', 3),
  'ェ': Kana('ェ', 3),
  'エ': Kana('エ', 3),
  'ォ': Kana('ォ', 3),
  'オ': Kana('オ', 3),
  'カ': Kana('カ', 2),
  'ガ': Kana('ガ', 4),
  'キ': Kana('キ', 3),
  'ギ': Kana('ギ', 5),
  'ク': Kana('ク', 2),
  'グ': Kana('グ', 4),
  'ケ': Kana('ケ', 3),
  'ゲ': Kana('ゲ', 5),
  'コ': Kana('コ', 2),
  'ゴ': Kana('ゴ', 4),
  'サ': Kana('サ', 3),
  'ザ': Kana('ザ', 5),
  'シ': Kana('シ', 3),
  'ジ': Kana('ジ', 5),
  'ス': Kana('ス', 2),
  'ズ': Kana('ズ', 4),
  'セ': Kana('セ', 2),
  'ゼ': Kana('ゼ', 4),
  'ソ': Kana('ソ', 2),
  'ゾ': Kana('ゾ', 4),
  'タ': Kana('タ', 3),
  'ダ': Kana('ダ', 5),
  'チ': Kana('チ', 3),
  'ヂ': Kana('ヂ', 5),
  'ッ': Kana('ッ', 3),
  'ツ': Kana('ツ', 3),
  'ヅ': Kana('ヅ', 5),
  'テ': Kana('テ', 3),
  'デ': Kana('デ', 5),
  'ト': Kana('ト', 2),
  'ド': Kana('ド', 4),
  'ナ': Kana('ナ', 2),
  'ニ': Kana('ニ', 2),
  'ヌ': Kana('ヌ', 2),
  'ネ': Kana('ネ', 4),
  'ノ': Kana('ノ', 1),
  'ハ': Kana('ハ', 2),
  'バ': Kana('バ', 4),
  'パ': Kana('パ', 3),
  'ヒ': Kana('ヒ', 2),
  'ビ': Kana('ビ', 4),
  'ピ': Kana('ピ', 3),
  'フ': Kana('フ', 1),
  'ブ': Kana('ブ', 3),
  'プ': Kana('プ', 2),
  'ヘ': Kana('ヘ', 1),
  'ベ': Kana('ベ', 3),
  'ペ': Kana('ペ', 2),
  'ホ': Kana('ホ', 4),
  'ボ': Kana('ボ', 6),
  'ポ': Kana('ポ', 5),
  'マ': Kana('マ', 2),
  'ミ': Kana('ミ', 3),
  'ム': Kana('ム', 2),
  'メ': Kana('メ', 2),
  'モ': Kana('モ', 3),
  'ャ': Kana('ャ', 2),
  'ヤ': Kana('ヤ', 2),
  'ュ': Kana('ュ', 2),
  'ユ': Kana('ユ', 2),
  'ョ': Kana('ョ', 3),
  'ヨ': Kana('ヨ', 3),
  'ラ': Kana('ラ', 2),
  'リ': Kana('リ', 2),
  'ル': Kana('ル', 2),
  'レ': Kana('レ', 1),
  'ロ': Kana('ロ', 3),
  'ワ': Kana('ワ', 2),
  'ヲ': Kana('ヲ', 3),
  'ン': Kana('ン', 2),
  'ヴ': Kana('ヴ', 5),
  'ー': Kana('ー', 1),
  'ヽ': Kana('ヽ', 1),
  'ヾ': Kana('ヾ', 3),
};
