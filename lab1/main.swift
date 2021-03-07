// TODO:

// 1. Придумайте архитектуру для подсказок поисковой строки. 
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

// 2. Сделайте протоколы для всех видов подсказок и их сочетаний.

// 3. Сделайте протокол класса, выдающего подсказки. 
// Подразумевается, что на любую строку есть хотя бы одна подсказка. 
// Он должен инициализироваться от строки (строка -- константа), 
// подбирать подсказки, возвращать количество подсказок и любую из подсказок.

// 4. Сделайте расширение на любой протокол.

// 5. Реализуйте по объекту на каждый протокол

// 6.Реализуйте класс, выдающий подсказки и продемонстрируйте его функционал.

protocol TextHintProto {
    var textField: String { get set }
}

protocol ImageHintProto {
    var imageField: String { get set }
}

protocol LinkHintProto {
    var linkField: String { get set }
}

struct Hint: TextHintProto, ImageHintProto, LinkHintProto {
    var textField: String
    var imageField: String
    var linkField: String
}

var hint: Hint = Hint(
    textField: "Привет",
    imageField: "https://placekitten.com/250",
    linkField: "https://github.com/kantegory"
)

print(hint)
