!classDefinition: #MetaTest category: #MetaProgramacion!
TestCase subclass: #MetaTest
	instanceVariableNames: 'aNewClass aNewSubClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MetaProgramacion'!

!MetaTest methodsFor: 'as yet unclassified' stamp: 'RC 6/29/2017 20:59:14'!
test01

	|aEmptyInstanceVariableName variableNames aNewClass|

	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.

	aEmptyInstanceVariableName _ ''.
	
	variableNames _ aNewClass instVarNames. 
	

	self should: [AddInstVariable named: aEmptyInstanceVariableName in: aNewClass ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :msg | self assert: msg messageText equals: 'Variable name is empty'.
								self assert: variableNames = aNewClass instVarNames.
			].
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'RC 6/29/2017 21:03:56'!
test02
	
	|anAddInstVariable aNewVarName aNewClass|
						
	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.					
						
	aNewVarName _ 'a' .
	
	anAddInstVariable _ AddInstVariable named: aNewVarName  in: aNewClass.
	
	anAddInstVariable  apply.

	self assert: (aNewClass instVarNames includes: aNewVarName).
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'RC 6/29/2017 21:04:20'!
test03
	
	|variableNames aNewVarName aNewClass|
	
	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.		
	
	variableNames _ aNewClass instVarNames. 
	
	aNewVarName _ 'a b'.

	self should: [AddInstVariable named: aNewVarName in: aNewClass]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :msg | self assert: msg messageText equals: 'Variable name is invalid'.
								self assert: variableNames = aNewClass instVarNames.
								].
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'RC 6/29/2017 21:05:53'!
test04
	
	|variableNames aNewVarName aAddInstVariableInstance aNewClass aNewSubClass|
	
	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.
					
	aNewSubClass _ aNewClass subclass: #NuevaSubClase
							instanceVariableNames: ''
							classVariableNames: ''
							poolDictionaries: ''
							category: 'MetaProgramacion'.
	
	variableNames _ aNewClass instVarNames. 
	
	aNewVarName _ 'ab'.

	aAddInstVariableInstance _ AddInstVariable named: aNewVarName in: aNewSubClass.
	
	aAddInstVariableInstance  apply.
	
	self should: [AddInstVariable named: aNewVarName in: aNewClass]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :msg | self assert: msg messageText equals: 'Variable name is defined in subclass'.
								self assert: variableNames = aNewClass instVarNames.
								].
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'RC 6/29/2017 21:21:27'!
test05
	
	|variableNames aNewVarName aAddInstVariableInstance aNewClass aNewSuperClass|
	
	aNewSuperClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.
					
	aNewClass _ aNewSuperClass subclass: #NuevaSubClase
							instanceVariableNames: ''
							classVariableNames: ''
							poolDictionaries: ''
							category: 'MetaProgramacion'.
	
	variableNames _ aNewClass instVarNames. 
	
	aNewVarName _ 'ab'.

	aAddInstVariableInstance _ AddInstVariable named: aNewVarName in: aNewSuperClass.
	
	aAddInstVariableInstance  apply.
	
	self should: [AddInstVariable named: aNewVarName in: aNewClass]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :msg | self assert: msg messageText equals: 'Variable name is defined in superClass'.
								self assert: variableNames = aNewClass instVarNames.
								].
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'RC 6/29/2017 21:24:01'!
test06
	
	|variableNames aNewVarName aAddInstVariableInstance aNewClass |
	
	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.
					
	variableNames _ aNewClass instVarNames. 
	
	aNewVarName _ 'ab'.

	aAddInstVariableInstance _ AddInstVariable named: aNewVarName in: aNewClass.
	
	aAddInstVariableInstance  apply.
	
	self should: [AddInstVariable named: aNewVarName in: aNewClass]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :msg | self assert: msg messageText equals: 'Variable name is already defined'.
								self assert: variableNames = aNewClass instVarNames.
								].
	! !


!classDefinition: #AddInstVariable category: #MetaProgramacion!
Object subclass: #AddInstVariable
	instanceVariableNames: 'variableName class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MetaProgramacion'!

!AddInstVariable methodsFor: 'Initialize' stamp: 'RC 6/29/2017 20:41:33'!
initializeWithName: aVariableName andClass: aClass 
	
	variableName _ aVariableName .
	
	class _ aClass .! !


!AddInstVariable methodsFor: 'evaluating' stamp: 'RC 6/29/2017 20:07:57'!
apply
	
	class addInstVarName: variableName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddInstVariable class' category: #MetaProgramacion!
AddInstVariable class
	instanceVariableNames: ''!

!AddInstVariable class methodsFor: 'instance creation' stamp: 'RC 6/29/2017 21:26:25'!
named: aVariableName in: aClass 
	
	|variableNames|
	
	(aVariableName isEmpty ) ifTrue: [self error: 'Variable name is empty'].
	
	variableNames _ Scanner new scanFieldNames: aVariableName.
	
	(self instVarNames includes: aVariableName ) ifTrue: [self error: 'Variable name is already defined'].
	
	(aClass allSubclasses anySatisfy: [:each | each instVarNames includes: aVariableName]  )  ifTrue: [self error: 'Variable name is defined in subclass'].
	
	(aClass allSuperclasses anySatisfy: [:each | each instVarNames includes: aVariableName]  )  ifTrue: [self error: 'Variable name is defined in superClass'].
	
	(variableNames size = 1 and: [(variableNames at: 1) = aVariableName]) ifFalse: [self error: 'Variable name is invalid'].
	
	^self new initializeWithName: aVariableName andClass: aClass .! !


!classDefinition: #NuevaClase category: #MetaProgramacion!
Object subclass: #NuevaClase
	instanceVariableNames: 'ab'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MetaProgramacion'!


!classDefinition: #NuevaSubClase category: #MetaProgramacion!
NuevaClase subclass: #NuevaSubClase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MetaProgramacion'!
