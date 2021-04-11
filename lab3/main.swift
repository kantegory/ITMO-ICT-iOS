import Foundation

// протоколы
protocol Description {
    var description: String { get }
}

protocol Company: Description {
    var ceo: CEOImpl? { get set }
}

protocol CEO: Description {
    var company: CompanyImpl? { get set }
    var productManager: ProductManagerImpl? { get set }
}

protocol Project: Description {}

protocol Task: Description {}

protocol ProductManager: Description {
    var ceo: CEOImpl? { get set }
    var developers: [DeveloperImpl] { get set }

    func getProject() -> ProjectImpl

    func getTask() -> TaskImpl

    func showCompany()
}

protocol Developer: Description {
    var productManager: ProductManagerImpl? { get set }

    func getProjectFromManager()

    func messageHandler(message: String)

    func sendMessage(message: String)

    func getTaskFromManager()

    func salaryRequestHandlerFromCEO()
}

// реализация протоколов
class CompanyImpl: Company, CustomStringConvertible {
    weak var ceo: CEOImpl?
    
    var description: String

    init(description: String) {
        self.description = description
    }

    deinit {
        print("Компания того-этого...")
        ceo = nil
    }
}

class CEOImpl: CEO, CustomStringConvertible {
    weak var company: CompanyImpl?
    weak var productManager: ProductManagerImpl?
    
    var description: String

    init(description: String) {
        self.description = description
    }

    lazy var showProductManager = {
        print("PM:", self.productManager ?? "Мы забыли продакта!")
    }

    lazy var showCompany = {
        self.productManager?.showCompany()
    }

    lazy var showDevelopers = {
        self.productManager?.showDevelopers()
    }

    lazy var salaryRequestHandler = {
        (developer: DeveloperImpl) in print("\(developer.fullName) просит денег")
    }

    deinit {
        print("CEO того-этого...")
        company = nil
        productManager = nil
    }
}

class ProjectImpl: Project, CustomStringConvertible {
    var description: String

    init(description: String) {
        self.description = description
    }
}

class TaskImpl: Task, CustomStringConvertible {
    var description: String

    init(description: String) {
        self.description = description
    }
}

class ProductManagerImpl: ProductManager, CustomStringConvertible  {
    weak var ceo: CEOImpl?
    var developers: [DeveloperImpl] = []

    var description: String

    init(description: String) {
        self.description = description
    }

    // функции для вывода информации
    func showDevelopers() {
        if let productManager = ceo?.productManager {
            print("Вот они наши все ребята вот они тут:")

            for developer in productManager.developers {
                print("Разработчик:", developer.fullName)
            }
        } else {
            print("Меня здесь нет...")
        }
    }

    func showCompany() {
        print("Компания:", ceo?.company ?? "Компания 404 кажется")

        print("CEO:", ceo ?? "CEO куда-то сбежал")

        print("PM:", ceo?.productManager ?? "PM куда-то сбежал")

        self.showDevelopers()
    }

    // получение проекта и таски
    func getProject() -> ProjectImpl {
        return ProjectImpl(
            description: "Наш новый проект"
        )
    }

    func getTask() -> TaskImpl {
        return TaskImpl(
            description: "Заработать over999999 в наносекунду"
        )
    }

    deinit {
        print("Продакт менеджер того-этого...")
        ceo = nil
        developers.removeAll()
    }
}

class DeveloperImpl: Developer, CustomStringConvertible  {
    weak var productManager: ProductManagerImpl?

    let fullName: String

    init(fullName: String) {
        self.fullName = fullName
    }

    var description: String {
        return "Я \(fullName)"
    }

    // для общения между собой
    func messageHandler(message: String) {
        print("\(fullName): \(message)")
    }

    func sendMessage(message: String) {
        productManager?
            .developers
            .randomElement()?
            .messageHandler(
                message: message
            )
    }

    // для взаимодействия с менеджером
    func getProjectFromManager() {
        let _project = productManager?.getProject()

        if let project = _project {
            print("Получен проект от менеджера: \(project)")
        } else {
            print("Проектов пока нет... Можно отдыхать!")
        }
    }

    func getTaskFromManager() {
        let _task = productManager?.getTask()

        if let task = _task {
            print("Менеджер дал задачу: \(task)")
        } else {
            print("Задач пока нет... Закрывай свою jira...")
        }
    }

    func salaryRequestHandlerFromCEO() {
        productManager?.ceo?.salaryRequestHandler(self)
    }

    deinit {
        print("Разработчик \(fullName) того-этого...")
        productManager = nil
    }
}

// проверяем работу
func testCompany() {
    let sep: String = "==============="

    let company = CompanyImpl(
        description: "Номер один на рынке!"
    )

    let ceo = CEOImpl(
        description: "CEO в компании номер один на рынке!"
    )

    company.ceo = ceo
    ceo.company = company

    let productManager = ProductManagerImpl(
        description: "PM в компании номер один на рынке!"
    )

    productManager.ceo = ceo
    ceo.productManager = productManager

    // заведём девелоперов
    let developerVasya = DeveloperImpl(fullName: "Василий Пупочкин")
    developerVasya.productManager = productManager

    let developerKostya = DeveloperImpl(fullName: "Константин Васильев")
    developerKostya.productManager = productManager

    let developerAnton = DeveloperImpl(fullName: "Антон Выгловский")
    developerAnton.productManager = productManager

    // добавим их productManager'у
    productManager.developers.append(developerVasya)
    productManager.developers.append(developerKostya)
    productManager.developers.append(developerAnton)

    // посмотрим работает ли взаимодействие между девелоперами
    productManager.developers[0].getProjectFromManager()
    productManager.developers[0].getTaskFromManager()
    productManager.developers[0].salaryRequestHandlerFromCEO()

    productManager.developers[0].sendMessage(
        message: "Проверь мой MR, он висит уже неделю :("
    )

    productManager.developers[1].sendMessage(
        message: "Я видел его MR, он и правда хорош!"
    )

    productManager.developers[2].sendMessage(
        message: "Это рабочий чат, хорош флудить"
    )

    print(sep)

    // выведем продакта
    ceo.showProductManager()

    print(sep)

    // покажем всех девелоперов
    ceo.showDevelopers()

    print(sep)

    ceo.showCompany()

    print(sep)
}

testCompany()
