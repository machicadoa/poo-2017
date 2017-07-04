!classDefinition: #MetaTest category: #MetaProgramacion!
TestCase subclass: #MetaTest
	instanceVariableNames: 'aNewClass aNewSubClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MetaProgramacion'!

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 01:04:12'!
test01cannotDefineAnInstanceVariableWithEmptyName

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
	aNewClass removeFromSystem.! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 01:03:06'!
test02aValidInstanceVariableNameIsAddedAsInstanceVariableInClass
	
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
	
	aNewClass removeFromSystem.
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 01:00:37'!
test03cannotDefineAnInvalidInstanceVariable
	
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
	aNewClass removeFromSystem.! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 00:59:03'!
test04cannotDefineInstanceVariableThatAlreadyExistsInSubClass
	
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
	aNewSubClass removeFromSystem.

	aNewClass removeFromSystem.	
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 00:58:50'!
test05cannotDefineInstanceVariableThatAlreadyExistsInSuperClass
	
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
							
	aNewClass removeFromSystem.

	aNewSuperClass removeFromSystem.	
	! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 00:56:15'!
test06cannotDefineSameInstanceVariableInClass
	
	|variableNames aNewVarName aAddInstVariableInstance aNewClass |
	
	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.
	
	aNewVarName _ 'ab'.

	aAddInstVariableInstance _ AddInstVariable named: aNewVarName in: aNewClass.
	
	aAddInstVariableInstance  apply.
	
	variableNames _ aNewClass instVarNames. 
	
	self should: [AddInstVariable named: aNewVarName in: aNewClass]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :msg | self assert: msg messageText equals: 'Variable name is already defined'.
								self assert: variableNames = aNewClass instVarNames.
								].
	aNewClass removeFromSystem.! !

!MetaTest methodsFor: 'as yet unclassified' stamp: 'AM 7/4/2017 00:53:22'!
test07newVarIsDefinesAsTempThenWarning
	
	| aNewMethod aNewVarName aAddInstVariableInstance aNewClass |
	
	aNewClass  _  Object subclass: #NuevaClase
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'MetaProgramacion'.
	
	aNewMethod _ 'printPepe
|name|
name _ ''Pepe''.
^''hello '' append: name.'.

	aNewClass compile: aNewMethod.
	
	aNewVarName _ 'name'.

	self should: [aAddInstVariableInstance _ AddInstVariable named: aNewVarName in: aNewClass.]
		 raise: Warning
		 withExceptionDo:  [ :wng |
			self assert: wng messageText equals: 'Variable name is included in some of the methods within this class as tempVariables'.
			wng resume.
								].
							
	aAddInstVariableInstance apply.
	self assert: (aNewClass instVarNames includes: aNewVarName).
	
	aNewClass removeFromSystem.! !


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

!AddInstVariable class methodsFor: 'instance creation' stamp: 'AM 7/4/2017 01:09:41'!
named: aVariableName in: aClass 
	
	|variableNames|
	
	variableNames _ Scanner new scanFieldNames: aVariableName.
	
	(variableNames isEmpty ) ifTrue: [self error: 'Variable name is empty'].
	
	(aClass instVarNames includes: aVariableName ) ifTrue: [self error: 'Variable name is already defined'].
	
	(aClass allSubclasses anySatisfy: [:each | each instVarNames includes: aVariableName]  )  ifTrue: [self error: 'Variable name is defined in subclass'].
	
	(aClass superclass  instVarNames includes: aVariableName  )  ifTrue: [self error: 'Variable name is defined in superClass'].
	
	(variableNames size = 1 and: [(variableNames at: 1) = aVariableName]) ifFalse: [self error: 'Variable name is invalid'].
	
	(aClass methodDict values anySatisfy: [:each| each methodNode tempNames includes: aVariableName]) ifTrue: [^Warning new signal: 'Variable name is included in some of the methods within this class as tempVariables'].
	
	^self new initializeWithName: aVariableName andClass: aClass .! !
