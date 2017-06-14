!classDefinition: #LibrosTest category: #'TusLibros - Solution'!
TestCase subclass: #LibrosTest
	instanceVariableNames: 'cartEmptyWithEmptyCatalog elPadrinoBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Solution'!

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:22:54'!
setUp

	|aCatalog|

	aCatalog _ Set new. 

	cartEmptyWithEmptyCatalog  _ 	Cart createCartWithCatalog:  aCatalog .
	
	elPadrinoBook _ 'El Padrino'.
	
	

	 ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:23:07'!
test01aNewCartIsEmpty
	self assert: cartEmptyWithEmptyCatalog isEmpty. ! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:24:47'!
test02AddItemToNewCartThenIsNotEmpty

	cartEmptyWithEmptyCatalog catalog add: elPadrinoBook .
	cartEmptyWithEmptyCatalog addItem: elPadrinoBook quantity: 1.
	
	self deny: cartEmptyWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:25:33'!
test03AddOneItemToNewCartThenCantItemIsOne
	
	cartEmptyWithEmptyCatalog catalog add: elPadrinoBook .
		
	cartEmptyWithEmptyCatalog addItem: elPadrinoBook quantity: 1.
	
	self assert: cartEmptyWithEmptyCatalog cantItem equals: 1.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:26:08'!
test04canNotAddItemWithQuantityLowerThanOne
	cartEmptyWithEmptyCatalog catalog add: elPadrinoBook .
	
	self should: [cartEmptyWithEmptyCatalog addItem: elPadrinoBook quantity: -1] 
	raise: Error 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can Not add item with not positive quantity'].
	
	self assert: cartEmptyWithEmptyCatalog isEmpty.! !

!LibrosTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2017 10:26:32'!
test05canNotAddItemThatArentInCatalog
	self should: [cartEmptyWithEmptyCatalog addItem: elPadrinoBook quantity: 1] 
	raise: Error 
	withExceptionDo: [ :msg | self assert: msg messageText equals: 'Can''t add items that aren''t in the catalog'].
	
	self assert: cartEmptyWithEmptyCatalog isEmpty.! !


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
