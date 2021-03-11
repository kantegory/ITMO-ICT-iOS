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

class TextHint: TextHintProto, PropertyLoopable {
    var textField: String

    init(textField: String) {
        self.textField = textField
    }
}

class ImageHint: ImageHintProto, PropertyLoopable {
    var imageField: String

    init(imageField: String) {
        self.imageField = imageField
    }
}

class TextWithImageHint: TextWithImageHintProto, PropertyLoopable {
    var textField: String
    var imageField: String

    init(textField: String, imageField: String) {
        self.textField = textField
        self.imageField = imageField
    }
}

class TextWithLinkHint: TextWithLinkHintProto, PropertyLoopable {
    var textField: String
    var linkField: String

    init(textField: String, linkField: String) {
        self.textField = textField
        self.linkField = linkField
    }
}

class ImageWithLinkHint: ImageWithLinkHintProto, PropertyLoopable {
    var imageField: String
    var linkField: String

    init(imageField: String, linkField: String) {
        self.imageField = imageField
        self.linkField = linkField
    }
}

class TextWithImageAndLinkHint: TextWithImageAndLinkHintProto, PropertyLoopable {
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
var linkHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "",
    imageField: "",
    linkField: "online.swiftplayground.run"
)

var textHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "This is a text field hint",
    imageField: "",
    linkField: ""
)

var imageHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "",
    imageField: "https://placekitten.com/250",
    linkField: ""
)

var textWithLinkHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "oh this is a text for a link below",
    imageField: "",
    linkField: "online.swiftplayground.run"
)

var textWithImageHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "oh, here is the kitten 250x250...",
    imageField: "https://placekitten.com/250",
    linkField: ""
)

var imageWithLinkHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "",
    imageField: "https://placekitten.com/250",
    linkField: "online.swiftplayground.run"
)

var textWithImageAndLinkHint: TextWithImageAndLinkHint = TextWithImageAndLinkHint(
    textField: "All the fields there",
    imageField: "https://placekitten.com/250",
    linkField: "online.swiftplayground.run"
)

// протокол класса, выдающего подсказки
protocol HintProto {
    init(searchField: String, hints: [TextWithImageAndLinkHint])

    func getHint() -> [String: Any]
}

// реализуем класс для выдачи подсказок
class Hint: HintProto {
    let searchField: String
    let hints: [TextWithImageAndLinkHint]

    required init(searchField: String, hints: [TextWithImageAndLinkHint]) {
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

let hinter: Hint = Hint(searchField: "oh", hints: hints)

print(hinter.getHint())
