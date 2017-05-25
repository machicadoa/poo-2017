!classDefinition: #LongitudTest category: #Metro!
TestCase subclass: #LongitudTest
	instanceVariableNames: 'unMetro dosMetros cienCentimetros milMilimetros unMedioMetro diezKilometros tresMetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metro'!

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:14:32'!
setUp
	unMetro _ Longitud newMetros: 1.
	dosMetros _ Longitud newMetros: 2.
	tresMetros _ Longitud newMetros: 3.	
	cienCentimetros _ Longitud newCentimetros: 100.
	milMilimetros _ Longitud newMilimetros: 1000.
	unMedioMetro _ Longitud newCentimetros: 50.
	diezKilometros _ Longitud newKilometros: 10.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 19:22:30'!
test01OneMeterIsEqualToOneMeter

	self assert: unMetro = unMetro.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 19:53:46'!
test02TheSumBetweenMetersIsValid

	self assert: (unMetro + unMetro) = dosMetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 19:56:04'!
test03TheSubtractionBetweenMetersIsValid

	self assert: (dosMetros - unMetro) = unMetro.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 19:58:44'!
test04EqualityBetweenDiferentUnitsIsValid
	self assert: cienCentimetros = unMetro.
	self assert: unMetro = cienCentimetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:05:11'!
test05AdditionBetweenDiferentUnitsIsValid
	self assert: cienCentimetros + milMilimetros = dosMetros.
	self assert: milMilimetros + cienCentimetros = dosMetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:01:00'!
test06SubtractionBetweenDiferentUnitsIsValid
	self assert: dosMetros - cienCentimetros = milMilimetros.
	self assert: dosMetros - milMilimetros = cienCentimetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:10:10'!
test07OneMeterTimesTwoIsEqualToTwoMeters
	self assert: unMetro * 2 equals: dosMetros.
	self assert: 2 * unMetro equals: dosMetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:00:35'!
test08OneMeterDividedByScalarIsValid

	self assert: unMetro / 2 equals: unMedioMetro.
	self assert: milMilimetros / 0.5 = dosMetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:18:27'!
test09UnitTimesScalarIsValid

	self assert: 0.5 * cienCentimetros = unMedioMetro.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:21:40'!
test10OperatorGreaterThanIsValid

	self assert: diezKilometros > unMetro.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:20:04'!
test11OperatorGreaterOrEqualThanIsValid

	self assert: diezKilometros >= unMetro.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:21:32'!
test12OperatorLesserThanIsValid

	self assert:  unMetro < tresMetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:22:16'!
test13OperatorLesserOrEqualThanIsValid

	self assert:  unMetro <= tresMetros.! !


!classDefinition: #DistanceFactory category: #Metro!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metro'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:44:48'!
minusOneMeter
	
	^Longitud newMetros: -1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:45:46'!
oneCentimeter
	
	^Longitud newCentimetros: 1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:46:08'!
oneHundredCentimeters
	
	^Longitud newCentimetros: 100.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:46:33'!
oneMeter
	
	^Longitud newMetros: 1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:47:39'!
twoHundredCentimeters
	
	^Longitud newCentimetros: 200.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:48:13'!
twoMeters
	
	^Longitud newMetros: 2.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'AM 5/25/2017 18:48:32'!
zeroMeters
	
	^Longitud newMetros: 0.! !


!classDefinition: #Longitud category: #Metro!
Object subclass: #Longitud
	instanceVariableNames: 'milimetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metro'!

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 17:41:28'!
* anInteger
	^Longitud newMilimetros: self value * anInteger.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:36:28'!
+ aLongitud 
	^Longitud newMilimetros: self value + aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:23:15'!
- aLongitud 
	^Longitud newMilimetros: self value - aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 19:07:19'!
/ anInteger 
	^self class newMilimetros: self value / anInteger.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:15:16'!
< aLongitud 
	^self value < aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:16:36'!
<= aLongitud 
	^self value <= aLongitud value! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 19:58:45'!
= aLongitud 
	^self value = aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:09:49'!
> aLongitud 
	^self value > aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:12:15'!
>= aLongitud 
	^self value >= aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:53:48'!
adaptToNumber: aNumber andSend: selector 
	^self perform: selector with: aNumber.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:20:19'!
initializeWithMilimetros: anInteger
	milimetros := anInteger.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:29:57'!
value
	
	^milimetros.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Longitud class' category: #Metro!
Longitud class
	instanceVariableNames: ''!

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:40:57'!
newCentimetros: anInteger 
	^self new initializeWithMilimetros: anInteger * 10.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 21:07:34'!
newKilometros: anInteger
	^self new initializeWithMilimetros: anInteger * 1000000.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:40:10'!
newMetros: anInteger
	^self new initializeWithMilimetros: anInteger * 1000.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/23/2017 20:39:17'!
newMilimetros: anInteger
	^self new initializeWithMilimetros: anInteger.! !
