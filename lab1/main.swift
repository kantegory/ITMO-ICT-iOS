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

print(link.formattedLinkField)

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

print(hint)

