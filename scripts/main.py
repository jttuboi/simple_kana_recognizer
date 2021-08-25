import os
import glob
import shutil
import json
from zipfile import ZipFile
from unidecode import unidecode
from svgpathtools import svg2paths2

code_table = {

    # hiragana

    "03042": "あ",
    "03044": "い",
    "03046": "う",
    "03048": "え",
    "0304a": "お",

    "0304b": "か",
    "0304d": "き",
    "0304f": "く",
    "03051": "け",
    "03053": "こ",

    "03055": "さ",
    "03057": "し",
    "03059": "す",
    "0305b": "せ",
    "0305d": "そ",

    "0305f": "た",
    "03061": "ち",
    "03064": "つ",
    "03066": "て",
    "03068": "と",

    "0306a": "な",
    "0306b": "に",
    "0306c": "ぬ",
    "0306d": "ね",
    "0306e": "の",

    "0306f": "は",
    "03072": "ひ",
    "03075": "ふ",
    "03078": "へ",
    "0307b": "ほ",

    "0307e": "ま",
    "0307f": "み",
    "03080": "む",
    "03081": "め",
    "03082": "も",

    "03084": "や",
    "03086": "ゆ",
    "03088": "よ",

    "03089": "ら",
    "0308a": "り",
    "0308b": "る",
    "0308c": "れ",
    "0308d": "ろ",

    "0308f": "わ",
    "03092": "を",

    "03093": "ん",

    "0304c": "が",
    "0304e": "ぎ",
    "03050": "ぐ",
    "03052": "げ",
    "03054": "ご",

    "03056": "ざ",
    "03058": "じ",
    "0305a": "ず",
    "0305c": "ぜ",
    "0305e": "ぞ",

    "03060": "だ",
    "03062": "ぢ",
    "03065": "づ",
    "03067": "で",
    "03069": "ど",

    "03070": "ば",
    "03073": "び",
    "03076": "ぶ",
    "03079": "べ",
    "0307c": "ぼ",

    "03071": "ぱ",
    "03074": "ぴ",
    "03077": "ぷ",
    "0307a": "ぺ",
    "0307d": "ぽ",

    "03041": "ぁ",
    "03043": "ぃ",
    "03045": "ぅ",
    "03047": "ぇ",
    "03049": "ぉ",

    "03063": "っ",

    "03083": "ゃ",
    "03085": "ゅ",
    "03087": "ょ",

    # unused

    "0309d": "ゝ",
    "0309e": "ゞ",

    # "0308e": "ゎ",
    "03094": "ゔ",
    # "03095": "ゕ",
    # "03096": "ゖ",

    # "0309b": "゛",
    # "0309c": "゜",

    # katakana

    "030a2": "ア",
    "030a4": "イ",
    "030a6": "ウ",
    "030a8": "エ",
    "030aa": "オ",

    "030ab": "カ",
    "030ad": "キ",
    "030af": "ク",
    "030b1": "ケ",
    "030b3": "コ",

    "030b5": "サ",
    "030b7": "シ",
    "030b9": "ス",
    "030bb": "セ",
    "030bd": "ソ",

    "030bf": "タ",
    "030c1": "チ",
    "030c4": "ツ",
    "030c6": "テ",
    "030c8": "ト",

    "030ca": "ナ",
    "030cb": "ニ",
    "030cc": "ヌ",
    "030cd": "ネ",
    "030ce": "ノ",

    "030cf": "ハ",
    "030d2": "ヒ",
    "030d5": "フ",
    "030d8": "ヘ",
    "030db": "ホ",

    "030de": "マ",
    "030df": "ミ",
    "030e0": "ム",
    "030e1": "メ",
    "030e2": "モ",

    "030e4": "ヤ",
    "030e6": "ユ",
    "030e8": "ヨ",

    "030e9": "ラ",
    "030ea": "リ",
    "030eb": "ル",
    "030ec": "レ",
    "030ed": "ロ",

    "030ef": "ワ",
    "030f2": "ヲ",

    "030f3": "ン",

    "030ac": "ガ",
    "030ae": "ギ",
    "030b0": "グ",
    "030b2": "ゲ",
    "030b4": "ゴ",

    "030b6": "ザ",
    "030b8": "ジ",
    "030ba": "ズ",
    "030bc": "ゼ",
    "030be": "ゾ",

    "030c0": "ダ",
    "030c2": "ヂ",
    "030c5": "ヅ",
    "030c7": "デ",
    "030c9": "ド",

    "030d0": "バ",
    "030d3": "ビ",
    "030d6": "ブ",
    "030d9": "ベ",
    "030dc": "ボ",

    "030d1": "パ",
    "030d4": "ピ",
    "030d7": "プ",
    "030da": "ペ",
    "030dd": "ポ",

    "030a1": "ァ",
    "030a3": "ィ",
    "030a5": "ゥ",
    "030a7": "ェ",
    "030a9": "ォ",

    "030c3": "ッ",

    "030e3": "ャ",
    "030e5": "ュ",
    "030e7": "ョ",

    "030fc": "ー",

    # unused

    "030fd": "ヽ",
    "030fe": "ヾ",

    # "030ee": "ヮ",
    "030f4": "ヴ",
    # "030f5": "ヵ",
    # "030f6": "ヶ",
    # "030f7": "ヷ",
    # "030fa": "ヺ",
}

KANJIVG_ZIP = "kanjivg-20160426-all.zip"
CHECK_DATA_TXT = "check_data.txt"
POINTS_JSON = "points.json"
KANA_DATA_TXT = "kana_data.txt"
KANJI_FOLDER = "kanji/"
READY_FOLDER = "ready/"


def extract():
    print("extracting...")

    with ZipFile(KANJIVG_ZIP, "r") as zipObj:
        full_paths = zipObj.namelist()
        for full_path in full_paths:
            only_name = os.path.splitext(os.path.basename(full_path))[0]
            if only_name in code_table:
                zipObj.extract(full_path)


def rename():
    print("renaming...")

    if os.path.exists(READY_FOLDER):
        shutil.rmtree(READY_FOLDER)
    os.mkdir(READY_FOLDER)

    full_paths = glob.glob("%s*.svg" % (KANJI_FOLDER))
    for full_path in full_paths:
        try:
            only_name = os.path.splitext(os.path.basename(full_path))[0]
            os.rename(full_path, "%s%s.svg" % (READY_FOLDER, code_table[only_name]))
        except:
            print("key %s doesn't exist" % full_path)

    shutil.rmtree(KANJI_FOLDER)


def generate_data():
    print("generating data...")

    full_paths = glob.glob("%s*.svg" % (READY_FOLDER))
    check_data = CheckData()
    kana_data = KanaData()

    json_data = {}
    for full_path in full_paths:
        paths, attribute, svg_attributes = svg2paths2(full_path)
        image_size = get_image_size(svg_attributes)
        only_name = os.path.splitext(os.path.basename(full_path))[0]

        minimum_distance = image_size["width"] * 0.1
        check_data.start(only_name, minimum_distance)

        json_data[only_name] = []
        for path in paths:
            points = []
            check_data.add_path_init(path)
            for point_idx in range(len(path)):
                points.append(generate_point(path[point_idx].start, image_size))
                check_data.add_path_point(path[point_idx])
            points.append(generate_point(path.end, image_size))
            check_data.add_path_end(path.end)
            json_data[only_name].append(points)

        check_data.end()

        kana_data.add(only_name, len(paths))

    write_file(CHECK_DATA_TXT, check_data.get_data(json_data))
    write_file(READY_FOLDER + POINTS_JSON, json.dumps(json_data))
    write_file(READY_FOLDER + KANA_DATA_TXT, kana_data.get_data(), encode="utf16")


def get_image_size(svg_attributes):
    return {
        "width": float(svg_attributes["width"]),
        "height": float(svg_attributes["height"]),
    }


def generate_point(complex_point, image_size):
    return {  # normalize the coordinates [0..1]
        "x": complex_point.real / image_size["width"],
        "y": complex_point.imag / image_size["height"],
    }


def find_char(id):
    for code in code_table.values():
        if code["id"] == id:
            return code["char"]
    return ""


def write_file(filename, data, encode="utf8"):
    with open(filename, "w", encoding=encode) as file:
        file.writelines(data)


class KanaData:
    data = ""

    def add(self, id, maxStrokes):
        self.data += "%s %d\n" % (id, maxStrokes)
    
    def get_data(self):
        return self.data


class CheckData:
    data = ""
    s = ""

    def start(self, only_name, minimum_distance):
        self.s = "stroke=%s min_dist=%.1f" % (only_name, minimum_distance)

    def add_path_init(self, path):
        self.s += "\n%.2f|" % (round(path.length(), 2))

    def add_path_point(self, point):
        self.s += "(%d,%d) %.2f " % (round(point.start.real), round(point.start.imag), round(point.length(), 2))

    def add_path_end(self, path):
        self.s += "(%d,%d)" % (round(path.real), round(path.imag))

    def end(self):
        self.data += self.s + "\n\n"

    def get_data(self, json_data):
        return self.data + "\n\n" + str(json_data)


print("=== started")
extract()
rename()
generate_data()
print("=== ended")
