!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOElement category: #'Stack-Exercise'!
Object subclass: #OOElement
	instanceVariableNames: 'myElement second'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOElement methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 21:01:25'!
initializeWithValue: elem1 Second: elem2
	myElement _ elem1.
	second _ elem2.! !

!OOElement methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 20:42:35'!
isEmpty
	^ false.! !

!OOElement methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 20:43:11'!
myElement
	^ myElement.! !

!OOElement methodsFor: 'as yet unclassified' stamp: 'rod 5/8/2017 19:32:06'!
myElementSetter: anObject
	 myElement _ anObject.! !

!OOElement methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 20:42:53'!
second
	^ second.! !

!OOElement methodsFor: 'as yet unclassified' stamp: 'rod 5/8/2017 19:32:43'!
secondSetter: anObject

	 second _ anObject. ! !


!classDefinition: #OOEmpty category: #'Stack-Exercise'!
Object subclass: #OOEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmpty methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 20:33:14'!
isEmpty

	^true! !

!OOEmpty methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 20:35:08'!
myElement

	^ self error: OOStack stackEmptyErrorDescription.! !

!OOEmpty methodsFor: 'as yet unclassified' stamp: 'rod 5/7/2017 20:34:29'!
second

	^ self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'rod 5/7/2017 20:48:18'!
isEmpty
	^top isEmpty.! !


!OOStack methodsFor: 'initialization' stamp: 'rod 5/8/2017 00:01:05'!
initialize	size _ 0.
	top _ OOEmpty new.! !


!OOStack methodsFor: 'associating' stamp: 'rod 5/8/2017 00:00:54'!
pop	|var1|
	var1 _ top.
	size _ size - 1.
	top _ top second.
	^ var1 myElement.
	! !

!OOStack methodsFor: 'associating' stamp: 'rod 5/8/2017 19:30:10'!
push: anObject 	|newSecond|	
	newSecond _ top.
	top _ OOElement new.
	top myElementSetter: anObject.
	top secondSetter: newSecond.
	size _ size + 1.! !


!OOStack methodsFor: 'accessing' stamp: 'rod 5/7/2017 20:59:19'!
size
	^ size.! !

!OOStack methodsFor: 'accessing' stamp: 'rod 5/8/2017 19:41:06'!
top
	^ top myElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
