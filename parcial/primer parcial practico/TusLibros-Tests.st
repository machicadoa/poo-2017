!classDefinition: #CartTest category: #'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				ownedBy: testObjectsFactory customer 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: testObjectsFactory customer 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart
		ownedBy: testObjectsFactory customer 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #DiscountTest category: #'TusLibros-Tests'!
TestCase subclass: #DiscountTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 19:42:38'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 19:43:01'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 20:58:21'!
test01bookWithQuantityDiscountCostLess

	| cart cashier quantity |
	
	cart := testObjectsFactory createCartWithDiscountCatalog.
	quantity _ 2.
	cart add: quantity of: testObjectsFactory itemWithDiscount.
	
	cashier :=  Cashier
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: (cashier checkOut total + (testObjectsFactory itemWithDiscountDiscount * testObjectsFactory itemWithDiscountCost * quantity)) = ((cart catalog costFor: testObjectsFactory itemWithDiscount) * quantity).! !

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:25:27'!
test02discountForBookWithQuantityDiscountOnlyApliesIfCriteriaIsForfilled

	| cart cashier quantity |
	
	cart := testObjectsFactory createCartWithDiscountCatalog.
	quantity _ 3.
	cart add: quantity of: testObjectsFactory itemWithDiscount.
	
	cashier :=  Cashier
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut total = ((cart catalog costFor: testObjectsFactory itemWithDiscount) * quantity).! !

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:11:14'!
test03discountForBookWithSpecificBookDiscountOnlyApliesIsCriteriaIsForfilled

self assert: true.! !

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:10:58'!
test04discountForBookWithSpecificDayDiscountOnlyApliesIfCriteriaIsForfilled

self assert: true.! !

!DiscountTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:27:51'!
test05aBookWithMultipleDiscountsGetsTheBestAmongThem

	self assert: true.

	! !


!classDefinition: #TusLibrosSystemFacadeTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		shouldnt: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = systemFacade invalidItemErrorMessage ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) . 
	self 
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade sessionHasExpiredErrorDescription ].

	self revertTime: systemFacade sessionDuration.
	self assert: (systemFacade listCartIdentifiedAs: cartId)	isEmpty
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: '1111222233334444' 
		ownedBy: 'Juan Perez' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) = (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: (purchases at: self anotherValidBook) = testObjectsFactory anotherItemSellByTheStorePrice.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test15CanNotListPurchasesOfInvalidCustomer

	self 
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self 
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test01CanCreateCartWithValidUserAndPassword

	self 
		shouldnt: [systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword]
		raise: Error - MessageNotUnderstood ! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard 
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook
	
	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor 

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2015 20:53'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade 
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf: testObjectsFactory defaultCatalog 
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor 
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook
	
	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId
	
	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword
	
	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook
	
	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser
	
	^'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword
	
	^'validUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords
	
	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test10CanCheckoutACart

	| cartId  |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		shouldnt: [systemFacade 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade 
			checkOutCartIdentifiedAs: self invalidCartId  
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade invalidCartIdErrorDescription ]
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade cartCanNotBeEmptyErrorMessage ]
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade canNotChargeAnExpiredCreditCardErrorMessage ]
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) . 
	self 
		should: [systemFacade checkOutCartIdentifiedAs: cartId withCreditCardNumbered: '11' ownedBy: 'jp' expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade sessionHasExpiredErrorDescription ].

	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty 
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test08CanNotListCartOfInvalidCartId

	self 
		should: [systemFacade listCartIdentifiedAs: self invalidCartId] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.
	
	self assert: (cartContent occurrencesOf: self validBook) = 1. 
	self assert: (cartContent occurrencesOf: self anotherValidBook) = 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) . 
	self 
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration 
	
	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration 
	
	clock revertTime: aDuration ! !


!classDefinition: #ManualClock category: #'TusLibros-Tests'!
Clock subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration 
	
	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration 
	
	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now
	
	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today
	
	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime 

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime 
	
	^self new initializeNow: aTime ! !


!classDefinition: #Catalog category: #'TusLibros-Tests'!
Object subclass: #Catalog
	instanceVariableNames: 'priceList discountList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!Catalog methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 20:28:07'!
initialize

	priceList _ Dictionary new.
	discountList _ Dictionary new.! !


!Catalog methodsFor: 'testing' stamp: 'AM 7/4/2017 20:30:43'!
includesKey: anItem
	^priceList includesKey: anItem.! !


!Catalog methodsFor: 'accessing' stamp: 'AM 7/4/2017 20:36:50'!
at: anItem
	
	^priceList at: anItem.! !

!Catalog methodsFor: 'accessing' stamp: 'AM 7/4/2017 20:24:08'!
at: anItem putValue: aCost withDiscount: aDiscount 
	priceList at: anItem put: aCost.
	discountList at: anItem put: aDiscount.! !


!Catalog methodsFor: 'evaluating' stamp: 'AM 7/4/2017 20:50:40'!
costFor: anItem

	^self at: anItem.! !

!Catalog methodsFor: 'evaluating' stamp: 'AM 7/4/2017 20:34:58'!
discountFor: anItem

	^discountList at: anItem.! !


!classDefinition: #Discount category: #'TusLibros-Tests'!
Object subclass: #Discount
	instanceVariableNames: 'value logic'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!Discount methodsFor: 'initialization' stamp: 'AM 7/4/2017 21:34:02'!
initializewithValue: aDiscountValue andCriteria: aDiscountLogic
	value _ aDiscountValue.
	logic _ aDiscountLogic.! !


!Discount methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:36:08'!
discountValue
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Discount class' category: #'TusLibros-Tests'!
Discount class
	instanceVariableNames: ''!

!Discount class methodsFor: 'initialization' stamp: 'AM 7/4/2017 21:35:20'!
withValue: adiscountValue andCriteria: aDiscountLogic 
	^self new initializewithValue: adiscountValue andCriteria: aDiscountLogic ! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice
	
	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AM 7/4/2017 21:37:14'!
defaultCatalog

	|discount|
	
	discount _ Discount withValue: 0 andCriteria: [:quantity|].
	
	^ Catalog new initialize
		at: self itemSellByTheStore putValue: self itemSellByTheStorePrice withDiscount: discount;
		at: self anotherItemSellByTheStore putValue: self anotherItemSellByTheStorePrice withDiscount: discount;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear 

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer
	
	^'aCustomer'! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 20:01:59'!
createCartWithDiscountCatalog

	^Cart acceptingItemsOf: self discountCatalog! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:30:16'!
discountCatalog

	|discount|

	discount _ self itemWithDiscountDiscount.

	^ Catalog new initialize
		at: self itemWithDiscount putValue: self itemWithDiscountCost withDiscount: discount;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 20:03:47'!
itemWithDiscount

	^'pepeBook'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 20:04:12'!
itemWithDiscountCost
	^10.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 21:23:41'!
itemWithDiscountDiscount

	|logic|
	
	logic _ [:quantity | ^quantity = 2.].

	^Discount withValue: 1/10 andCriteria: logic.! !
