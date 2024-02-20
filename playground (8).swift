import Foundation

func address(of object: UnsafeRawPointer) -> String {
    let addr=Int(bitPattern: object)
    return String(format: "%p", addr)
}

func address(off value: AnyObject) -> String {
    return "\(Unmanaged.passUnretained(value).toOpaque())"
}

class IOSCollectionStruct<T> {
    // Массив элементов
    var items: [T]
    
    init(items: [T]) {
        self.items = items
    }
    
    func append(_ item: T) {
        items.append(item)
    }
    
    func get(at index: Int) -> T {
        return items[index]
    }
    
    func set(at index: Int, to item: T) {
        items[index] = item
    }
    
    func count() -> Int {
        return items.count
    }
    
    func copy() -> IOSCollectionStruct<T> {
        return IOSCollectionStruct<T>(items: self.items)
    }
}

struct IOSCollection<T> {
    var arr: IOSCollectionStruct<T>
    
    init(arr: IOSCollectionStruct<T>) {
        self.arr = arr
    }
    
    mutating func append(_ item: T) {
        if !isKnownUniquelyReferenced(&arr) {
            arr = arr.copy()
        }
        arr.append(item)
    }
    
    func get(at index: Int) -> T {
        return arr.get(at: index)
    }
    
    mutating func set(at index: Int, to item: T) {
        if !isKnownUniquelyReferenced(&arr) {
            arr = arr.copy()
        }
        arr.set(at: index, to: item)
    }
    
    func count() -> Int {
        return arr.count()
    }
}

var arr: [Int] = [415,251,315,154,135]

var collection = IOSCollectionStruct(items: arr)

var iosCollection1 = IOSCollection(arr: collection) 
var iosCollection2 = iosCollection1

print(address(off: iosCollection1.arr))
print(address(off: iosCollection2.arr))

iosCollection2.append(777)
iosCollection2.append(333)
iosCollection2.append(666)

print(address(off: iosCollection1.arr))
print(address(off: iosCollection2.arr))