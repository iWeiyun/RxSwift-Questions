# List Of RxSwift Questions



#### 1. 如下代码执行结果是什么样的？
```swift
let o = Observable.from([1,2,3]).publish()
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
_ = o.connect()
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 2 3 1 2 3 1 2 3`
- B: `1 2 3 1 2 3`
- C: `1 1 2 2 3 3`
- D: `1 1 2 2 3 3 1 2 3`

----

#### 2. 如下代码执行结果是什么样的？
```swift
let o = Observable.from([1,2,3]).replay(2)
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
_ = o.connect()
_ = o.subscribe(onNext: { print($0) })
_ = o.connect()
```

- A: `1 1 2 2 3 3 1 2 3`
- B: `1 1 2 2 3 3 2 3`
- C: `1 1 2 2 3 3 1 1 1 2 2 2 3 3 3`
- D: `1 1 2 2 3 3 2 3 1 1 1 2 2 2 3 3 3`

----

#### 3. 如下代码执行结果是什么样的？
```swift
let o = Observable.from([1,2,3]).share(replay: 2)
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 2 3 1 2 3 1 2 3`
- B: `1 2 3 2 3 2 3`
- C: `2 3 2 3 2 3`
- D: `1 1 1 2 2 2 3 3 3`

----

#### 4. 如下代码执行结果是什么样的？
```swift
let o = Observable.from([1,2,3]).share(replay: 1, scope: .forever)
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 2 3 1 2 3 1 2 3`
- B: `1 2 3 3 3`
- C: `3 3 3`
- D: `1 1 1 2 2 2 3 3 3`

----

#### 5. 如下两段代码的执行结果分别是什么样的？
```swift
let o = Observable.from([1,2]).share(replay: 1, scope: .forever)
let d1 = o.subscribe(onNext: { print($0) })
d1.dispose()
_ = o.subscribe(onNext: { print($0) })
```
```swift
let o = Observable.from([1,2]).concat(Observable.never()).share(replay: 1, scope: .forever)
let d1 = o.subscribe(onNext: { print($0) })
d1.dispose()
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 2 2 1 2` 和 `1 2 2`
- B: `1 2 2 1 2` 和 `1 2 2 1 2`
- C: `1 2 2` 和 `1 2 2`
- D: `1 2 2` 和 `1 2 2 1 2`

----

#### 6. 如下代码执行结果是什么样的？
```swift
let s = PublishSubject<Int>()
let t = s.throttle(.seconds(2), scheduler: MainScheduler.instance)
let d = s.debounce(.seconds(2), scheduler: MainScheduler.instance)
_ = d.subscribe(onNext: { print("b" + String($0)) })
_ = t.subscribe(onNext: { print("a" + String($0)) })
s.onNext(1)
_ = Observable<Never>.empty().delay(.seconds(1), scheduler: MainScheduler.instance).subscribe {
    s.onNext(2)
}
```

- A: `b1 b2 a2`
- B: `a1 a2 b2`
- C: `a1 b1 a2 b2`
- D: `a1 b2 a2`

----

#### 7. 如下代码执行结果是什么样的？
```swift
let o = Observable.from(1...10).groupBy { $0 % 3 }.flatMap { $0.toArray() }
_ = o.subscribe(onNext: { print($0) })
```

- A: `[1, 4, 7, 10]`
- B: `[1, 2, 3]`、`[4, 5, 6]` 和 `[7, 8, 9]`
- C: `[1, 4, 7, 10]`、`[2, 5, 8]` 和 `[3, 6, 9]`
- D: `[1, 2, 3]`、`[4, 5, 6]`、`[7, 8, 9]` 和 `[10]`

----

#### 8. 如下代码执行结果是什么样的？
```swift
let o = Observable.from(1...10).groupBy { $0 % 3 }.concatMap { $0 }
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 4 7 10`
- B: `1 2 3 4 5 6 7 8 9`
- C: `1 4 7 10 2 5 8 3 6 9`
- D: `1 2 3 4 5 6 7 8 9 10`

----

#### 9. 如下代码执行结果是什么样的？
```swift
let o = Observable.from(1...10).groupBy { $0 % 3 }.flatMap { $0 }
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 4 7 10`
- B: `1 2 3 4 5 6 7 8 9`
- C: `1 4 7 10 2 5 8 3 6 9`
- D: `1 2 3 4 5 6 7 8 9 10`

----

#### 10. 如下代码执行结果是什么样的？
```swift
let o1 = Observable.interval(.seconds(1), scheduler: MainScheduler.instance).map{ String(UnicodeScalar(UInt8($0 + 97))) }.take(3)
let o2 = Observable<Int>.interval(.milliseconds(700), scheduler: MainScheduler.instance).take(4)
_ = Observable.combineLatest(o1, o2) { $0 + String($1) }.subscribe(onNext: { print($0) })
```

- A: `a0 b1 c2`
- B: `a0 a1 b1 b2 c2 c3`
- C: `a0 a1 b1 b2 b3 c3`
- D: `a0 b1 c2 c3`

----

#### 11. 如下代码执行结果是什么样的？
```swift
var error = true
_ = Observable.of(1, 2, 3, 4).flatMap { v -> Observable<Int> in
    if v == 2, error {
        error = false
        return Observable.error(TestError())
    }
    return Observable.of(v)
}.materialize()
.filter { $0.error == nil }
.dematerialize()
.retry()
.subscribe(onNext: { r in
    print(r)
})
```

- A: `1 2 3 4`
- B: `1 2 1 2 3 4`
- C: `1 1 2 3 4`
- D: `1`

----

#### 意料之外的结果
```swift
let o1 = Observable.from(97...100).map{ String(UnicodeScalar(UInt8($0))) }
let o2 = Observable.from(1...5)
_ = Observable.combineLatest(o1, o2) { ($0, $1) }.subscribe(onNext: { print($0) })
```