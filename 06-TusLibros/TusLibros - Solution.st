!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: 'elPadrinoBook emptyCartWithEmptyCatalog emptyCartWithOneItemCatalog catalogWithElPadrino emptyCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 20:15:53'!
setUp
	emptyCatalog _ Set new. 
	emptyCartWithEmptyCatalog  _ 	Cart createCartWithCatalog:  emptyCatalog .
	elPadrinoBook _ 'El Padrino'.
	
	catalogWithElPadrino  _ Set with: elPadrinoBook.
	
	emptyCartWithOneItemCatalog _ Cart createCartWithCatalog: catalogWithElPadrino .
	
	
	

	 ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:22'!
test01aNewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty. ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:27'!
test02AddItemToNewCartThenIsNotEmpty

	emptyCartWithEmptyCatalog catalog add: elPadrinoBook .
	emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1.
	
	self deny: emptyCartWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:33'!
test03AddOneItemToNewCartThenCantItemIsOne
	
	emptyCartWithEmptyCatalog catalog add: elPadrinoBook .
		
	emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1.
	
	self assert: emptyCartWithEmptyCatalog cantItem equals: 1.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:40'!
test04canNotAddItemWithQuantityLowerThanOne
	emptyCartWithEmptyCatalog catalog add: elPadrinoBook .
	
	self should: [emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: -1] 
	raise: Error 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can Not add item with not positive quantity'].
	
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:45'!
test05canNotAddItemThatArentInCatalog
	self should: [emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1] 
	raise: Error 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t add items that aren''t in the catalog'].
	
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:41:53'!
test06canNotAddItemWhenQuantityIsNotInteger
	self should: [emptyCartWithOneItemCatalog addItem: elPadrinoBook quantity: 1/2] 
	
	raise: Error 
	
	withExceptionDo: [ :msg | 
		
		self assert: msg messageText equals: 'Can''t add items with invalid quantity'.
		
		self assert: emptyCartWithOneItemCatalog isEmpty.
		].
	
	! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 20:14:38'!
test07CartWithOneItemContentsTheSameOneItem

	 |aCart aContent|
	
	aCart _ Cart createCartWithCatalog: catalogWithElPadrino.
	
	aCart addItem: elPadrinoBook quantity: 1. 
	
	aContent _ aCart listCart.
	
	self assert: aContent size equals: 1.
	
	self assert: (aContent includes: elPadrinoBook ).! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 20:22:45'!
test08canNotCheckOutIfCartIsEmpty
	|aCashier|
	
	aCashier _ Cashier new.

	self should: [aCashier checkOutWith: emptyCartWithEmptyCatalog] 
	
	raise: Error 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t check out with empty cart'].
	! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 21:32:04'!
test09CantCheckOutWithInvalidCreditCardNumber

	|aCashier aCreditCard|
	
	aCreditCard _ '124710'.
	
	aCashier _ Cashier new.

	self should: [aCashier checkOutWith: emptyCartWithEmptyCatalog] 
	
	raise: Error 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t check out with empty cart'].
	! !


!classDefinition: #Cart category: #'TusLibros - Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:28:07'!
addItem: anItem quantity: aQuantity 
	self validateItem: anItem andQuantity: aQuantity .

	content add: anItem withOccurrences: aQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:12:36'!
cantItem

	^content size.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:23:55'!
catalog
	
	^catalog.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:24:42'!
initializeCartWithCatalog: aCatalog
	catalog _ aCatalog.
	content _ Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:27:21'!
isEmpty
	^ content isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 20:18:11'!
listCart
	^content copy ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 20:11:33'!
validateItem: anItem andQuantity: aQuantity

	(aQuantity isKindOf: Integer) ifFalse: [self error: 'Can''t add items with invalid quantity'].
	
	(aQuantity > 0) ifFalse: [self error: 'Can Not add item with not positive quantity'].
	
	(catalog includes: anItem) ifFalse: [self error: 'Can''t add items that aren''t in the catalog'].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros - Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'AM 6/13/2017 21:23:14'!
createCartWithCatalog: aCatalog
	^self new initializeCartWithCatalog: aCatalog.! !


!classDefinition: #Cashier category: #'TusLibros - Solution'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:22:35'!
checkOutWith: aCart

	(aCart isEmpty ) ifTrue: [self error: 'Can''t check out with empty cart']! !
