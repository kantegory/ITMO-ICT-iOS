import Foundation
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

// [+] 5. Реализуйте по объекту на каждый протокол

// [+] 6. Реализуйте класс, выдающий подсказки и продемонстрируйте его функционал.
protocol Hint {
    var id: Int { get }
}

protocol TextHint: Hint {
    var textField: String { get set }
}

protocol ImageHint: Hint {
    var imageField: String { get set }
}

protocol LinkHint: Hint {
    var linkField: String { get set }
}

protocol TextWithImageHint: TextHint, ImageHint {}

protocol TextWithLinkHint: TextHint, LinkHint {}

protocol ImageWithLinkHint: ImageHint, LinkHint {}

protocol TextWithImageAndLinkHint: TextHint, ImageHint, LinkHint {}

// расширение для класса LinkHint
class LinkHintImpl: LinkHint {
    var id: Int
    var linkField: String

    init(id: Int, linkField: String) {
        self.id = id
        self.linkField = linkField
    }
}

extension LinkHintImpl {
    var formattedLinkField: String {
        return "https://\(linkField)"
    }    
}

var link: LinkHintImpl = LinkHintImpl(id: 1, linkField: "online.swiftplayground.run")

print(link.formattedLinkField)

// реализуем по объекту на каждый протокол,
// для этого нам надо либо создать по классу
// на каждый протокол, либо по структуре
// но поскольку мы уже делали класс для
// LinkHint - будем делать по классу
// хелперы для того, чтобы распаковать значения свойств класса
protocol PropertyLoopable
{
    func allProperties(searchField: String) -> [Any]
}

extension PropertyLoopable
{
    func allProperties(searchField: String) -> [Any] {

        var result: [String: String] = [:]

        let mirror = Mirror(reflecting: self)

        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }

            if label == "id" {
                continue
            }

            let val = valueMaybe as! String

            if val.contains(searchField) {
                result[label] = valueMaybe as! String
            } else {
                result["empty"] = "true"
            }
        }

        var filteredResult: [Any] = []

        for (key, val) in result {
            if key != "empty" {
                filteredResult.append([key: val])
            }
        }

        return filteredResult
    }
}

class TextHintImpl: TextHint, PropertyLoopable {
    var id: Int
    var textField: String

    init(id: Int, textField: String) {
        self.id = id
        self.textField = textField
    }
}

class ImageHintImpl: ImageHint, PropertyLoopable {
    var id: Int
    var imageField: String

    init(id: Int, imageField: String) {
        self.id = id
        self.imageField = imageField
    }
}

class TextWithImageHintImpl: TextWithImageHint, PropertyLoopable {
    var id: Int
    var textField: String
    var imageField: String

    init(id: Int, textField: String, imageField: String) {
        self.id = id
        self.textField = textField
        self.imageField = imageField
    }
}

class TextWithLinkHintImpl: TextWithLinkHint, PropertyLoopable {
    var id: Int
    var textField: String
    var linkField: String

    init(id: Int, textField: String, linkField: String) {
        self.id = id
        self.textField = textField
        self.linkField = linkField
    }
}

class ImageWithLinkHintImpl: ImageWithLinkHint, PropertyLoopable {
    var id: Int
    var imageField: String
    var linkField: String

    init(id: Int, imageField: String, linkField: String) {
        self.id = id
        self.imageField = imageField
        self.linkField = linkField
    }
}

class TextWithImageAndLinkHintImpl: TextWithImageAndLinkHint, PropertyLoopable {
    var id: Int
    var textField: String
    var imageField: String
    var linkField: String

    init(id: Int, textField: String, imageField: String, linkField: String) {
        self.id = id
        self.textField = textField
        self.imageField = imageField
        self.linkField = linkField
    }
}

// теперь, когда все классы для всех прототипов реализованы
// можно наконец-то создать по объекту
var linkHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 1,
    textField: "",
    imageField: "",
    linkField: "online.swiftplayground.run"
)

var textHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 2,
    textField: "This is a text field hint",
    imageField: "",
    linkField: ""
)

var imageHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 3,
    textField: "",
    imageField: "https://placekitten.com/250",
    linkField: ""
)

var textWithLinkHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 4,
    textField: "oh this is a text for a link below",
    imageField: "",
    linkField: "online.swiftplayground.run"
)

var textWithImageHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 5,
    textField: "oh, here is the kitten 250x250...",
    imageField: "https://placekitten.com/250",
    linkField: ""
)

var imageWithLinkHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 6,
    textField: "",
    imageField: "https://placekitten.com/250",
    linkField: "online.swiftplayground.run"
)

var textWithImageAndLinkHint: TextWithImageAndLinkHintImpl = TextWithImageAndLinkHintImpl(
    id: 7,
    textField: "All the fields there",
    imageField: "https://placekitten.com/250",
    linkField: "online.swiftplayground.run"
)

// протокол класса, выдающего подсказки
protocol HintGetter {
    init(searchField: String, hints: [TextWithImageAndLinkHintImpl])

    func getHint() -> [String: Any]
}

// реализуем класс для выдачи подсказок
class HintGetterImpl: HintGetter {
    let searchField: String
    let hints: [TextWithImageAndLinkHintImpl]

    required init(searchField: String, hints: [TextWithImageAndLinkHintImpl]) {
        self.searchField = searchField
        self.hints = hints
    }

    func getHint() -> [String: Any] {
        let hints = self.hints
        let searchField = self.searchField

        var searchedHint: [Any] = []

        for hint in hints {
            do {
                let hintProperties = try hint.allProperties(searchField: searchField)

                if hintProperties.count > 0 {
                    searchedHint.append(hintProperties)
                }
            } catch {
                continue
            }
        }

        return ["amount": searchedHint.count, "hints": searchedHint]
    }
}

let hints = [
    linkHint,
    textHint,
    imageHint,
    textWithLinkHint,
    textWithImageHint,
    imageWithLinkHint,
    textWithImageAndLinkHint
]

let hinter: HintGetterImpl = HintGetterImpl(searchField: "oh", hints: hints)

print(hinter.getHint())
