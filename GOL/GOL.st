!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:14'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:19'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:01:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 18:09:08'!
test06CreateCellOutsideBounds

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: GameOfLife CellOutOfBoundsErrorDescription ]! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 22:39:08'!
test07InitialAliveCellXCoordenateIsInteger

	self 
		should: [ GameOfLife withLiveCells: { 2@0.5 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: GameOfLife CellIsNotIntegerErrorDescription]! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 22:43:56'!
test08InitialAliveCellYCoordenateIsInteger

	self 
		should: [ GameOfLife withLiveCells: { 0.5@1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: GameOfLife CellIsNotIntegerErrorDescription]! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 20:19:56'!
deadCells
	
	| deadCells |
	
	deadCells _ OrderedCollection new.
	0 to: board corner x do: [ :x |
		0 to: board corner y do: [ :y |
			(aliveCells includes: x@y) not ifTrue: [ deadCells add: x@y]]].
	^deadCells ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 23:03:54'!
initializeWith: aSetOfAliveCells withSize: aSize

	board := Rectangle origin:0@0 corner: aSize.
	aliveCells := aSetOfAliveCells.
	
	(aliveCells allSatisfy: [:aCell | board containsPoint: aCell ]) ifFalse: [ self error: GameOfLife CellOutOfBoundsErrorDescription ].
	(aliveCells allSatisfy: [:aCell | aCell x isInteger and: [aCell y isInteger ]]) ifFalse: [ self error: GameOfLife CellIsNotIntegerErrorDescription ]! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 19:27:10'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :anAliveCell | self hasToSurvive: anAliveCell ]) union:
		(self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ])
		
		
	"Me interesaría mejorar la forma en que se calculan  las caldas a resucitar pero no creo que sea el punto..."! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 22:42:56'!
CellIsNotIntegerErrorDescription

	^'las coordenadas de la celda deben ser numeros enteros'.! !

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 18:07:41'!
CellOutOfBoundsErrorDescription

	^'celda fuera de rango'.! !

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'AM 5/13/2017 18:10:13'!
withLiveCells: aCollectionOfAliveCells withSize: aPoint 
	
	^self new initializeWith: aCollectionOfAliveCells asSet withSize: aPoint ! !
