!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter twoMeters threeMeters oneHundredCentimeters oneThousandMillimeters oneHalfMeter tenKilometers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:34:42'!
test01OneMeterIsEqualToOneMeter

	self assert: oneMeter = oneMeter.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:34:48'!
test02TheSumBetweenMetersIsValid

	self assert: (oneMeter + oneMeter) = twoMeters.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:34:54'!
test03TheSubtractionBetweenMetersIsValid

	self assert: (twoMeters - oneMeter) = oneMeter.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:34:59'!
test04EqualityBetweenDiferentUnitsIsValid
	self assert: oneHundredCentimeters = oneMeter.
	self assert: oneMeter = oneHundredCentimeters.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:04'!
test05AdditionBetweenDiferentUnitsIsValid
	self assert: oneHundredCentimeters + oneThousandMillimeters = twoMeters.
	self assert: oneThousandMillimeters + oneHundredCentimeters = twoMeters.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:11'!
test06SubtractionBetweenDiferentUnitsIsValid
	self assert: twoMeters - oneHundredCentimeters = oneThousandMillimeters.
	self assert: twoMeters - oneThousandMillimeters = oneHundredCentimeters.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:20'!
test07OneMeterTimesTwoIsEqualToTwoMeters
	self assert: oneMeter * 2 equals: twoMeters.
	self assert: 2 * oneMeter equals: twoMeters.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:39:50'!
test08OneMeterDividedByScalarIsValid

	self assert: oneMeter / 2 equals: oneHalfMeter.
	self assert: oneThousandMillimeters / (1/2) = twoMeters.! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:32'!
test09UnitTimesScalarIsValid

	self assert: 0.5 * oneHundredCentimeters = oneHalfMeter .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:39'!
test10OperatorGreaterThanIsValid

	self assert: tenKilometers > oneMeter .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:47'!
test11OperatorGreaterOrEqualThanIsValid

	self assert: tenKilometers >= oneMeter .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:35:56'!
test12OperatorLesserThanIsValid

	self assert:  oneMeter < threeMeters .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:36:05'!
test13OperatorLesserOrEqualThanIsValid

	self assert:  oneMeter <= threeMeters .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:36:10'!
test14IntervalIsConformedOnlyByExpectedPointsBetweenBothEnds

	|interval|
	interval := oneMeter to: threeMeters .
	
	self assert: interval size = 3.
	self assert: (interval at: 1) = oneMeter.
	self assert: (interval at: 2) = twoMeters .
	self assert: (interval at: 3) = threeMeters .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:36:15'!
test15IntervalIsConformedOnlyByPointsWithinBoundsSeparatedBySpecifiedDistance

	|interval|
	interval := oneMeter to: threeMeters by: oneMeter .
	
	self assert: interval size = 3.
	self assert: (interval at: 1) = oneMeter .
	self assert: (interval at: 2) = twoMeters .
	self assert: (interval at: 3) = threeMeters .! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:36:22'!
test16IterationBetweenBoundsWorksAsExpected

	|valueList|
	
	valueList  := OrderedCollection new.
	valueList add: oneMeter .
	valueList add: twoMeters .
	valueList add: threeMeters .

	oneMeter to: threeMeters by: oneMeter do:
	[:each|
		self assert: each = (valueList at: 1).
		valueList removeFirst.
	]! !

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/2/2017 20:40:30'!
test17CanCreateNewUnitsCorrectly
	|anotherMeter|
	
	anotherMeter  := Distance newUnitName: 'metro' scaleWithMeter: 1 amount: 1.
	
	self assert: oneMeter = anotherMeter.! !


!DistanceTest methodsFor: 'setup' stamp: 'AM 6/2/2017 20:33:56'!
setUp
	oneMeter _ Distance newMetros: 1.
	twoMeters _ Distance newMetros: 2.
	threeMeters _ Distance newMetros: 3.	
	oneHundredCentimeters _ Distance newCentimetros: 100.
	oneThousandMillimeters _ Distance newMilimetros: 1000.
	oneHalfMeter _ Distance newCentimetros: 50.
	tenKilometers _ Distance newKilometros: 10.! !



!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'milimetros unitName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/2/2017 20:29:15'!
* anInteger
	^Distance newMilimetros: self value * anInteger.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/2/2017 20:28:55'!
+ aDistance
	^Distance newMilimetros: self value + aDistance value.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/2/2017 20:29:29'!
- aDistance 
	^Distance newMilimetros: self value - aDistance value.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 5/23/2017 19:07:19'!
/ anInteger 
	^self class newMilimetros: self value / anInteger.! !


!Distance methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:15:16'!
< aLongitud 
	^self value < aLongitud value.! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:16:36'!
<= aLongitud 
	^self value <= aLongitud value! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/21/2017 19:58:45'!
= aLongitud 
	^self value = aLongitud value.! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:09:49'!
> aLongitud 
	^self value > aLongitud value.! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:12:15'!
>= aLongitud 
	^self value >= aLongitud value.! !


!Distance methodsFor: 'initialization' stamp: 'AM 5/30/2017 10:15:39'!
initializeWithName: aUnitName scaleWithMeter: aScale amount: aNumber
	milimetros := aNumber * aScale * 1000.
	unitName := aUnitName.! !


!Distance methodsFor: 'private' stamp: 'AM 5/23/2017 20:53:48'!
adaptToNumber: aNumber andSend: selector 
	^self perform: selector with: aNumber.! !

!Distance methodsFor: 'private' stamp: 'RC 6/1/2017 20:56:54'!
amount
	
	^self value.! !

!Distance methodsFor: 'private' stamp: 'AM 5/21/2017 20:29:57'!
value
	
	^milimetros.! !


!Distance methodsFor: 'intervals' stamp: 'AM 6/2/2017 20:28:40'!
negated
	^Distance newUnitName: self unit scaleWithMeter: 1 / 1000 amount: 0 - self value.
	
	! !

!Distance methodsFor: 'intervals' stamp: 'RC 6/1/2017 21:27:00'!
printString

	^self unit.! !

!Distance methodsFor: 'intervals' stamp: 'AM 5/28/2017 19:21:42'!
to: aLongitud 
	|step|
	
	step := self class newMetros: 1.
	^self to: aLongitud by: step.! !

!Distance methodsFor: 'intervals' stamp: 'AM 5/28/2017 19:20:52'!
to: aLongitud by: step 

	|interval nextValue|
	
	interval := OrderedCollection new.
	nextValue := self.
	[nextValue <= aLongitud ]
		whileTrue:
			[interval add: nextValue.
			nextValue := nextValue + step].
	^interval.! !

!Distance methodsFor: 'intervals' stamp: 'AM 5/28/2017 23:28:31'!
to: aLongitud by: step do: aBlockClosure 

	|nextValue|
	
	nextValue := self.
	[nextValue <= aLongitud ]
		whileTrue:
			[aBlockClosure value: nextValue.
			nextValue := nextValue + step].! !

!Distance methodsFor: 'intervals' stamp: 'RC 6/1/2017 20:57:39'!
unit
	^unitName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:26:00'!
newCentimetros: anNumber
	^self newUnitName: 'centimetro' scaleWithMeter: 1/100 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'RC 6/1/2017 21:29:08'!
newDecametro: anNumber
	^self newUnitName: 'decameter' scaleWithMeter: 10 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'RC 6/1/2017 21:29:14'!
newDecimetros: anNumber
	^self newUnitName: 'decimeter' scaleWithMeter: 1/10 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'RC 6/1/2017 21:21:07'!
newHectometro: anNumber
	^self newUnitName: 'hectometro' scaleWithMeter: 100 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:27:17'!
newKilometros: anNumber
	^self newUnitName: 'kilometro' scaleWithMeter: 1000 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'RC 6/1/2017 21:28:40'!
newMetros: anNumber
	^self newUnitName: 'meter' scaleWithMeter: 1 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:29:19'!
newMilimetros: anNumber
	^self newUnitName: 'milimetro' scaleWithMeter: 1/1000 amount: anNumber.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:10:35'!
newUnitName: aUnitName scaleWithMeter: aScale amount: aNumber 
	^self new initializeWithName: aUnitName scaleWithMeter: aScale amount: aNumber.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:28:14'!
minusOneMeter
	
	^Distance newMetros: -1.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:28:23'!
oneCentimeter
	
	^Distance newCentimetros: 1.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:28:04'!
oneHundredCentimeters
	
	^Distance newCentimetros: 100.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:28:30'!
oneMeter
	
	^Distance newMetros: 1.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:27:59'!
twoHundredCentimeters
	
	^Distance newCentimetros: 200.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:28:33'!
twoMeters
	
	^Distance newMetros: 2.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/2/2017 20:27:55'!
zeroMeters
	
	^Distance newMetros: 0.! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'unitName scale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/2/2017 20:52:08'!
initializeWithName: aName andScale: aScale 
	unitName _ aName.
	scale _ aScale.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/2/2017 20:55:59'!
printString

	^unitName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'AM 6/2/2017 20:51:48'!
newName: aUnitName scaleWithMeter: aScale 
	^self new initializeWithName: aUnitName andScale: aScale.! !
