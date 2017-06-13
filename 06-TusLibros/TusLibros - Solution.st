!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:21:22'!
test01aNewCartIsEmpty

	|aCart|
	
	aCart _ Cart createCart .
	
	self assert: aCart isEmpty. ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:21:47'!
test02AddItemToNewCartThenNotIsEmpty

	|aCart aItem| 
	
	aCart _ Cart createCart.
	aItem _ Item new.
	aCart addItem: aItem quantity: 1.
	
	self deny: aCart isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:49:25'!
test03AddOneItemToNewCartThenCantItemIsOne

	|aCart anItem|
	
	aCart _ Cart createCart .
	anItem _ Item new.
	aCart addItem: anItem  quantity: 1.
	self assert: aCart cantItem equals: 1.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 11:15:05'!
test04canNotAddItemWithNotPositiveQuantity
	
	|aCart anItem|
	
	aCart _ Cart createCart .
	anItem _ Item new.
	self should: [aCart addItem: anItem quantity: -1] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can Not add item with not positive quantity'].! !


!classDefinition: #Cart category: #'TusLibros - Solution'!
Object subclass: #Cart
	instanceVariableNames: 'cantItem purchase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 11:17:14'!
addItem: anItem quantity: aQuantity 
	(aQuantity > 0) ifFalse: [self error: 'Can Not add item with not positive quantity'].
	cantItem _ cantItem + aQuantity.
	purchase add: (Association  new key: anItem value: aQuantity).! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:49:40'!
cantItem
	^cantItem.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:21:10'!
createCartEmpty

	cantItem _ 0.
	purchase _ Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:23:10'!
isEmpty
	^ cantItem = 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros - Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:22:39'!
createCart

	^self new createCartEmpty.! !


!classDefinition: #Item category: #'TusLibros - Solution'!
Object subclass: #Item
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!
