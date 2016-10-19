# 01新添关键字


### mutating

---

在Swift中，包含三种类型(type): structure,enumeration,class. 其中structure和enumeration是`值类型(value type)`,class是`引用类型(reference type)`.

但是与objective-c不同的是，structure和enumeration也可以`拥有方法(method)`，其中方法可以为`实例方法(instance method)`，也可以为`类方法(type method)`。虽然结构体和枚举可以定义自己的方法，但是默认情况下，实例方法中是`不可以修改值类型的属性`。

在使用 class 来实现带有 mutating 的方法的接口时，具体实现的前面是不需要加 mutating 修饰的，因为 class 可以随意更改自己的成员变量。所以说在接口里用 mutating 修饰方法，对于 class 的实现是完全透明，可以当作不存在的。

- 为了能够在实例方法中修改属性值，可以在方法定义前添加关键字mutating


``` swift
struct Point {
    var x = 0, y = 0

    mutating func moveXBy(a:Int,yBy b:Int) {
        x += a
        y += b
    }
}

var p = Point(x: 5, y: 5)

p.moveXBy(a: 3, yBy: 3)

```

- 在值类型的实例方法中，也可以直接修改self属性值。

``` swift
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()

```


---

Swift中`protocol`的功能比OC中强大很多，不仅能再class中实现，同时也适用于struct、enum。

使用 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量，在设计接口的时候，也要考虑到使用者程序的扩展性。所以要多考虑使用mutating来修饰方法。

``` swift

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 110
    // 在 class 中实现带有mutating方法的接口时，不用mutating进行修饰。因为对于class来说，类的成员变量和方法都是透明的，所以不必使用 mutating 来进行修饰
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}
// 打印结果
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription


struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += "(adjusted)"
    }
}

enum SimpleEnum: ExampleProtocol {
    case First, Second, Third
    var simpleDescription: String {
        get {
            switch self {
            case .First:
                return "first"
            case .Second:
                return "second"
            case .Third:
                return "third"
            }
        }

        set {
            simpleDescription = newValue
        }
    }

    mutating func adjust() {

    }
}
```
