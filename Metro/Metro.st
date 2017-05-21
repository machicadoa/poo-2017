!classDefinition: #LongitudTest category: #Metro!
TestCase subclass: #LongitudTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metro'!

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 19:36:00'!
test01

	|unMetro|
	
	unMetro := Longitud newMetros: 1.
	
	self assert: unMetro = unMetro.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 19:41:30'!
test02

	|unMetro dosMetros|
	
	unMetro := Longitud newMetros: 1.
	dosMetros := Longitud newMetros: 2.
	
	self assert: (unMetro + unMetro) = dosMetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:15:49'!
test03

	|unMetro cienCentimetros|
	
	unMetro := Longitud newMetros: 1.
	cienCentimetros := Longitud newCentimetros: 100.
	
	self assert: cienCentimetros = unMetro.
	self assert: unMetro = cienCentimetros.! !

!LongitudTest methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:38:43'!
test04

	|dosMetros cienCentimetros milMilimetros|
	
	dosMetros := Longitud newMetros: 2.
	cienCentimetros := Longitud newCentimetros: 100.
	milMilimetros := Longitud newMilimetros: 1000.
	
	self assert: dosMetros - cienCentimetros = milMilimetros.
	self assert: dosMetros - milMilimetros = cienCentimetros.
	self assert: cienCentimetros + milMilimetros = dosMetros.! !


!classDefinition: #Longitud category: #Metro!
Object subclass: #Longitud
	instanceVariableNames: 'milimetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metro'!

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:36:28'!
+ aLongitud 
	^Longitud newMilimetros: self value + aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:23:15'!
- aLongitud 
	^Longitud newMilimetros: self value - aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 19:58:45'!
= aLongitud 
	^self value = aLongitud value.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:30:18'!
initializeWithCentimetros: anInteger
	milimetros := anInteger * 10.! !

!Longitud methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:30:06'!
initializeWithMetros: anInteger
	milimetros := anInteger * 1000.! !

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

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 19:41:42'!
+ aClass 
	self shouldBeImplemented! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:10:32'!
newCentimetros: anInteger 
	^self new initializeWithCentimetros: anInteger.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:34:20'!
newMetros: anInteger
	^self new initializeWithMetros: anInteger.! !

!Longitud class methodsFor: 'as yet unclassified' stamp: 'AM 5/21/2017 20:20:36'!
newMilimetros: anInteger
	^self new initializeWithMilimetros: anInteger.! !
