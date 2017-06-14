!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:21:47'!
test01aNewCartIsEmpty

	|aCart aCatalog|
	aCatalog _ Set new. 

	aCart _ Cart createCartWithCatalog:  aCatalog .
	
	self assert: aCart isEmpty. ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:34:28'!
test02AddItemToNewCartThenIsNotEmpty

	|aCart aBook aCatalog| 
	aCatalog _ Bag new.
	
	aBook _ 'El Padrino'.
	
	aCatalog add: aBook.
	aCart _ Cart createCartWithCatalog: aCatalog.
	aCart addItem: aBook quantity: 1.
	
	self deny: aCart isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:49:25'!
test03AddOneItemToNewCartThenCantItemIsOne

	|aCart anItem|
	
	aCart _ Cart createCart .
	anItem _ Item new.
	aCart addItem: anItem  quantity: 1.
	self assert: aCart cantItem equals: 1.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 19:56:01'!
test04canNotAddItemWithQuantityLowerThanOne
	
	|aCart anItem|
	
	aCart _ Cart createCart .
	anItem _ Item new.
	self should: [aCart addItem: anItem quantity: -1] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can Not add item with not positive quantity'].! !


!classDefinition: #Cart category: #'TusLibros - Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:39:26'!
addItem: anItem quantity: aQuantity 
	(aQuantity > 0) ifFalse: [self error: 'Can Not add item with not positive quantity'].
	(catalog includes: anItem) ifFalse: [self error: 'Can''t add items that aren''t in the catalog'].
	content add: anItem withOccurrences: aQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:24:42'!
initializeCartWithCatalog: aCatalog
	catalog _ aCatalog.
	content _ Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:27:21'!
isEmpty
	^ content isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros - Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'RC 6/13/2017 10:22:39'!
createCart

	^self new createCartEmpty.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:23:14'!
createCartWithCatalog: aCatalog
	^self new initializeCartWithCatalog: aCatalog.! !
