!classDefinition: #DistanceTest category: #'Measure-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter twoMeters threeMeters oneHundredCentimeters oneThousandMillimeters oneHalfMeter tenKilometers factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

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


!DistanceTest methodsFor: 'setup' stamp: 'rod 6/8/2017 02:56:50'!
setUp
	factory := MeasureFactory new.

	oneMeter _ factory oneMeter.
	twoMeters _ factory twoMeters.
	threeMeters _ factory threeMeters.
	oneHundredCentimeters _ factory oneHundredCentimeters.
	oneThousandMillimeters _ factory oneThousandMillimeters.
	oneHalfMeter _ factory oneMeter * (1/2).
	tenKilometers _ factory oneKilometer * 10.! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:50:10'!
test01

|oneKilogram gram|

	gram := Unit newName: 'gram'  scaleWithBaseUnit: 1.
	oneKilogram := Weight newUnit: gram andAmount: 1000.

	self assert: oneKilogram = oneKilogram.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:56:51'!
test02

	self assert: (1 * gram) class = Weight.! !


!classDefinition: #Distance category: #'Measure-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

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

!Distance methodsFor: 'comparing' stamp: 'AM 6/6/2017 20:22:22'!
= aLongitud 
	^self hash = aLongitud hash.! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:09:49'!
> aLongitud 
	^self value > aLongitud value.! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:12:15'!
>= aLongitud 
	^self value >= aLongitud value.! !

!Distance methodsFor: 'comparing' stamp: 'AM 6/6/2017 19:33:39'!
convertTo: otraUnidad

	^ (otraUnidad scale) * otraUnidad.! !


!Distance methodsFor: 'initialization' stamp: 'AM 5/30/2017 10:15:39'!
initializeWithName: aUnitName scaleWithMeter: aScale amount: aNumber
	milimetros := aNumber * aScale * 1000.
	unitName := aUnitName.! !


!Distance methodsFor: 'private' stamp: 'AM 5/23/2017 20:53:48'!
adaptToNumber: aNumber andSend: selector 
	^self perform: selector with: aNumber.! !

!Distance methodsFor: 'private' stamp: 'AM 6/6/2017 19:17:02'!
amount
	
	^amount.! !


!Distance methodsFor: 'intervals' stamp: 'AM 6/6/2017 19:36:13'!
negated
	^ (-1*amount) * unit
	
	"Distance newUnitName: self unit scaleWithMeter: 1 / 1000 amount: 0 - self value."
	
	! !

!Distance methodsFor: 'intervals' stamp: 'AM 6/6/2017 20:17:26'!
printString
|toString|
	toString := amount printString .
	
	^((toString append: ' ')
		 
		append: unit printString) 
		 
	     append: ((amount > 1) ifTrue: ['s'] ifFalse: [''])! !

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

!Distance methodsFor: 'intervals' stamp: 'AM 6/6/2017 19:06:19'!
unit
	^unit.! !

!Distance methodsFor: 'intervals' stamp: 'AM 6/6/2017 19:14:32'!
value
	^ amount / unit scale.! !


!Distance methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 19:46:06'!
between: unaDistancia and: otraDistancia 
	
	^self value >= unaDistancia value and: [self value <= otraDistancia value]! !

!Distance methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:29:49'!
hash

	^self value.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:30:17'!
initializeWithUnit: aUnit andAmount: aNumber
	unit := aUnit.
	amount := aNumber.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 19:42:44'!
max: otraDistancia

	(self > otraDistancia) 
		ifTrue: [^self]
		ifFalse: [^otraDistancia]! !

!Distance methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 19:43:26'!
min: otraDistancia

	(self < otraDistancia) 
		ifTrue: [^self]
		ifFalse: [^otraDistancia]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Measure-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:29:30'!
newWithUnit: aUnit andAmount: aNumber
	^self new initializeWithUnit: aUnit andAmount:aNumber.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 02:54:18'!
amount 

	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 02:50:07'!
initializeWithUnit: anUnit andAmount: aNumber 
	unit := anUnit.
	amount := aNumber.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 02:53:59'!
unit 

	^unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 03:37:44'!
value
	^ amount / unit scale.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 03:41:39'!
valueInBaseUnit
	^ amount * unit scale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 02:52:30'!
newWithUnit: anUnit andAmount: aNumber 
	
	^self new initializeWithUnit: anUnit andAmount: aNumber.! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:05:32'!
minusOneMeter
	
	^-1 * meter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:32:39'!
oneCelsius 

	^1 * celsius.! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:17:07'!
oneCentimeter
	
	^1 * centimeter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:34:56'!
oneDay 

	^ 1 * day.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:35:06'!
oneHour  

	^ 1 * hour.! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:17:18'!
oneHundredCentimeters
	
	^100 * centimeter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:16:12'!
oneKilometer
	
	^1 * kilometer.! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:21:39'!
oneMeter
	^1 * meter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:35:18'!
oneMinute   

	^ 1 * minute.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:35:27'!
oneSecond   

	^ 1 * second.! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:14:01'!
oneThousandMillimeters
	
	^1000 * millimeter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:35:41'!
sixtyMinutes    

	^ 60 * minute.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:35:55'!
sixtyOneSeconds     

	^ 61 * second.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:36:06'!
sixtySeconds      

	^ 60 * second.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:33:28'!
thirtyTwoFahrenheits 

	^32*fahrenheit .! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:09:36'!
threeMeters
	
	^3 * meter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:36:21'!
twentyFourHours       

	^ 24 * hour.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:33:49'!
twoCelsius 

	^2*celsius .! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:18:03'!
twoHundredCentimeters
	
	^200 * centimeter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:20:29'!
twoMeters
	
	^2 * meter.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:36:37'!
twoSeconds        

	^ 2 * second.! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:34:09'!
zeroCelsius 

	^0 * celsius .! !

!MeasureFactory methodsFor: 'constant' stamp: 'rod 6/8/2017 03:34:35'!
zeroKelvin


	^ 0*kelvin .! !

!MeasureFactory methodsFor: 'constant' stamp: 'AM 6/4/2017 17:20:39'!
zeroMeters
	
	^0 * meter.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'unitName scale measure baseUnit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 02:52:11'!
* aNumber 
	
	^Measure newWithUnit: self andAmount: aNumber.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 23:25:40'!
= anotherUnit

	^self hash = anotherUnit hash! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 17:25:49'!
adaptToNumber: aNumber andSend: selector 
	^self perform: selector with: aNumber.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 23:24:25'!
hash

	^scale.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 03:05:28'!
initializeWithMeasure: aMeasure andUnitName: aUnitName andScale: aScale andBaseUnit: anotherMeasure

	unitName := aUnitName.
	measure := aMeasure.
	scale := aScale. 
	baseUnit := anotherMeasure.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 21:29:49'!
measure

	^measure.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/2/2017 20:55:59'!
printString

	^unitName.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/4/2017 19:05:42'!
scale

	^scale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'rod 6/8/2017 03:18:36'!
isAMeasureOf: aMeasure withUnitName: aUnitName andScale: aScale andBaseUnit: anotherMeasure

	|newUnit|
	
	newUnit := self new	initializeWithMeasure: aMeasure andUnitName: aUnitName andScale: aScale andBaseUnit: anotherMeasure.
	
	Smalltalk at: aUnitName asSymbol ifAbsentPut: [newUnit].
		
	^newUnit.
	
! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:47:18'!
newName: aUnitName scaleWithBaseUnit: aScale 
	|newUnit|
	
	newUnit := self new initializeWithName: aUnitName andScale: aScale.
	
	Smalltalk at: aUnitName asSymbol ifAbsentPut: [newUnit].
	
	^newUnit.! !


!classDefinition: #Weight category: #'Measure-Solution'!
Object subclass: #Weight
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Weight methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:53:07'!
= anotherWeight

	^ self hash = anotherWeight hash.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:53:32'!
hash

	^self value.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:45:58'!
initializeWithUnit: anUnit andAmount: aNumber 
	unit := anUnit.
	amount := aNumber.! !

!Weight methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:54:11'!
value

	^ amount / unit scale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Weight class' category: #'Measure-Solution'!
Weight class
	instanceVariableNames: ''!

!Weight class methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 20:45:13'!
newUnit: anUnit andAmount: aNumber 
	
	^self new initializeWithUnit: anUnit andAmount: aNumber.! !
