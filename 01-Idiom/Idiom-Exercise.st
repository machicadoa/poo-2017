!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/22/2017 18:46:14'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assert: [customerBook addCustomerNamed: 'John Lennon'] shouldNotTakeMoreThan: 50 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/22/2017 18:48:34'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	self assert: [customerBook removeCustomerNamed: paulMcCartney] shouldNotTakeMoreThan: 100 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/22/2017 20:57:03'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	"[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]"
		
	self assert: [customerBook addCustomerNamed: ''] shouldFailOn: Error knowingThat: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage].
	self assert: [customerBook addCustomerNamed: ''] shouldFailOn: Error knowingThat: [customerBook isEmpty].
	 
	"Me gustaría pasarle una lista de aserciones pero así queda más declarativo."! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/22/2017 20:42:08'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	"[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]"
	self assert: [customerBook removeCustomerNamed: 'Paul McCartney'] shouldFailOn: NotFound knowingThat: [customerBook numberOfCustomers = 1].
	self assert: [customerBook removeCustomerNamed: 'Paul McCartney'] shouldFailOn: NotFound knowingThat: [customerBook includesCustomerNamed: johnLennon].
	
	"Me gustaría pasarle una lista de aserciones pero así queda más declarativo."
! !


!IdiomTest methodsFor: 'extend' stamp: 'AM 4/22/2017 21:00:06'!
assert: aBlockClosure shouldFailOn: anException knowingThat: thisIsTrue
	"Asserts to True is thisIsTrue is realy True after anExeption is caught."

	[aBlockClosure value.
	self fail]
	on: anException
	do: [:anError | self assert: (thisIsTrue valueWithPossibleArgument: anError)]! !

!IdiomTest methodsFor: 'extend' stamp: 'AM 4/22/2017 18:51:25'!
assert: aClosure shouldNotTakeMoreThan: aMillisecondsLimit
	"asserts to true if aClosure is executed in less than aMillisecondsLimit"
	
	^self assert: aClosure timeToRun < aMillisecondsLimit ! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
