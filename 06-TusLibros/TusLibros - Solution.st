!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: 'elPadrinoBook emptyCartWithEmptyCatalog emptyCartWithOneItemCatalog catalogWithElPadrino emptyCatalog validCreditCard notEmptyCart aUser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 00:15:09'!
setUp
	emptyCatalog _ Dictionary new. 
	emptyCartWithEmptyCatalog  _ 	Cart createCartWithCatalog:  emptyCatalog .
	elPadrinoBook _ 'El Padrino'.
	
	aUser _ 'Frankie'.
	
	catalogWithElPadrino  _ Dictionary new.
	catalogWithElPadrino at: elPadrinoBook put: 10.
	notEmptyCart _ Cart createCartWithCatalog: catalogWithElPadrino.
	notEmptyCart addItem: elPadrinoBook quantity: 1.
	emptyCartWithOneItemCatalog _ Cart createCartWithCatalog: catalogWithElPadrino.
	validCreditCard _ '4556432754313216'

	
	
	

	 ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:22'!
test01aNewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty. ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 00:40:51'!
test02AddItemToNewCartThenIsNotEmpty

	emptyCartWithEmptyCatalog catalog at: elPadrinoBook put: 10.
	emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1.
	
	self deny: emptyCartWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 00:41:18'!
test03AddOneItemToNewCartThenCantItemIsOne
	
	emptyCartWithEmptyCatalog catalog at: elPadrinoBook put: 10.
		
	emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1.
	
	self assert: emptyCartWithEmptyCatalog cantItem equals: 1.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 00:41:51'!
test04canNotAddItemWithQuantityLowerThanOne
	emptyCartWithEmptyCatalog catalog at: elPadrinoBook put: 10.
	
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

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2017 18:42:09'!
test08canNotCheckOutIfCartIsEmpty
	|aCashier|

	aCashier _ Cashier checkOut: emptyCartWithEmptyCatalog today: (Date newDay: 1  month: 1  year: 2000) withPriceList: emptyCatalog withCard: validCreditCard.

	self should: [aCashier checkOut ] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t check out with empty cart'].
	! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 00:40:10'!
test09NotEmptyCartCanCheckOut
	|aCashier finalPrice|

	aCashier _ Cashier checkOut: notEmptyCart forUser: aUser today: (Date newDay: 1  month: 1  year: 2000) withPriceList: catalogWithElPadrino withCard: validCreditCard.
	
	finalPrice _ aCashier checkOut.
	
	self assert: finalPrice = (catalogWithElPadrino at: elPadrinoBook).
"	self assert: finalPrice "
	
	
	
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

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 00:12:46'!
validateItem: anItem andQuantity: aQuantity

	(aQuantity isKindOf: Integer) ifFalse: [self error: 'Can''t add items with invalid quantity'].
	
	(aQuantity > 0) ifFalse: [self error: 'Can Not add item with not positive quantity'].
	
	(catalog includesKey: anItem) ifFalse: [self error: 'Can''t add items that aren''t in the catalog'].
	
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
	instanceVariableNames: 'cart date priceList card cartOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/19/2017 01:04:05'!
checkOut
|totalPrice|
	totalPrice _ 0.

	(cart isEmpty ) ifTrue: [self error: 'Can''t check out with empty cart'].
	
	cart listCart do: [:book| totalPrice _ totalPrice + (priceList at: book)].
	
	^totalPrice.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2017 19:39:11'!
initializeWith: aCart forUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard

	cart _ aCart.
	date _ aDate.
	priceList _ aPriceList.
	card _ aCreditCard.
	cartOwner _ aUser.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2017 18:45:43'!
initializeWith: aCart today: aDate withPriceList: aPriceList withCreditCard: aCreditCard

	cart _ aCart.
	date _ aDate.
	priceList _ aPriceList.
	card _ aCreditCard.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2017 19:38:06'!
initializeWith: aCart withUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard

	cart _ aCart.
	date _ aDate.
	priceList _ aPriceList.
	card _ aCreditCard.
	cartOwner _ aUser.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros - Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AM 6/18/2017 19:37:25'!
checkOut: aCart forUser: aUser today: aDate withPriceList: aPriceList withCard: aCreditCard
	
	^self new initializeWith: aCart forUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard.! !

!Cashier class methodsFor: 'instance creation' stamp: 'AM 6/18/2017 18:45:28'!
checkOut: aCart today: aDate withPriceList: aPriceList withCard: aCreditCard
	
	^self new initializeWith: aCart today: aDate withPriceList: aPriceList withCreditCard: aCreditCard.! !
