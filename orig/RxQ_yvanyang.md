# List Of RxSwift Questions



#### 1. 有事件A与B，只有当A触发的时候B的订阅者才能收到之后的一个元素，可以用哪个操作符实现

- A: `takeUntil`
- B: `withLatestFrom`
- C: `skipUntil`
- D: `skipWhile`

----

#### 2. 信号A依次输出1、2、3，信号B依次输出X、Y、Z，想要得到X、1、Y、2、3、Z，可以使用什么命令

- A: `combineLatest`
- B: `zip`
- C: `merge`
- D: `startWith`

----

#### 3. 如下代码执行结果是什么样的？
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

#### 4. 关于ConcatMap与FlatMap，以下说法正确的是？
- A: `ConcatMap可以将所有子 Observables 的元素发送出来`
- B: `FlatMap打印Observables的元素是按子Observables先后顺序依次打印的`
- C: `FlatMap过程会将每一个元素转换成Observables`
- D: `ConcatMap能够立即处理新的子Observables的订阅`


----

#### 5. 以下关于ControlEvent、ControlProperty的说法不正确的是？
- A: `一定在 MainScheduler 订阅`
- B: `一定在 MainScheduler 监听`
- C: `没有共享附加作用`
- D: `不会产生 error 事件`


----


#### 6. 以下关于操作符的说法不正确的是

- A: `flatMapLatest是map和switchLatest操作符的组合`
- B: `可以用withLatestFrom加distinctUntilChanged实现sample操作符`
- C: `amb命令只处理最先接收到的next事件的数据源，其他全部忽略`
- D: `在指定时间内没有发任何出元素，timeout操作符会产生一个超时的error事件`


----

#### 7. 如下代码执行结果是什么样的？
```swift
let ob = Observable<Int>.from([1, 2]).publish()
ob.subscribe(onNext: { int in
print("X")
})

ob.subscribe(onNext: { int in
print("Y")
})

ob.connect()

ob.subscribe(onNext: { int in
print("Z")
})
```

- A: `X Y X Y`
- B: `X Y X Y`
- C: `X Y Z X Y Z`
- D: `X X Y Y Z Z`


----

#### 8. 如下代码执行结果是什么样的？
```swift
let pbSubject = PublishSubject<Int>()
pbSubject.debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
.subscribe(onNext: { int in
print("d", int)
})

pbSubject.throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
.subscribe(onNext: { int in
print("t", int)
})

pbSubject.onNext(1)
pbSubject.onNext(2)
pbSubject.onNext(3)
```

- A: `d1 d3 t3`
- B: `t1 t3 d3`
- C: `t1 d3 t3`
- D: `d3 t1`


----

#### 9. 如下代码执行结果是什么样的？
```swift
let subject = ReplaySubject<String>.create(bufferSize: 2)
subject.onNext("0")
subject.onNext("1")
subject.onNext("2")

subject.subscribe { print("X", $0.element ?? $0.error) }
subject.subscribe { print("Y", $0.element ?? $0.error) }

subject.onNext("3")
subject.onError(-Error)

subject.subscribe { print("Z", $0.element ?? $0.error) }
```

- A: `X0 X1 Y0 Y1 X2 Y2 X-Error Y-Error Z-Error`
- B: `X1 X2 Y1 Y2 X3 Y3 X-Error Y-Error Z-Error`
- C: `X0 X1 Y0 Y1 X2 Y2 X-Error Y-Error Z0 Z1 Z-Error`
- D: `X1 X2 Y1 Y2 X3 Y3 X-Error Y-Error Z2 Z3 Z-Error`


----

#### 10. 如下代码执行结果是什么样的？
```swift
let button = PublishSubject<Void>()
let textField = PublishSubject<String>()
button.withLatestFrom(textField).subscribe(onNext: { value in
print(value)
})

textField.onNext("A")
textField.onNext("B")
textField.onNext("C")
button.onNext({}())
button.onNext({}())
```

- A: `A B C C C`
- B: `A A A B C`
- C: `C`
- D: `C C`


