!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter twoMeters threeMeters oneHundredCentimeters oneThousandMillimeters oneHalfMeter tenKilometers factory'
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

!DistanceTest methodsFor: 'tests' stamp: 'AM 6/4/2017 23:20:05'!
test17CanCreateNewUnitsCorrectly
	|anotherMeter|
	
	anotherMeter  := Unit newName: 'metro' scaleWithMeter: 1.
	
	self assert: meter = anotherMeter.! !


!DistanceTest methodsFor: 'setup' stamp: 'AM 6/4/2017 17:31:25'!
setUp
	factory := DistanceFactory new.

	oneMeter _ factory oneMeter.
	twoMeters _ factory twoMeters.
	threeMeters _ factory threeMeters.
	oneHundredCentimeters _ factory oneHundredCentimeters.
	oneThousandMillimeters _ factory oneThousandMillimeters.
	oneHalfMeter _ factory oneMeter * (1/2).
	tenKilometers _ factory oneKilometer * 10.! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'milimetros unitName unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/4/2017 18:56:38'!
* anInteger
	^self class newWithUnit: unit andAmount: amount * anInteger.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/4/2017 19:00:53'!
+ aDistance
	^self class newWithUnit: meter andAmount: self value + aDistance value.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/4/2017 19:07:05'!
- aDistance 
	^self class newWithUnit: meter andAmount: self value - aDistance value.! !

!Distance methodsFor: 'arithmetic operations' stamp: 'AM 6/4/2017 23:05:31'!
/ anInteger 
	^self class newWithUnit: unit andAmount: amount / anInteger.! !


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


!Distance methodsFor: 'intervals' stamp: 'AM 6/2/2017 20:28:40'!
negated
	^Distance newUnitName: self unit scaleWithMeter: 1 / 1000 amount: 0 - self value.
	
	! !

!Distance methodsFor: 'intervals' stamp: 'RC 6/1/2017 21:27:00'!
printString

	^self unit.! !

!Distance methodsFor: 'intervals' stamp: 'AM 6/4/2017 23:16:16'!
to: aLongitud 
	|step|
	step := self class newWithUnit: meter andAmount: 1.
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

!Distance methodsFor: 'intervals' stamp: 'AM 6/4/2017 19:05:16'!
value
	^unit scale * amount.! !


!Distance methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:30:17'!
initializeWithUnit: aUnit andAmount: aNumber
	unit := aUnit.
	amount := aNumber.! !

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

!Distance class methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:29:30'!
newWithUnit: aUnit andAmount: aNumber
	^self new initializeWithUnit: aUnit andAmount:aNumber.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:05:32'!
minusOneMeter
	
	^-1 * meter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:17:07'!
oneCentimeter
	
	^1 * centimeter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:17:18'!
oneHundredCentimeters
	
	^100 * centimeter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:16:12'!
oneKilometer
	
	^1 * kilometer.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:21:39'!
oneMeter
	^1 * meter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:14:01'!
oneThousandMillimeters
	
	^1000 * millimeter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:09:36'!
threeMeters
	
	^3 * meter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:18:03'!
twoHundredCentimeters
	
	^200 * centimeter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:20:29'!
twoMeters
	
	^2 * meter.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:20:39'!
zeroMeters
	
	^0 * meter.! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'unitName scale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:28:03'!
* aNumber 
	
	^Distance newWithUnit: self andAmount: aNumber.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 23:25:40'!
= anotherUnit

	^self hash = anotherUnit hash! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:25:49'!
adaptToNumber: aNumber andSend: selector 
	^self perform: selector with: aNumber.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 23:24:25'!
hash

	^scale.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/2/2017 20:52:08'!
initializeWithName: aName andScale: aScale 
	unitName _ aName.
	scale _ aScale.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/2/2017 20:55:59'!
printString

	^unitName.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 19:05:42'!
scale

	^scale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 23:31:38'!
newName: aUnitName scaleWithMeter: aScale 
	|newUnit|
	
	newUnit := self new initializeWithName: aUnitName andScale: aScale.
	
	Smalltalk at: aUnitName asSymbol ifAbsentPut: [newUnit].
	
	^newUnit.! !
