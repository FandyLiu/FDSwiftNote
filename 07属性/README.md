# 属性

- 存储属性

``` swift
struct Person {
    var name: String
    let card: String //常量存储属性
}
var p: Person = Person(name: "fandy", card: "11111")
p.name = "gxq"

// 不能改报错
p.card = "56789"

```


- 懒加载

``` swift
class Line {
    var start: Double = 0.0
    var end: Double = 0.0



    lazy var length: Double = self.getLength()

    lazy var container: Array<AnyObject> = {
        var arrM = [AnyObject]()
        return arrM
    }()

    func getLength() -> Double {
        return end - start
    }
}

var line = Line()
line.end = 150.0
print(line.length)
var arrM = line.container
arrM.append("5" as AnyObject)
arrM.append(2 as AnyObject)
print(arrM)

```

- 计算属性

计算属性不直接存储值
  跟存储属性不同,没有任何的"后端存储与之对应"

枚举不可以有存储属性, 但是允许有计算属性

``` swift
struct Rect {
    var origion: (x: Double, y: Double)
    var size: (w: Double, h: Double)
    var center: (x: Double, y: Double) {
        get {
            return (origion.x + size.w/2, origion.y + size.h/2)
        }
        set {
            origion.x = newValue.x - size.w / 2
            origion.y = newValue.y - size.h / 2
        }
    }
}


```

- 只读计算属性

所谓的只读属性就是只提供了getter方法, 没有提供setter方法

``` swift

class Line {
    var start:Double = 0.0
    var end: Double = 0.0
    // 只读属性, 只读属性必须是变量var, 不能是常量let
    var length: Double{
        // 只读属性的简写, 可以省略get{}
        return end - start
    }
}
var line = Line()
line.end = 100
print(line.length)


```

- 属性观察器

类似OC中的KVO

可以直接为除计算属性和lazy属性之外的存储属性添加属性观察器
但是可以在继承类中为父类的计算属性提供属性观察器因为在计算属性中也可以监听到属性的改变
所以给计算属性添加属性观察器没有任何意义

``` swift
class Line {
    var start: Double = 0.0{
        willSet{
            print("willSet newValue = \(newValue)")
        }
        didSet{
            print("didSet oldValue = \(oldValue)")
        }
    }
    var end: Double = 0.0
}
var l = Line()
l.start = 10.0


```
- 类属性

在结构体和枚举中用static
在类中使用class, 并且类中不允许将存储属性设置为类属性

``` swift

struct Person {
    var name: String = "fandy"
    static var gender: String = "man"
    static var age: Int{
        return 18
    }
    func show()
    {
        print("gender = \(Person.gender) name = \(name)")
    }
}
var p = Person()
print("gender = \(Person.gender)")


print("age = \(Person.age)")


```

``` swift

class Person {
    var name: String = "lnj"
    // 类中不允许将存储属性定义为类属性
    // 下面为错误写法
    // class var gender:String = "man"
    // 类中只能将计算属性定义为类属性
    class var age:Int{
        return 30
    }
    func show()
    {
        print("age = \(Person.age)")
    }
}
var p = Person()
print("age = \(Person.age)")
p.show()

```
