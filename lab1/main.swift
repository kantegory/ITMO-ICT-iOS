// TODO:

// [+] 1. Придумайте архитектуру для подсказок поисковой строки. 
// Подсказки бывают с текстом, ссылкой, картинкой и 
// сочетанием нескольких вариантов. У каждой подсказки должен быть id.

// Всего у нас может быть семь вариаций:
//   1) Текст
//   2) Картинка
//   3) Ссылка
//   4) Текст + картинка
//   5) Текст + ссылка
//   6) Картинка + ссылка
//   7) Текст + картинка + ссылка

// [+] 2. Сделайте протоколы для всех видов подсказок и их сочетаний.

// [+] 3. Сделайте протокол класса, выдающего подсказки. 
// Подразумевается, что на любую строку есть хотя бы одна подсказка. 
// Он должен инициализироваться от строки (строка -- константа), 
// подбирать подсказки, возвращать количество подсказок и любую из подсказок.

// [+] 4. Сделайте расширение на любой протокол.

// 5. Реализуйте по объекту на каждый протокол

// 6. Реализуйте класс, выдающий подсказки и продемонстрируйте его функционал.

protocol TextHintProto {
    var textField: String { get set }
}

protocol ImageHintProto {
    var imageField: String { get set }
}

protocol LinkHintProto {
    var linkField: String { get set }
}

protocol TextWithImageHintProto: TextHintProto, ImageHintProto {}

protocol TextWithLinkHintProto: TextHintProto, LinkHintProto {}

protocol ImageWithLinkHintProto: ImageHintProto, LinkHintProto {}

protocol TextWithImageAndLinkHintProto: TextHintProto, ImageHintProto, LinkHintProto {}

// протокол класса, выдающего подсказки
protocol HintProto {
    init(searchField: String)

    func getHint()
}

// расширение для класса LinkHintProto
class LinkHint: LinkHintProto {
    var linkField: String

    init(linkField: String) {
        self.linkField = linkField
    }
}

extension LinkHint {
    var formattedLinkField: String {
        return "https://\(linkField)"
    }    
}

var link: LinkHint = LinkHint(linkField: "online.swiftplayground.run")

// print(link.formattedLinkField)

// реализуем по объекту на каждый протокол,
// для этого нам надо либо создать по классу
// на каждый протокол, либо по структуре
// но поскольку мы уже делали класс для
// LinkHint - будем делать по классу
class TextHint: TextHintProto {
    var textField: String

    init(textField: String) {
        self.textField = textField
    }
}

class ImageHint: ImageHintProto {
    var imageField: String

    init(imageField: String) {
        self.imageField = imageField
    }
}

class TextWithImageHint: TextWithImageHintProto {
    var textField: String
    var imageField: String

    init(textField: String, imageField: String) {
        self.textField = textField
        self.imageField = imageField
    }
}

class TextWithLinkHint: TextWithLinkHintProto {
    var textField: String
    var linkField: String

    init(textField: String, linkField: String) {
        self.textField = textField
        self.linkField = linkField
    }
}

class ImageWithLinkHint: ImageWithLinkHintProto {
    var imageField: String
    var linkField: String

    init(imageField: String, linkField: String) {
        self.imageField = imageField
        self.linkField = linkField
    }
}

class TextWithImageAndLinkHint: TextWithImageAndLinkHintProto {
    var textField: String
    var imageField: String
    var linkField: String

    init(textField: String, imageField: String, linkField: String) {
        self.textField = textField
        self.imageField = imageField
        self.linkField = linkField
    }
}

// теперь, когда все классы для всех прототипов реализованы
// можно наконец-то создать по объекту

// структура для проверки отрабатывания протокола
struct HintStruct: TextWithImageHintProto {
    var textField: String
    var imageField: String
}

var hint: HintStruct = HintStruct(
    textField: "Привет",
    imageField: "https://placekitten.com/250"
    // linkField: "https://github.com/kantegory"
)

// print(hint)

