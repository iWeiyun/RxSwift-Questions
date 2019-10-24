# List Of RxSwift Questions



#### 1. 如下哪个操作符，传入多个Observables后，只取第一个产生事件的Observable，忽略其他Observables？

- A: `amb`
- B: `buffer`
- C: `filter`
- D: `map`

----
#### 2. 如下哪个操作符，缓存元素，然后将缓存的元素集合周期性的发？

- A: `amb`
- B: `buffer`
- C: `filter`
- D: `timer`

----
#### 3. 关于catchError描述错误的是

- A: `从一个错误事件中恢复，将错误事件替换成一个备选序列`
- B: `拦截一个 error 事件，将它替换成其他的元素或者一组元素`
- C: `具备重试的能力`
- D: `可以使得 Observable 正常结束，或者根本都不需要结束`

----
#### 4. 请选出如下代码的输出结果
```swift
let first = PublishSubject<String>()
let second = PublishSubject<String>()

_ = Observable.combineLatest(first, second) { $0 + $1 }
          .subscribe(onNext: { print($0) })

first.onNext("1")
second.onNext("A")
first.onNext("2")
second.onNext("B")
second.onNext("C")
first.onNext("3")
```
- A: `1A 2A 2B 2C 3C`
- B: `1A 2B 2C`
- C: `1A 2B 3C`
- D: `2A 3C 3C`

---
#### 5. 在textField中输入如下哪个内容时，会看到输出
```swift
	let textField = UITextField.init(...)
	...
	let observable = textField.rx.text
	observable.filter{ttt in
		if let m = ttt as? String {
			return m.count > 3
		}
	    
		return false; 
	}
	.subscribe(onNext:{ttt in
	print("取得 输入 成功: \(ttt)")})
.disposed(by: disposeBag)
```
- A: `12`
- B: `123`
- C: `1234`
- D: `如上三种都可以`

---
#### 6. 要过滤掉高频产生的元素，应该用如下哪一个操作符

- A: `debounce`
- B: `filter`
- C: `delay`
- D: `groupBy`

---
#### 7. 如下代码输出为
```swift
let disposeBag = DisposeBag()

Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
    .elementAt(3)
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

```

- A: `🐱 🐰 🐶 🐸 🐷 🐵`
- B: `🐶`
- C: `🐸`
- D: `🐱 🐰 🐶 🐸`

---
#### 8. 哪种操作符，将 Observable 的元素转换成其他的 Observable，然后将这些 Observables 合并

- A: `flatMap`
- B: `map`
- C: `from`
- D: `groupBy`

---
#### 9. 哪种操作符，将其他类型或者数据结构转换为 Observable

- A: `flatMap`
- B: `map`
- C: `from`
- D: `groupBy`

---
#### 10. 如下代码的输出为
```swift
let disposeBag = DisposeBag()
let first = PublishSubject<String>()
let second = PublishSubject<String>()

Observable.zip(first, second) { $0 + $1 }
          .subscribe(onNext: { print($0) })
          .disposed(by: disposeBag)

first.onNext("1")
second.onNext("A")
first.onNext("2")
second.onNext("B")
second.onNext("C")
second.onNext("D")
first.onNext("3")
first.onNext("4")
```

- A: `1A 2B 3C 4D`
- B: `1A 2B 2C 2D 3D 4D`
- C: `1A 2B`
- D: `1A 2B 3D 4D`


