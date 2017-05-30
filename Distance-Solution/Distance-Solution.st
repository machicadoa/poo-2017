!classDefinition: #LongitudTest category: #'Distance-Solution'!
TestCase subclass: #LongitudTest
	instanceVariableNames: 'unMetro dosMetros cienCentimetros milMilimetros unMedioMetro diezKilometros tresMetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 19:22:30'!
test01OneMeterIsEqualToOneMeter

	self assert: unMetro = unMetro.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 19:53:46'!
test02TheSumBetweenMetersIsValid

	self assert: (unMetro + unMetro) = dosMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 19:56:04'!
test03TheSubtractionBetweenMetersIsValid

	self assert: (dosMetros - unMetro) = unMetro.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 19:58:44'!
test04EqualityBetweenDiferentUnitsIsValid
	self assert: cienCentimetros = unMetro.
	self assert: unMetro = cienCentimetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 20:05:11'!
test05AdditionBetweenDiferentUnitsIsValid
	self assert: cienCentimetros + milMilimetros = dosMetros.
	self assert: milMilimetros + cienCentimetros = dosMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 20:01:00'!
test06SubtractionBetweenDiferentUnitsIsValid
	self assert: dosMetros - cienCentimetros = milMilimetros.
	self assert: dosMetros - milMilimetros = cienCentimetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 20:10:10'!
test07OneMeterTimesTwoIsEqualToTwoMeters
	self assert: unMetro * 2 equals: dosMetros.
	self assert: 2 * unMetro equals: dosMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 21:00:35'!
test08OneMeterDividedByScalarIsValid

	self assert: unMetro / 2 equals: unMedioMetro.
	self assert: milMilimetros / 0.5 = dosMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 21:18:27'!
test09UnitTimesScalarIsValid

	self assert: 0.5 * cienCentimetros = unMedioMetro.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 21:21:40'!
test10OperatorGreaterThanIsValid

	self assert: diezKilometros > unMetro.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 21:20:04'!
test11OperatorGreaterOrEqualThanIsValid

	self assert: diezKilometros >= unMetro.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 21:21:32'!
test12OperatorLesserThanIsValid

	self assert:  unMetro < tresMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/23/2017 21:22:16'!
test13OperatorLesserOrEqualThanIsValid

	self assert:  unMetro <= tresMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/28/2017 23:39:05'!
test14IntervalIsConformedOnlyByExpectedPointsBetweenBothEnds

	|interval|
	interval := unMetro to: tresMetros.
	
	self assert: interval size = 3.
	self assert: (interval at: 1) = unMetro.
	self assert: (interval at: 2) = dosMetros.
	self assert: (interval at: 3) = tresMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/28/2017 23:57:43'!
test15IntervalIsConformedOnlyByPointsWithinBoundsSeparatedBySpecifiedDistance

	|interval|
	interval := unMetro to: tresMetros by: unMetro.
	
	self assert: interval size = 3.
	self assert: (interval at: 1) = unMetro.
	self assert: (interval at: 2) = dosMetros.
	self assert: (interval at: 3) = tresMetros.! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/29/2017 00:04:30'!
test16IterationBetweenBoundsWorksAsExpected

	|valueList|
	
	valueList  := OrderedCollection new.
	valueList add: unMetro.
	valueList add: dosMetros.
	valueList add: tresMetros.

	unMetro to: tresMetros by: unMetro do:
	[:each|
		self assert: each = (valueList at: 1).
		valueList removeFirst.
	]! !

!LongitudTest methodsFor: 'tests' stamp: 'AM 5/30/2017 10:32:44'!
test17CanCreateNewUnitsCorrectly
	|unMetroDeclaradoDeOtraForma|
	
	unMetroDeclaradoDeOtraForma  := Longitud newUnitName: 'metro' scaleWithMeter: 1 amount: 1.
	
	self assert: unMetro = unMetroDeclaradoDeOtraForma.! !


!LongitudTest methodsFor: 'setup' stamp: 'AM 5/23/2017 21:14:32'!
setUp
	unMetro _ Longitud newMetros: 1.
	dosMetros _ Longitud newMetros: 2.
	tresMetros _ Longitud newMetros: 3.	
	cienCentimetros _ Longitud newCentimetros: 100.
	milMilimetros _ Longitud newMilimetros: 1000.
	unMedioMetro _ Longitud newCentimetros: 50.
	diezKilometros _ Longitud newKilometros: 10.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:44:48'!
minusOneMeter
	
	^Longitud newMetros: -1.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:45:46'!
oneCentimeter
	
	^Longitud newCentimetros: 1.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:46:08'!
oneHundredCentimeters
	
	^Longitud newCentimetros: 100.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:46:33'!
oneMeter
	
	^Longitud newMetros: 1.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:47:39'!
twoHundredCentimeters
	
	^Longitud newCentimetros: 200.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:48:13'!
twoMeters
	
	^Longitud newMetros: 2.! !

!DistanceFactory methodsFor: 'constant' stamp: 'AM 5/25/2017 18:48:32'!
zeroMeters
	
	^Longitud newMetros: 0.! !


!classDefinition: #Longitud category: #'Distance-Solution'!
Object subclass: #Longitud
	instanceVariableNames: 'milimetros unitName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Longitud methodsFor: 'arithmetic operations' stamp: 'AM 5/23/2017 17:41:28'!
* anInteger
	^Longitud newMilimetros: self value * anInteger.! !

!Longitud methodsFor: 'arithmetic operations' stamp: 'AM 5/21/2017 20:36:28'!
+ aLongitud 
	^Longitud newMilimetros: self value + aLongitud value.! !

!Longitud methodsFor: 'arithmetic operations' stamp: 'AM 5/21/2017 20:23:15'!
- aLongitud 
	^Longitud newMilimetros: self value - aLongitud value.! !

!Longitud methodsFor: 'arithmetic operations' stamp: 'AM 5/23/2017 19:07:19'!
/ anInteger 
	^self class newMilimetros: self value / anInteger.! !


!Longitud methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:15:16'!
< aLongitud 
	^self value < aLongitud value.! !

!Longitud methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:16:36'!
<= aLongitud 
	^self value <= aLongitud value! !

!Longitud methodsFor: 'comparing' stamp: 'AM 5/21/2017 19:58:45'!
= aLongitud 
	^self value = aLongitud value.! !

!Longitud methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:09:49'!
> aLongitud 
	^self value > aLongitud value.! !

!Longitud methodsFor: 'comparing' stamp: 'AM 5/23/2017 21:12:15'!
>= aLongitud 
	^self value >= aLongitud value.! !


!Longitud methodsFor: 'initialization' stamp: 'AM 5/30/2017 10:15:39'!
initializeWithName: aUnitName scaleWithMeter: aScale amount: aNumber
	milimetros := aNumber * aScale * 1000.
	unitName := aUnitName.! !


!Longitud methodsFor: 'private' stamp: 'AM 5/23/2017 20:53:48'!
adaptToNumber: aNumber andSend: selector 
	^self perform: selector with: aNumber.! !

!Longitud methodsFor: 'private' stamp: 'AM 5/21/2017 20:29:57'!
value
	
	^milimetros.! !


!Longitud methodsFor: 'intervals' stamp: 'AM 5/28/2017 19:21:42'!
to: aLongitud 
	|step|
	
	step := self class newMetros: 1.
	^self to: aLongitud by: step.! !

!Longitud methodsFor: 'intervals' stamp: 'AM 5/28/2017 19:20:52'!
to: aLongitud by: step 

	|interval nextValue|
	
	interval := OrderedCollection new.
	nextValue := self.
	[nextValue <= aLongitud ]
		whileTrue:
			[interval add: nextValue.
			nextValue := nextValue + step].
	^interval.! !

!Longitud methodsFor: 'intervals' stamp: 'AM 5/28/2017 23:28:31'!
to: aLongitud by: step do: aBlockClosure 

	|nextValue|
	
	nextValue := self.
	[nextValue <= aLongitud ]
		whileTrue:
			[aBlockClosure value: nextValue.
			nextValue := nextValue + step].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Longitud class' category: #'Distance-Solution'!
Longitud class
	instanceVariableNames: ''!

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:26:00'!
newCentimetros: anNumber
	^self newUnitName: 'centimetro' scaleWithMeter: 1/100 amount: anNumber.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:27:17'!
newKilometros: anNumber
	^self newUnitName: 'kilometro' scaleWithMeter: 1000 amount: anNumber.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:27:53'!
newMetros: anNumber
	^self newUnitName: 'metro' scaleWithMeter: 1 amount: anNumber.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:29:19'!
newMilimetros: anNumber
	^self newUnitName: 'milimetro' scaleWithMeter: 1/1000 amount: anNumber.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/30/2017 10:10:35'!
newUnitName: aUnitName scaleWithMeter: aScale amount: aNumber 
	^self new initializeWithName: aUnitName scaleWithMeter: aScale amount: aNumber.! !
