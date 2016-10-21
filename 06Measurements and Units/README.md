# Measurements and Units
[WWDC session 238](https://developer.apple.com/videos/play/wwdc2016/238/) 中介绍到关于Measurements and Units 的一些内容

---
- 量度转换

``` swift
let distance = Measurement(value: 106.4, unit: UnitLength.kilometers)
/***************************************/
// 1.量度转换
let distanceInMeters = distance.converted(to: .meters)
// → 106400 m
let distanceInMiles = distance.converted(to: .miles)
// → 66.1140591795394 mi
let distanceInFurlongs = distance.converted(to: .furlongs)
// → 528.911158832419 fur

```
---
- 自定义Unit自定义单位

``` swift
let distance = Measurement(value: 106.4, unit: UnitLength.kilometers)
/***************************************/
// 2.自定义Unit自定义单位
extension UnitLength {
    static var leagues: UnitLength {
        // 1 league = 5556 meters
        return UnitLength(symbol: "leagues",
                          converter: UnitConverterLinear(coefficient: 5556))
    }
}
let distanceInLeagues = distance.converted(to: .leagues)
// → 19.150467962563 leagues

```
---
- 量度单位转换

``` swift
let distance = Measurement(value: 106.4, unit: UnitLength.kilometers)
/***************************************/
// 3. 量度单位转换
let doubleDistance = distance * 2
// → 212.8 km
let distance2 = distance + Measurement(value: 5, unit: UnitLength.kilometers)
// → 111.4 km
// 当单位不同时候,将单位转换为the base unit of UnitLength 而不是原始的
let distance3 = distance + Measurement(value: 10, unit: UnitLength.miles)
// → 122493.4 m

```
---
- formatter

``` swift
let distance = Measurement(value: 106.4, unit: UnitLength.kilometers)

/***************************************/
// 4. format
let formatter = MeasurementFormatter()
let 🇩🇪 = Locale(identifier: "de_DE")
formatter.locale = 🇩🇪
formatter.string(from: distance) // "106,4 km"

let 🇺🇸 = Locale(identifier: "en_US")
formatter.locale = 🇺🇸
formatter.string(from: distance) // "66.114 mi"

let 🇨🇳 = Locale(identifier: "zh_Hans_CN")
formatter.locale = 🇨🇳
formatter.string(from: distance) // "106.4公里"
```
---
- 重命名typealias

``` swift
// 5.重命名typealias
typealias Length = Measurement<UnitLength>
let d = Length(value: 5, unit: .kilometers)

typealias Duration = Measurement<UnitDuration>
let t = Duration(value: 10, unit: .seconds)
```
---
- unit 之间的关系

``` swift
let distance = Measurement(value: 106.4, unit: UnitLength.kilometers)

/***************************************/

let time = Measurement(value: 8, unit: UnitDuration.hours)
    + Measurement(value: 6, unit: UnitDuration.minutes)
    + Measurement(value: 17, unit: UnitDuration.seconds)

// 由于类型不同不能相除,所以自定义除法,overload除法
func / (lhs: Measurement<UnitLength>, rhs: Measurement<UnitDuration>) -> Measurement<UnitSpeed> {
    let quantity = lhs.converted(to: .meters).value / rhs.converted(to: .seconds).value
    let resultUnit = UnitSpeed.metersPerSecond
    return Measurement(value: quantity, unit: resultUnit)
}

let speed = distance / time

// → 3.64670802344312 m/s
speed.converted(to: .kilometersPerHour)
// → 13.1281383818845 km/h


```

---

UnitProduct 协议

``` swift
/// Describes the relation Self = Factor1 * Factor2.
protocol UnitProduct {
    associatedtype Factor1: Dimension
    associatedtype Factor2: Dimension
    associatedtype Product: Dimension // is always == Self

    static func defaultUnitMapping() -> (Factor1, Factor2, Product)
}


extension UnitLength: UnitProduct {
    typealias Factor1 = UnitSpeed
    typealias Factor2 = UnitDuration
    typealias Product = UnitLength

    static func defaultUnitMapping() -> (UnitSpeed, UnitDuration, UnitLength) {
        return (.metersPerSecond, .seconds, .meters)
    }
}

// 重载乘法操作符
func * <UnitType: UnitProduct> (lhs: Measurement<UnitType.Factor1>, rhs: Measurement<UnitType.Factor2>)
    -> Measurement<UnitType> where UnitType: Dimension, UnitType == UnitType.Product {
        let (leftUnit, rightUnit, resultUnit) = UnitType.defaultUnitMapping()
        let quantity = lhs.converted(to: leftUnit).value
            * rhs.converted(to: rightUnit).value
        return Measurement(value: quantity, unit: resultUnit)
}

let speed = Measurement(value: 20, unit: UnitSpeed.kilometersPerHour)
// → 20.0 km/h
let time = Measurement(value: 2, unit: UnitDuration.hours)
// → 2.0 hr

//类型检查器还不能推断出返回值的类型，所以我们必须明确的指定其为 Measurement<UnitLength> 类型，我不能非常确定这是为什么。我尝试了 * 运算符泛型参数的各种约束，但还是不能让它正常工作。
let distance: Measurement<UnitLength> = speed * time
// → 40000.032 m

```
* 让乘法可交换 重载其他操作符


``` swift
func * <UnitType: UnitProduct>(lhs: Measurement<UnitType.Factor2>, rhs: Measurement<UnitType.Factor1>)
    -> Measurement<UnitType> where UnitType: Dimension, UnitType == UnitType.Product {
        return rhs * lhs
}

let distance2: Measurement<UnitLength> = time * speed


func / <UnitType: UnitProduct>(lhs: Measurement<UnitType>, rhs: Measurement<UnitType.Factor1>)
    -> Measurement<UnitType.Factor2> where UnitType: Dimension, UnitType == UnitType.Product {
        let (rightUnit, resultUnit, leftUnit) = UnitType.defaultUnitMapping()
        let quantity = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
        return Measurement(value: quantity, unit: resultUnit)
}

/// UnitProduct / Factor2 = Factor1
func / <UnitType: UnitProduct>(lhs: Measurement<UnitType>, rhs: Measurement<UnitType.Factor2>)
    -> Measurement<UnitType.Factor1> where UnitType: Dimension, UnitType == UnitType.Product {
        let (resultUnit, rightUnit, leftUnit) = UnitType.defaultUnitMapping()
        let quantity = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
        return Measurement(value: quantity, unit: resultUnit)
}

let timeReversed = distance / speed
// → 7200.0 s
timeReversed.converted(to: .hours)
// → 2.0 hr
let speedReversed = distance / time
// → 5.55556 m/s
speedReversed.converted(to: .kilometersPerHour)
// → 20.0 km/h


```

* 通过 5 行代码实现协议

``` swift

/// UnitElectricPotentialDifference = UnitElectricResistance * UnitElectricCurrent
extension UnitElectricPotentialDifference: UnitProduct {
    static func defaultUnitMapping() -> (UnitElectricResistance, UnitElectricCurrent, UnitElectricPotentialDifference) {
        return (.ohms, .amperes, .volts)
    }
}

let voltage = Measurement(value: 5, unit: UnitElectricPotentialDifference.volts)
// → 5.0 V
let current = Measurement(value: 500, unit: UnitElectricCurrent.milliamperes)
// → 500.0 mA
let resistance = voltage / current
// → 10.0 Ω

```

- 在计算过程中保持单位


到目前为止，我们仍然使用一个默认的单位映射作为计算结果的单位。比如说，UnitSpeed，UnitDuration 和 UnitLength 的映射是 (.metersPerSecond, .seconds, .meters)。这意味着 72 千米每 2 小时 将会在计算前被转换成 72000 米每 7200 秒。然后我们会将计算结果封装成 Measurement<UnitVelocity> 并且返回，它的单位将会是米每秒。


``` swift

```
