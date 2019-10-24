//
//  quiz.swift
//  RxS
//
//  Created by 房先森 on 2019/8/19.
//  Copyright © 2019 房先森. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

let disposeBag = DisposeBag()

class QuizError: Error {

}

// share / shareReplay
func quiz1() {
    let subject = BehaviorSubject(value: 1)
    let observable = subject.asObservable().share(replay: 2)

    subject.onNext(2)
    
    var subscriptions: [Disposable] = [
        observable.subscribe(onNext: { print($0) }),
    ]
    
    subject.onNext(3)
    
    subscriptions.append(observable.subscribe(onNext: { print($0) }))
    
    subject.onNext(4);
    
    subscriptions.forEach { $0.dispose() }
    subscriptions = [
        observable.subscribe(onNext: { print($0) })
    ]
    
    subject.onNext(5);
    
    subscriptions.append(observable.subscribe(onNext: { print($0) }))
    
    subject.onNext(6);
}
// A. 1232344454566
// B. 12323443454566
// C. 232344454566
// D. 2323443454566





// single
func quiz2() {
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
}

// A. error, next(1), error, next(3), next(4), next(3), error
// B. error, next(1), completed, next(3), next(4), next(3), error
// C. success(1), next(1), completed, next(3), next(4), next(3), completed
// D. success(1), next(1), completed, next(3), next(4), next(3), error





// publish refCount
func quiz3() {
    let subject = BehaviorSubject(value: 1)
    let observable = subject.asObserver().debug("O").publish().refCount()

    subject.onNext(2)

    var subscriptions = [
        observable.debug("A").subscribe(onNext: { print("A\($0)") }),
        observable.debug("B").subscribe(onNext: { print("B\($0)") }),
    ]

    subject.onNext(3)

    subscriptions.popLast()?.dispose()

    subject.onNext(4)

    subscriptions.popLast()?.dispose()

    subject.onNext(5)

    subscriptions.append(observable.subscribe(onNext: { print("C\($0)") }))

    subject.onNext(6)
}

// A. A2 B2 A3 B3 A4 C5 C6
// B. A2 B2 A3 B3 A4 C6
// C. A2 A3 B3 A4 C5 C6
// D. B3 A3 B3 A4 C5 C6




// catchError catchErrorJustReturn
func quiz4() {
    let first = PublishSubject<Int>()
    let second = PublishSubject<Int>()

    first.catchError({ _ in return second.catchErrorJustReturn(0) })
        .subscribe({ print($0) })
        .disposed(by: disposeBag)

    first.onNext(1)
    second.onNext(2)
    first.onError(QuizError())
    second.onNext(3)
    first.onNext(4)
    first.onError(QuizError())
    second.onNext(5)
    second.onError(QuizError())
    second.onNext(6)
}

// A. next(1) error next(3) next(5) next(0) next(6)
// B. next(1) error next(3) next(5) next(0) completed
// C. next(1) next(3) next(5) next(0) next(6)
// D. next(1) next(3) next(5) next(0) completed




// throttle debounce
func quiz5() {
    let first = Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
    let second = Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)

    _ = first
        .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
        .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
        .subscribe(onNext: { print("A\($0)") })
    _ = second
        .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
        .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
        .subscribe(onNext: { print("B\($0)") })
}

// A. A0 B0 A2 B2 A5 B5 A7 B7...
// B. B0 B2 B5 B7 B10...
// C. A0 A2 A5 A7 A10...
// D. (NOTHING OUTPUT)




// delay delaySubscription
func quiz6() {
    let first = BehaviorSubject(value: 1)
    let second = BehaviorSubject(value: 1)

    _ = first
        .asObserver().debug("A")
        .delay(.milliseconds(200), scheduler: MainScheduler.instance)
        .delaySubscription(.milliseconds(100), scheduler: MainScheduler.instance)
        .subscribe(onNext: { print("A\($0)") })

    _ = second
        .asObserver().debug("B")
        .delaySubscription(.milliseconds(200), scheduler: MainScheduler.instance)
        .delay(.milliseconds(100), scheduler: MainScheduler.instance)
        .subscribe(onNext: { print("B\($0)") })

    first.onNext(2)
    second.onNext(2)
}

// A. A1 A2 B1 B2
// B. A1 A2 B2
// C. B2 A2
// D. A2 B2




// amb error
func quiz7() {
    let first = PublishSubject<Int>()
    let second = PublishSubject<Int>()
    let third = PublishSubject<Int>()

    _ = Observable<Int>
        .amb([first.asObservable(), second.asObservable()])
        .catchError({ _ in third.asObservable()})
        .subscribe{ print($0) }

    first.onError(QuizError())
    second.onNext(2)
    third.onNext(3)

    second.onError(QuizError())
    third.onNext(4)
}

// A. next(2) error
// B. next(2) next(3) next(4)
// C. next(3) next(4)
// D. next(3) error




// withLatestFrom
func quiz8() {
    let first = PublishSubject<Int>()
    let second = PublishSubject<Int>()

    _ = first
        .withLatestFrom(second)
        .subscribe(onNext: { print($0) })

    first.onNext(1)
    first.onNext(2)
    second.onNext(3)
    first.onNext(4)
    second.onNext(5)
}

// A. 124
// B. 4
// C. 3
// D. 35




//timeout delay
func quiz9() {
    let first = PublishSubject<Int>()
    let second = PublishSubject<Int>()
    _ = first
        .asObservable()
        .timeout(.milliseconds(200), scheduler: MainScheduler.instance)
        .delay(.milliseconds(400), scheduler: MainScheduler.instance)
        .catchError({ _ in return Observable.empty()})
        .ifEmpty(switchTo: second)
        .subscribe({ print($0) })

    first.onNext(1)
    second.onNext(2)
}

// A. next(1)
// B. next(2)
// C. next(1) next(2)
// D. (NOTHING OUTPUT)



//timeout delay completed
func quiz10() {
    let first = PublishSubject<Int>()
    let second = PublishSubject<Int>()
    _ = first
        .asObservable()
        .timeout(.milliseconds(200), scheduler: MainScheduler.instance)
        .delay(.milliseconds(400), scheduler: MainScheduler.instance)
        .catchError({ _ in return Observable.empty()})
        .ifEmpty(switchTo: second)
        .subscribe({ print($0) })

    first.onNext(1)
    second.onNext(2)
    first.onCompleted()
}

// A. next(1)
// B. next(2)
// C. next(1) completed
// D. (NOTHING OUTPUT)




func quiz() {
//    quiz1()
//    quiz2()
//    quiz3()
//    quiz4()
//    quiz5()
//    quiz6()
//    quiz7()
//    quiz8()
//    quiz9()
//    quiz10()
}
