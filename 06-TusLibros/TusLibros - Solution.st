!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: 'elPadrinoBook emptyCartWithEmptyCatalog catalogWithElPadrino emptyCatalog validCreditCard emptyCartWithCatalogContainingElPadrino priceListWithElPadrino aClient cartContainingElPadrino aLowFundsClient aLowFundsCreditCard count'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'tests' stamp: 'RC 6/15/2017 19:25:22'!
test01aNewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty. ! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/20/2017 22:01:24'!
test02AddItemToNewCartThenIsNotEmpty
	|newCart newCatalog|
	newCatalog _ Dictionary new.
	newCatalog  at: elPadrinoBook put: 10.
	
	newCart _ Cart  createCartWithCatalog: newCatalog.
	newCart addItem: elPadrinoBook quantity: 1.
	self deny: newCart isEmpty.! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/20/2017 22:18:02'!
test03AddOneItemToNewCartThenCantItemIsOne
	|newCart newCatalog|
	
	newCatalog _ Dictionary new.
	newCatalog  at: elPadrinoBook put: 10.
	
	newCart _ Cart  createCartWithCatalog: newCatalog.
	newCart addItem: elPadrinoBook quantity: 1.
	self assert: newCart amountOfItems equals: 1.! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/20/2017 22:07:28'!
test04canNotAddItemWithQuantityLowerThanOne
	self should: [emptyCartWithCatalogContainingElPadrino addItem: elPadrinoBook quantity: -1] 
	raise: Error 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can Not add item with not positive quantity'].
	
	self assert: emptyCartWithCatalogContainingElPadrino isEmpty.! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/20/2017 22:20:18'!
test05canNotAddItemThatArentInCatalog
	self should: [emptyCartWithEmptyCatalog addItem: elPadrinoBook quantity: 1] 
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t add items that aren''t in the catalog'].
	
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/20/2017 22:10:25'!
test06canNotAddItemWhenQuantityIsNotInteger
	self should: [emptyCartWithCatalogContainingElPadrino addItem: elPadrinoBook quantity: 1/2] 
	
	raise: Error - MessageNotUnderstood
	
	withExceptionDo: [ :msg | 
		
		self assert: msg messageText equals: 'Can''t add items with invalid quantity'.
		
		self assert: emptyCartWithCatalogContainingElPadrino isEmpty.
		].
	
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/20/2017 22:19:39'!
test07CartWithOneItemContentsTheSameOneItem

	 |aCart aContent|
	
	aCart _ Cart createCartWithCatalog: catalogWithElPadrino.
	
	aCart addItem: elPadrinoBook quantity: 1. 
	
	aContent _ aCart listCart.
	
	self assert: aContent size equals: 1.
	
	self assert: (aContent includes: elPadrinoBook ).! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/26/2017 23:49:11'!
test08canNotCheckOutIfCartIsEmpty
	|aCashier purchaseCostsForAClient purchasesForAClient|
	purchaseCostsForAClient _ TusLibros salesTo: aClient.
	purchasesForAClient _ TusLibros userPurchases: aClient.
	aCashier _ Cashier checkOut: emptyCartWithEmptyCatalog forUser: aClient today: self today withPriceList: emptyCatalog withCard: validCreditCard.

	self should: [aCashier checkOut ] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg |
		self assert: msg messageText equals: 'Can''t check out with empty cart'.
		self assert: (TusLibros salesTo: aClient) = purchaseCostsForAClient.
		self assert: (TusLibros userPurchases: aClient) = purchasesForAClient.
		].
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/26/2017 23:53:37'!
test09SingleItemCartCheckOutReturnsPriceOfCart
	|aCashier finalPrice|

	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: aClient today: self today withPriceList: priceListWithElPadrino withCard: validCreditCard.
	
	finalPrice _ aCashier checkOut.
	
	self assert: finalPrice = (priceListWithElPadrino at: elPadrinoBook).! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/26/2017 23:39:20'!
test10NewClientPurchaseIsRegistered

	|aCashier newClient contents aValidCreditCard purchaseCost cantOfPurchasesForPepe|
	
	aValidCreditCard _ CreditCard newCardWithCardNumber: 1234123412341234 withOwner: 'Pepe' andExpirationDate: self today + 1 days. 
	
	newClient _ TusLibros addClient: 'Pepe'.
	
	cantOfPurchasesForPepe _ (TusLibros salesTo: newClient) size.
	
	contents _ cartContainingElPadrino listCart.
	
	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: newClient today: self today withPriceList: priceListWithElPadrino withCard: aValidCreditCard.
	
	purchaseCost _ aCashier checkOut.
	
	self assert: (TusLibros userPurchases: newClient) = contents.
	self assert: (TusLibros salesTo: newClient) size = (cantOfPurchasesForPepe + 1).
	self assert: (TusLibros salesTo: newClient) last = purchaseCost.
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/27/2017 00:57:32'!
test11ExpiredCardFailsWhileCheckingOut

	|aCashier newClient expiredCreditCard purchaseCostsForAClient purchasesForAClient debitFromCalls|
	
	expiredCreditCard _ CreditCard
	newCardWithCardNumber: 4539272523124730
	withOwner: 'Ricardo Fort'
	andExpirationDate: self today - 1 days.
	
	newClient _ TusLibros addClient: 'Ricardo Fort'.
	
	purchaseCostsForAClient _ TusLibros salesTo: newClient.
	purchasesForAClient _ TusLibros userPurchases: newClient.
	debitFromCalls _ self amountOfDebitFromCalls.
	
	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: newClient today: self today withPriceList: priceListWithElPadrino withCard: expiredCreditCard.
	
	self should: [aCashier checkOut ] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg |
		self assert: msg messageText equals: 'Can''t check out with expired credit card'.
		self assert: (TusLibros salesTo: newClient) = purchaseCostsForAClient.
		self assert: (TusLibros userPurchases: newClient) = purchasesForAClient.
		self assert: self amountOfDebitFromCalls = debitFromCalls.
		].
	! !

!LibrosTest methodsFor: 'tests' stamp: 'RC 6/26/2017 20:29:54'!
test12canNotCreateCardWithoutOwner
	
	self should: [CreditCard
					newCardWithCardNumber: 4539272523124730
					withOwner: ''
					andExpirationDate: self today - 1 days.] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'owner is empty'].
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/26/2017 21:59:28'!
test13canNotCreateCardWithANon16DigitNumber
	
	self should: [CreditCard
					newCardWithCardNumber: 4539272523124
					withOwner: 'Ricardo Fort'
					andExpirationDate: self today - 1 days.] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'invalid card number length'].
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/26/2017 22:01:50'!
test14canNotCreateCardWithANonintegerNumber
	
	self should: [CreditCard
					newCardWithCardNumber: '45A9272523124'
					withOwner: 'Ricardo Fort'
					andExpirationDate: self today - 1 days.] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'card number is not integer'].
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/27/2017 00:07:07'!
test15canNotCheckoutCartIfCartAndCardOwnerAreNotTheSame
	
	|newClient aCashier purchaseCostsForAClient purchasesForAClient|
	
	newClient _ TusLibros addClient: 'Pepe'.
	
	purchaseCostsForAClient _ TusLibros salesTo: newClient.
	purchasesForAClient _ TusLibros userPurchases: newClient.
	
	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: newClient today: self today withPriceList: priceListWithElPadrino withCard: validCreditCard.
	
	self should: [aCashier checkOut ] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg |
		self assert: msg messageText equals: 'credit card owner and cart owner are not the same'.
		self assert: (TusLibros salesTo: aClient) = purchaseCostsForAClient.
		self assert: (TusLibros userPurchases: aClient) = purchasesForAClient.
		].
	! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/27/2017 00:23:51'!
test16CannotCheckOutIfFundsAreInsufficient

		|aCashier purchaseCostsForAClient purchasesForAClient|
	
	purchaseCostsForAClient _ TusLibros salesTo: aLowFundsClient .
	purchasesForAClient _ TusLibros userPurchases: aLowFundsClient .
	
	aCashier _ Cashier checkOut: cartContainingElPadrino forUser: aLowFundsClient today: self today withPriceList: priceListWithElPadrino withCard: aLowFundsCreditCard.
	
	self should: [aCashier checkOut ] 
	
	raise: Error - MessageNotUnderstood 
	
	withExceptionDo: [ :msg |
		self assert: msg messageText equals: 'credit card has not enough funds'.
		self assert: (TusLibros salesTo: aClient) = purchaseCostsForAClient.
		self assert: (TusLibros userPurchases: aClient) = purchasesForAClient.
		].! !

!LibrosTest methodsFor: 'tests' stamp: 'AM 6/27/2017 01:45:20'!
test17cartRequestFromAValidUserResultsInAValidCartId

	|aUserInterface aCartId|

	aUserInterface _ UserInterface new.

	aCartId _ aUserInterface createCartFor: 'Pepe' authenticatedWith: 'pepemaster01'.
	
	self assert: (aUserInterface listCart: aCartId) isEmpty.! !


!LibrosTest methodsFor: 'Private' stamp: 'AM 6/27/2017 00:54:23'!
amountOfDebitFromCalls

	count.! !

!LibrosTest methodsFor: 'Private' stamp: 'AM 6/27/2017 00:55:08'!
debit: amount from: aCreditCard

	count _ count + 1.

	(aCreditCard number = 4556432754313217) ifTrue: [self error: 'credit card has not enough funds'].
	^true.! !

!LibrosTest methodsFor: 'Private' stamp: 'AM 6/25/2017 15:41:21'!
today

	^Date newDay: 1 month: 1 year: 2000.! !


!LibrosTest methodsFor: 'setup' stamp: 'AM 6/27/2017 01:29:32'!
setUp
	
	PurchaseSystem newName: 'TusLibros' withCardProcessor: self withProductCatalog: Dictionary new.
	count _ 0.
	emptyCatalog _ Dictionary new. 
	emptyCartWithEmptyCatalog  _ Cart createCartWithCatalog:  emptyCatalog .
	elPadrinoBook _ 'El Padrino'.
	catalogWithElPadrino  _ Dictionary new.
	catalogWithElPadrino at: elPadrinoBook put: 10.
	
	priceListWithElPadrino _ catalogWithElPadrino.
	cartContainingElPadrino _ Cart createCartWithCatalog: catalogWithElPadrino.
	cartContainingElPadrino addItem: elPadrinoBook quantity: 1.
	emptyCartWithCatalogContainingElPadrino _ Cart createCartWithCatalog: catalogWithElPadrino.
	aClient _ TusLibros addClient: 'Frankie'.
	
	validCreditCard _ CreditCard newCardWithCardNumber: 4556432754313216 withOwner: aClient andExpirationDate: self today + 1 days.
	
	aLowFundsClient _ TusLibros addClient: 'Moroso'.
	
	aLowFundsCreditCard _ CreditCard newCardWithCardNumber: 4556432754313217 withOwner: aLowFundsClient andExpirationDate: self today + 1 days.! !


!classDefinition: #Cart category: #'TusLibros - Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cart methodsFor: 'initialization' stamp: 'AM 6/13/2017 21:24:42'!
initializeCartWithCatalog: aCatalog
	catalog _ aCatalog.
	content _ Bag new.! !


!Cart methodsFor: 'testing' stamp: 'AM 6/13/2017 21:27:21'!
isEmpty
	^ content isEmpty.! !


!Cart methodsFor: 'error handling' stamp: 'AM 6/19/2017 00:12:46'!
validateItem: anItem andQuantity: aQuantity

	(aQuantity isKindOf: Integer) ifFalse: [self error: 'Can''t add items with invalid quantity'].
	
	(aQuantity > 0) ifFalse: [self error: 'Can Not add item with not positive quantity'].
	
	(catalog includesKey: anItem) ifFalse: [self error: 'Can''t add items that aren''t in the catalog'].
	
	! !


!Cart methodsFor: 'adding' stamp: 'RC 6/15/2017 19:28:07'!
addItem: anItem quantity: aQuantity 
	self validateItem: anItem andQuantity: aQuantity .

	content add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'inspecting' stamp: 'AM 6/20/2017 22:17:44'!
amountOfItems

	^content size.! !

!Cart methodsFor: 'inspecting' stamp: 'RC 6/15/2017 20:18:11'!
listCart
	^content copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros - Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 6/13/2017 21:23:14'!
createCartWithCatalog: aCatalog
	^self new initializeCartWithCatalog: aCatalog.! !


!classDefinition: #Cashier category: #'TusLibros - Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'cart date priceList card cartOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!Cashier methodsFor: 'evaluating' stamp: 'AM 6/27/2017 00:50:46'!
checkOut
	|totalPrice|

	totalPrice _ 0.

	totalPrice _ cart listCart inject: totalPrice into: [:total :book | total + (priceList at: book)].

	self validateCheckout.
	
	TusLibros debit: totalPrice from: card.

	TusLibros newPurchase: cart for: cartOwner withTotalPrice: totalPrice.
	
	^totalPrice.! !


!Cashier methodsFor: 'initialization' stamp: 'AM 6/18/2017 19:39:11'!
initializeWith: aCart forUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard

	cart _ aCart.
	date _ aDate.
	priceList _ aPriceList.
	card _ aCreditCard.
	cartOwner _ aUser.! !


!Cashier methodsFor: 'error handling' stamp: 'AM 6/26/2017 22:14:52'!
validateCheckout
	cart isEmpty ifTrue: [self error: 'Can''t check out with empty cart'].
	(card isExpiredOn: self today) ifTrue: [self error: 'Can''t check out with expired credit card'].
	card owner = cartOwner ifFalse: [self error: 'credit card owner and cart owner are not the same'].! !


!Cashier methodsFor: 'inspecting' stamp: 'AM 6/25/2017 15:45:08'!
today
	^date.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros - Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AM 6/18/2017 19:37:25'!
checkOut: aCart forUser: aUser today: aDate withPriceList: aPriceList withCard: aCreditCard
	
	^self new initializeWith: aCart forUser: aUser today: aDate withPriceList: aPriceList withCreditCard: aCreditCard.! !


!classDefinition: #CreditCard category: #'TusLibros - Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!CreditCard methodsFor: 'initialization' stamp: 'RC 6/26/2017 19:58:21'!
initializeCardWithCardNumber: aCardNumber withOwner: aOwner andExpirationDate: aDate

	number _ aCardNumber.
	expiration _ aDate.
	owner _ aOwner .
	! !


!CreditCard methodsFor: 'testing' stamp: 'AM 6/25/2017 15:52:49'!
isExpiredOn: aDate 
	^expiration < aDate.! !


!CreditCard methodsFor: 'private' stamp: 'AM 6/27/2017 00:42:51'!
number
	^number.! !

!CreditCard methodsFor: 'private' stamp: 'AM 6/26/2017 22:18:19'!
owner

	^owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros - Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AM 6/26/2017 21:58:42'!
newCardWithCardNumber: aCardNumber withOwner: aOwner andExpirationDate: aDate 

	(aOwner isEmpty) ifTrue: [self error: 'owner is empty'].
	(aCardNumber isKindOf: Integer) ifFalse: [self error: 'card number is not integer'].
	(aCardNumber asString  size = 16) ifFalse: [self error: 'invalid card number length'].
	
	^self new initializeCardWithCardNumber: aCardNumber withOwner: aOwner andExpirationDate: aDate.! !



!classDefinition: #PurchaseSystem category: #'TusLibros - Solution'!
Object subclass: #PurchaseSystem
	instanceVariableNames: 'name clients salesBook cardProcessor catalogWithPrice aliveCarts aliveCartCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!PurchaseSystem methodsFor: 'initialization' stamp: 'AM 6/27/2017 02:05:18'!
initializeWithName: aString withCardProcessor: aCardProcessor withProductCatalog: aCatalog
	name _ aString.
	clients _ Dictionary new.
	salesBook _ Dictionary new.
	cardProcessor _ aCardProcessor.
	catalogWithPrice _ aCatalog.
	aliveCarts _ Dictionary new.
	aliveCartCount _ 0.! !


!PurchaseSystem methodsFor: 'adding' stamp: 'AM 6/27/2017 02:24:04'!
addClient: aClientName

	|clientPurchases clientPurchasesCosts|
	
	clientPurchases _ Bag new.
	
	clientPurchasesCosts _ OrderedCollection new.
	
	clients at: aClientName put: clientPurchases.		
	salesBook at: aClientName put: clientPurchasesCosts.
	
	^aClientName.! !

!PurchaseSystem methodsFor: 'adding' stamp: 'AM 6/27/2017 02:09:03'!
addNewAliveCart: aCart 
	
	aliveCartCount  _ aliveCartCount  + 1.
	aliveCarts at: aliveCartCount put: aCart.
	^aliveCartCount.! !


!PurchaseSystem methodsFor: 'private' stamp: 'AM 6/26/2017 23:32:58'!
newPurchase: aCart for: aClient withTotalPrice: totalPrice
	
	|cartContent|
	
	cartContent _ aCart listCart.
	
	(clients at: aClient) addAll: cartContent.
	(salesBook at: aClient) add: totalPrice.
	! !


!PurchaseSystem methodsFor: 'accessing' stamp: 'AM 6/27/2017 02:15:15'!
getCart: aCartId
	^aliveCarts at: aCartId.! !

!PurchaseSystem methodsFor: 'accessing' stamp: 'AM 6/21/2017 00:02:42'!
userPurchases: aClient 
	^(clients at: aClient) copy.! !


!PurchaseSystem methodsFor: 'inspecting' stamp: 'AM 6/27/2017 01:28:30'!
currentCatalog

	^catalogWithPrice copy.! !

!PurchaseSystem methodsFor: 'inspecting' stamp: 'AM 6/26/2017 23:45:34'!
salesTo: aClient
	^(salesBook at: aClient) copy.! !


!PurchaseSystem methodsFor: 'evaluating' stamp: 'AM 6/27/2017 00:42:18'!
debit: anAmount from: aCreditCard 
	cardProcessor debit: anAmount from: aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseSystem class' category: #'TusLibros - Solution'!
PurchaseSystem class
	instanceVariableNames: ''!

!PurchaseSystem class methodsFor: 'instance creation' stamp: 'AM 6/27/2017 01:31:03'!
newName: newSystemName withCardProcessor: aCardProcessor withProductCatalog: aCatalog
	
	|instance|
	
	instance _ self new initializeWithName: newSystemName withCardProcessor: aCardProcessor withProductCatalog: aCatalog .
	Smalltalk at: newSystemName asSymbol put: instance.! !


!classDefinition: #UserInterface category: #'TusLibros - Solution'!
Object subclass: #UserInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!UserInterface methodsFor: 'request' stamp: 'AM 6/27/2017 02:06:46'!
createCartFor: aUserName authenticatedWith: aUserPass 
	
	|aCart catalog|
	
	catalog _ TusLibros currentCatalog.
	
	aCart _ Cart createCartWithCatalog: catalog.
	
	^TusLibros addNewAliveCart: aCart.
	
	! !


!UserInterface methodsFor: 'inspecting' stamp: 'AM 6/27/2017 02:14:25'!
listCart: aCartId

	|aCart|

	aCart _ TusLibros getCart: aCartId.
	^aCart listCart.! !
