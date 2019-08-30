# List Of RxSwift Questions



#### 1. 用哪个操作符可以模拟promise的then

- A: `compactMap`
- B: `publish`
- C: `flatMap`
- D: `withLatestFrom`

----

#### 2. 如果要旁路一个Observable的事件，应该用什么操作符

- A: `do`
- B: `share`
- C: `repeatElement`
- D: `amb`

----

#### 3. 为防止按钮点击太频繁，在指定时间内点击多次也只触发一次，应该用哪个操作符？

- A: `buffer`
- B: `window`
- C: `debounce`
- D: `throttle`

----


#### 4. 如下哪个操作符，传入多个Observables后，只取第一个产生事件的Observable，忽略其他Observables？

- A: `amb`
- B: `buffer`
- C: `filter`
- D: `map`

----

#### 5. 如下哪个操作符，缓存元素，然后将缓存的元素集合周期性的发？

- A: `amb`
- B: `buffer`
- C: `filter`
- D: `timer`

----

#### 6. 关于catchError描述错误的是

- A: `从一个错误事件中恢复，将错误事件替换成一个备选序列`
- B: `拦截一个 error 事件，将它替换成其他的元素或者一组元素`
- C: `具备重试的能力`
- D: `可以使得 Observable 正常结束，或者根本都不需要结束`

----

#### 7. 有事件A与B，只有当A触发的时候B的订阅者才能收到之后的一个元素，可以用哪个操作符实现

- A: `takeUntil`
- B: `withLatestFrom`
- C: `skipUntil`
- D: `skipWhile`

----

#### 8. 信号A依次输出1、2、3，信号B依次输出X、Y、Z，想要得到X、1、Y、2、3、Z，可以使用什么命令

- A: `combineLatest`
- B: `zip`
- C: `merge`
- D: `startWith`

----

#### 9. 关于ConcatMap与FlatMap，以下说法正确的是？
- A: `ConcatMap可以将所有子 Observables 的元素发送出来`
- B: `FlatMap打印Observables的元素是按子Observables先后顺序依次打印的`
- C: `FlatMap过程会将每一个元素转换成Observables`
- D: `ConcatMap能够立即处理新的子Observables的订阅`

----

#### 10. 以下关于ControlEvent、ControlProperty的说法不正确的是？
- A: `一定在 MainScheduler 订阅`
- B: `一定在 MainScheduler 监听`
- C: `没有共享附加作用`
- D: `不会产生 error 事件`

----


#### 11. 以下关于操作符的说法不正确的是

- A: `flatMapLatest是map和switchLatest操作符的组合`
- B: `可以用withLatestFrom加distinctUntilChanged实现sample操作符`
- C: `amb命令只处理最先接收到的next事件的数据源，其他全部忽略`
- D: `在指定时间内没有发任何出元素，timeout操作符会产生一个超时的error事件`

----

#### 12. 如果想让订阅代码在指定线程执行，需要用哪个操作符

- A: `subscribeOn`
- B: `obseverOn`
- C: `materialize`
- D: `using`

----

#### 13. 如果Observable被多次订阅，但只希望执行一次创建代码，下面哪种方式是可以的

- A: `Single对象`
- B: `publish操作符`
- C: `refCount操作符`
- D: `buffer操作符`

----

#### 14. 下面哪个对象跟其它三个差别较大

- A: `Single`
- B: `Signal`
- C: `Driver`
- D: `ControlEvent`

-----

#### 15. 下面哪个对象不属于 Observable & Observer

- A: `PublishRelay`
- B: `ControlEvent`
- C: `ControlProperty`
- D: `BehaviorSubject`

----

#### 16. 下面哪个操作符也可以不需要手动调用complete/error也可以清理Rx的资源

- A: `skipWhile`
- B: `takeUntil`
- C: `sample`
- D: `refCount`

----

#### 17. 哪个操作符可将connectable的对象转为普通observable对象

- A: `refCount`
- B: `publish`
- C: `sample`
- D: `replay`

----


#### 18. 如下代码执行结果是？
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

#### 19. 如下代码执行结果是？
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

#### 20. 如下代码执行结果是？
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

#### 21. 如下代码执行结果是什么样的？
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

#### 22. 如下代码执行结果是？
```swift
let o = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
  .take(3)
  .share(replay: 2)
_ = o.subscribe(onNext: { print($0) })
_ = o.subscribe(onNext: { print($0) })
```

- A: `0 1 2 0 1 2 0 1 2`
- B: `0 1 2 1 2 1 2`
- C: `1 2 1 2 1 2`
- D: `0 0 1 1 2 2`

----

#### 23. 如下代码执行结果是？
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

#### 24. 如下代码执行结果是？
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

#### 25. 如下代码执行结果是？
```swift
let o = Observable.from(1...10).groupBy { $0 % 3 }.flatMap { $0.toArray() }
_ = o.subscribe(onNext: { print($0) })
```

- A: `[1, 4, 7, 10]`
- B: `[1, 2, 3]`、`[4, 5, 6]` 和 `[7, 8, 9]`
- C: `[1, 4, 7, 10]`、`[2, 5, 8]` 和 `[3, 6, 9]`
- D: `[1, 2, 3]`、`[4, 5, 6]`、`[7, 8, 9]` 和 `[10]`

----

#### 26. 如下代码执行结果是？
```swift
let o = Observable.from(1...10).groupBy { $0 % 3 }.concatMap { $0 }
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 4 7 10`
- B: `1 2 3 4 5 6 7 8 9`
- C: `1 4 7 10 2 5 8 3 6 9`
- D: `1 2 3 4 5 6 7 8 9 10`

----

#### 27. 如下代码执行结果是？
```swift
let o = Observable.from(1...10).groupBy { $0 % 3 }.flatMap { $0 }
_ = o.subscribe(onNext: { print($0) })
```

- A: `1 4 7 10`
- B: `1 2 3 4 5 6 7 8 9`
- C: `1 4 7 10 2 5 8 3 6 9`
- D: `1 2 3 4 5 6 7 8 9 10`

----

#### 28. 如下代码执行结果是？
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

#### 29. 如下代码执行结果是？
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

#### 30. 如下代码执行结果是？
```swift
let one = PublishSubject<String>()
let two = PublishSubject<String>()

let source = PublishSubject<Observable<String>>()
source.switchLatest().subscribe(onNext: { value in
    print(value)
})

one.onNext("1")
source.onNext(one)

two.onNext("X")
source.onNext(two)

one.onNext("2")
two.onNext("Y")
source.onNext(one)

one.onNext("3")
```

- A: `1 X Y`
- B: `1 Y 3`
- C: `Y 3`
- D: `1 X 2 Y`

----

#### 31. 如下代码执行结果是什么样的？
```swift
let ob = Observable<Int>.from([1, 2]).publish()
ob.subscribe(onNext: { _ in
    print("X")
})
ob.subscribe(onNext: { _ in
    print("Y")
})
ob.connect()
ob.subscribe(onNext: { _ in
    print("Z")
})
```

- A: `X Y X Y`
- B: `X Y X Y`
- C: `X Y Z X Y Z`
- D: `X X Y Y Z Z`

----

#### 32. 如下代码执行结果是什么样的？
```swift
let pbSubject = PublishSubject<Int>()
_ = pbSubject.debounce(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { print("d", $0) })

_ = pbSubject.throttle(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { print("t", $0) })

pbSubject.onNext(1)
pbSubject.onNext(2)
pbSubject.onNext(3)
```

- A: `d1 d3 t3`
- B: `t1 t3 d3`
- C: `t1 d3 t3`
- D: `d3 t1`

----

#### 33. 如下代码执行结果是什么样的？
```swift
let button = PublishSubject<Void>()
let textField = PublishSubject<String>()
button.withLatestFrom(textField).subscribe(onNext: { value in
    print(value)
})

textField.onNext("A")
textField.onNext("B")
textField.onNext("C")
button.onNext(())
button.onNext(())
```

- A: `A B C C C`
- B: `A A A B C`
- C: `C`
- D: `C C`

----

#### 34. 如下代码执行结果是？
```swift
var error = true
_ = Observable.of(1, 2, 3, 4).flatMap { v -> Observable<Int> in
    if v == 2, error {
        error = false
        return Observable.error(TestError.test)
    }
    return Observable.of(v)
}.retry()
.subscribe(onNext: { print($0) })
```

- A: `1 2 3 4`
- B: `1 2 1 2 3 4`
- C: `1 1 2 3 4`
- D: `1 2 3 4 1 2 3 4`

----

#### 35. 如下代码执行结果是？
```swift
let first: Single<Int> = Single.create { observer -> Disposable in
    observer(.success(1))
    observer(.success(2))
    return Disposables.create()
}

let second: Observable<Int> = Observable.create { observer -> Disposable in
    observer.onNext(3)
    observer.onNext(4)
    return Disposables.create()
}

_ = first.subscribe({ print($0) })
_ = first
    .asObservable()
    .single()
    .subscribe({ print($0) })

_ = second.subscribe({ print($0) })
_ = second
    .single()
    .subscribe({ print($0) })
```

- A: `error, next(1), error, next(3), next(4), next(3), error`
- B: `error, next(1), completed, next(3), next(4), next(3), error`
- C: `success(1), next(1), completed, next(3), next(4), next(3), completed`
- D: `success(1), next(1), completed, next(3), next(4), next(3), error`


