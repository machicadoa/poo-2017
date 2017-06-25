!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: 'elPadrinoBook emptyCartWithEmptyCatalog catalogWithElPadrino emptyCatalog validCreditCard emptyCartWithCatalogContainingElPadrino priceListWithElPadrino aClient cartContainingElPadrino'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/21/2017 00:29:18'!
setUp
	
	PurchaseSystem new: 'TusLibros'.
	emptyCatalog _ Dictionary new. 
	emptyCartWithEmptyCatalog  _ 	Cart createCartWithCatalog:  emptyCatalog .
	elPadrinoBook _ 'El Padrino'.
	catalogWithElPadrino  _ Dictionary new.
	catalogWithElPadrino at: elPadrinoBook put: 10.
	
	priceListWithElPadrino _ catalogWithElPadrino.
	cartContainingElPadrino _ Cart createCartWithCatalog: catalogWithElPadrino.
	cartContainingElPadrino addItem: elPadrinoBook quantity: 1.
	emptyCartWithCatalogContainingElPadrino _ Cart createCartWithCatalog: catalogWithElPadrino.
	validCreditCard _ '4556432754313216'.
	aClient _ TusLibros addClient: 'Frankie'.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'RC 6/15/2017 19:25:22'!
test01aNewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty. ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:01:24'!
test02AddItemToNewCartThenIsNotEmpty
	|newCart newCatalog|
	newCatalog _ Dictionary new.
	newCatalog  at: elPadrinoBook put: 10.
	
	newCart _ Cart  createCartWithCatalog: newCatalog.
	newCart addItem: elPadrinoBook quantity: 1.
	self deny: newCart isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:18:02'!
test03AddOneItemToNewCartThenCantItemIsOne
	|newCart newCatalog|
	
	newCatalog _ Dictionary new.
	newCatalog  at: elPadrinoBook put: 10.
	
	newCart _ Cart  createCartWithCatalog: newCatalog.
	newCart addItem: elPadrinoBook quantity: 1.
	self assert: newCart amountOfItems equals: 1.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:07:28'!
test04canNotAddItemWithQuantityLowerThanOne
	self should: [emptyCartWithCatalogContainingElPadrino addItem: elPadrinoBook quantity: -1] 
	raise: Error 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can Not add item with not positive quantity'].
	
	self assert: emptyCartWithCatalogContainingElPadrino isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:20:18'!
test05canNotAddItemThatArentInCatalog
	self should: [emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1] 
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t add items that aren''t in the catalog'].
	
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:10:25'!
test06canNotAddItemWhenQuantityIsNotInteger
	self should: [emptyCartWithCatalogContainingElPadrino addItem: elPadrinoBook quantity: 1/2] 
	
	raise: Error - MessageNotUnderstood
	
	withExceptionDo: [ :msg | 
		
		self assert: msg messageText equals: 'Can''t add items with invalid quantity'.
		
		self assert: emptyCartWithCatalogContainingElPadrino isEmpty.
		].
	
	! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:19:39'!
test07CartWithOneItemContentsTheSameOneItem

	 |aCart aContent|
	
	aCart _ Cart createCartWithCatalog: catalogWithElPadrino.
	
	aCart addItem: elPadrinoBook quantity: 1. 
	
	aContent _ aCart listCart.
	
	self assert: aContent size equals: 1.
	
	self assert: (aContent includes: elPadrinoBook ).! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/24/2017 16:52:54'!
test08canNotCheckOutIfCartIsEmpty
	|aCashier|

	aCashier _ Cashier checkOut: emptyCartWithEmptyCatalog forUser: aClient today: (Date newDay: 1  month: 1  year: 2000) withPriceList: emptyCatalog withCard: validCreditCard.

	self should: [aCashier checkOut ] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t check out with empty cart'].
	! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 23:17:04'!
test09NotEmptyCartCanCheckOut
	|aCashier finalPrice|

	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: aClient today: (Date newDay: 1  month: 1  year: 2000) withPriceList: priceListWithElPadrino withCard: validCreditCard.
	
	finalPrice _ aCashier checkOut.
	
	self assert: finalPrice = (priceListWithElPadrino at: elPadrinoBook).! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/21/2017 00:27:43'!
test10NewClientPurchaseIsRegistered

	|aCashier newClient contents|
	
	newClient _ TusLibros addClient: 'Pepe'.
	
	contents _ cartContainingElPadrino listCart.
	
	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: newClient today: (Date newDay: 1  month: 1  year: 2000) withPriceList: priceListWithElPadrino withCard: validCreditCard.
	
	aCashier checkOut.
	
	self assert: (TusLibros userPurchases: newClient) = contents.
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

!Cart methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 22:17:44'!
amountOfItems

	^content size.! !

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

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/24/2017 17:05:37'!
checkOut
|totalPrice|
	totalPrice _ 0.
	TusLibros newPurchase: cart listCart for: cartOwner.
	
	self validateCheckout.
	^cart listCart inject: totalPrice into: [:total :book | total + (priceList at: book)].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2017 19:39:11'!
initializeWith: aCart forUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard

	cart _ aCart.
	date _ aDate.
	priceList _ aPriceList.
	card _ aCreditCard.
	cartOwner _ aUser.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'AM 6/25/2017 15:23:11'!
validateCheckout
	(cart isEmpty) ifTrue: [self error: 'Can''t check out with empty cart'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros - Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AM 6/18/2017 19:37:25'!
checkOut: aCart forUser: aUser today: aDate withPriceList: aPriceList withCard: aCreditCard
	
	^self new initializeWith: aCart forUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard.! !


!classDefinition: #PurchaseSystem category: #'TusLibros - Solution'!
Object subclass: #PurchaseSystem
	instanceVariableNames: 'name clients'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!PurchaseSystem methodsFor: 'as yet unclassified' stamp: 'AM 6/21/2017 00:03:28'!
initializeWithName: aString
	name _ aString.
	clients _ Dictionary new.! !

!PurchaseSystem methodsFor: 'as yet unclassified' stamp: 'AM 6/21/2017 00:24:57'!
newPurchase: aCartContent for: aUser
	
	(clients at: aUser) addAll: aCartContent.! !

!PurchaseSystem methodsFor: 'as yet unclassified' stamp: 'AM 6/21/2017 00:02:42'!
userPurchases: aClient 
	^(clients at: aClient) copy.! !


!PurchaseSystem methodsFor: 'associating' stamp: 'AM 6/21/2017 00:07:26'!
addClient: aString 
	clients at: aString put: Bag new.
	^aString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseSystem class' category: #'TusLibros - Solution'!
PurchaseSystem class
	instanceVariableNames: ''!

!PurchaseSystem class methodsFor: 'as yet unclassified' stamp: 'AM 6/20/2017 23:55:19'!
new: newSystemName
	
	|instance|
	
	instance _ self new initializeWithName: newSystemName.
	Smalltalk at: newSystemName asSymbol put: instance.
	
	! !
