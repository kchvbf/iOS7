import Foundation

protocol GameDice {
    var numberDice: Int { get }
}
extension Int: GameDice {
    var numberDice: Int {
        return self
    }
}

let diceCoub = 4

print("На кубике выпало \(diceCoub.numberDice) ") 

@objc protocol CarProtocol {

    func drive()
    
    var maxSpeed: Int { get }
    
    @objc optional var maxCharge: String? { get }
}

class CarClass: CarProtocol {
    func drive() {
        print("Разгон до \(maxSpeed)")
    }
    
    var maxSpeed: Int
    
    init(maxSpeed: Int) {
        self.maxSpeed = maxSpeed
    }
}
let carClass = CarClass(maxSpeed: 220)
carClass.drive()


//////////////////////////////////////////////////////

protocol Coding {
    var time: Int { get set }
    
    var code: Int { get set }
    
    func writeCode(platform: Platform, programmersCount: Int)
}

protocol Stopping {
    func stopCoding()
}

enum Platform {
    case ios, android, web
}

class Company: Coding, Stopping {
    var time: Int
    var code: Int
    var programmers: Int
    var platforms: [Platform]
    
    init(programmers: Int, platforms: [Platform]) {
        self.programmers = programmers
        self.platforms = platforms
        self.time = 0
        self.code = 0
    }
    
    func writeCode(platform: Platform, programmersCount: Int) {
        guard platforms.contains(platform) else {
            print("Нет таких специалистов \(platform)")
            return
        }
        
        guard programmersCount <= programmers else {
            print("Недостаточно программистов")
            return
        }
        
        switch platform {
        case .web:
            time += 5 * programmersCount
            code += 300 * programmersCount
        case .android:
            time += 4 * programmersCount
            code += 200 * programmersCount
        case .ios:
            time += 3 * programmersCount
            code += 100 * programmersCount
        
        }
        
        print("Разработка началась - пишем код \(platform)")
    }
    
    func stopCoding() {
        print("Разработка завершена. Отправляю на тестирование")
        
        print("Времени затрачено: \(time) часов")
        print("В коде \(code) строк")
    }
}
var platforms = [Platform]()

platforms.append(Platform.android)
platforms.append(Platform.ios)


let chinases=Company(programmers: 66, platforms: platforms)
chinases.writeCode(platform: Platform.ios, programmersCount: 6)
chinases.stopCoding()

chinases.writeCode(platform: Platform.android, programmersCount: 9)
chinases.stopCoding()


chinases.writeCode(platform: Platform.android, programmersCount: 100)

chinases.writeCode(platform: Platform.web, programmersCount: 18)
