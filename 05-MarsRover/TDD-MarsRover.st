!classDefinition: #MarsRoverTests category: 'TDD-MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:10:48'!
test04SendingOneTurnRightInstructionFacingNorthShouldTurnEast

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	marsRoverActual executeCommands: 'r'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'E')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:11:20'!
test05SendingOneTurnLeftInstructionFacingNorthShouldTurnWest

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	marsRoverActual executeCommands: 'l'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'W')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:12:00'!
test06SendingOneTurnLeftInstructionFacingSouthShouldTurnEast

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'S'.
	marsRoverActual executeCommands: 'l'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'E')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:14:17'!
test07SendingOneTurnLeftInstructionFacingEastShouldTurnNorth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'E'.
	marsRoverActual executeCommands: 'l'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'N')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:14:24'!
test08SendingOneTurnLeftInstructionFacingWestShouldTurnSouth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'W'.
	marsRoverActual executeCommands: 'l'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'S')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:15:56'!
test09SendingOneTurnRightInstructionFacingSouthShouldTurnWest

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'S'.
	marsRoverActual executeCommands: 'r'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'W')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:16:24'!
test10SendingOneTurnRightInstructionFacingWestShouldTurnNorth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'W'.
	marsRoverActual executeCommands: 'r'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'N')
! !

!MarsRoverTests methodsFor: 'rotation tests' stamp: 'FL 12/7/2020 17:17:28'!
test11SendingOneTurnRightInstructionFacingEastShouldTurnSouth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'E'.
	marsRoverActual executeCommands: 'r'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'S')
! !


!MarsRoverTests methodsFor: 'other tests' stamp: 'FL 12/7/2020 17:06:34'!
test01SendingNoInstructionsShouldDoNothing

	"f: forward, b: backward, l: left, r: right"
	
	| marsRoverActual |
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	
	self assert: (marsRoverActual isInPosition: 0@0 andIsFacing: 'N')
! !

!MarsRoverTests methodsFor: 'other tests' stamp: 'FL 12/7/2020 17:20:44'!
test18MoreThanOneInstructionCanBeSent

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	marsRoverActual executeCommands: 'fff'.
	
	self assert: (marsRoverActual isInPosition: 0@3 andIsFacing: 'N')
! !

!MarsRoverTests methodsFor: 'other tests' stamp: 'FL 12/7/2020 17:21:03'!
test19ItShouldStopProcessingCommandsOnAnInvalidInstruction

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	marsRoverActual executeCommands: 'fffzfff'.
	
	self assert: (marsRoverActual isInPosition: 0@3 andIsFacing: 'N')
! !


!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:10:02'!
test02SendingOneForwardInstructionFacingNorthShouldMoveNorth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	marsRoverActual executeCommands: 'f'.
	
	self assert: (marsRoverActual isInPosition: 0@1 andIsFacing: 'N')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:09:51'!
test03SendingOneBackwardInstructionFacingNorthShouldMoveSouth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	marsRoverActual executeCommands: 'b'.
	
	self assert: (marsRoverActual isInPosition: 0@-1 andIsFacing: 'N')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:18:11'!
test12SendingOneForwardInstructionFacingEastShouldMoveEast

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'E'.
	marsRoverActual executeCommands: 'f'.
	
	self assert: (marsRoverActual isInPosition: 1@0 andIsFacing: 'E')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:18:40'!
test13SendingOneForwardInstructionFacingSouthShouldMoveSouth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'S'.
	marsRoverActual executeCommands: 'f'.
	
	self assert: (marsRoverActual isInPosition: 0@-1 andIsFacing: 'S')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:19:07'!
test14SendingOneForwardInstructionFacingWestShouldMoveWest

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'W'.
	marsRoverActual executeCommands: 'f'.
	
	self assert: (marsRoverActual isInPosition: -1@0 andIsFacing: 'W')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:19:42'!
test15SendingOneBackwardInstructionFacingEastShouldMoveWest

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'E'.
	marsRoverActual executeCommands: 'b'.
	
	self assert: (marsRoverActual isInPosition: -1@0 andIsFacing: 'E')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:20:03'!
test16SendingOneBackwardInstructionFacingSouthShouldMoveNorth

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'S'.
	marsRoverActual executeCommands: 'b'.
	
	self assert: (marsRoverActual isInPosition: 0@1 andIsFacing: 'S')
! !

!MarsRoverTests methodsFor: 'movement tests' stamp: 'FL 12/7/2020 17:20:27'!
test17SendingOneBackwardInstructionFacingWestShouldMoveEast

	"f: forward, b: backward, l: left, r: right"

	| marsRoverActual |
	
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'W'.
	marsRoverActual executeCommands: 'b'.
	
	self assert: (marsRoverActual isInPosition: 1@0 andIsFacing: 'W')
! !


!classDefinition: #MarsRover category: 'TDD-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'FL 11/30/2020 21:51:13'!
initializeInPosition: aStartingPosition andDirection: aStartingCardinalDirection 

	position := aStartingPosition.
	cardinalDirection := aStartingCardinalDirection.! !


!MarsRover methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:36:44'!
executeCommands: commandsToRun 

	| listOfCommands |
	listOfCommands := self gatherCommands: commandsToRun.
	
	listOfCommands do: [ :aCommand |
		(aCommand isKindOf: InvalidCommand) ifTrue: [^false.].
		aCommand doInstructionWith: self.
	].
	^true! !


!MarsRover methodsFor: 'command execution - private' stamp: 'FL 12/7/2020 17:53:30'!
cardinalDirection: aCardinalDirection 

	"Should only be used by command objects!!"
	cardinalDirection := aCardinalDirection! !

!MarsRover methodsFor: 'command execution - private' stamp: 'FL 12/7/2020 17:35:08'!
gatherCommands: aStringOfCommands

	| arrayOfInstructions |
	arrayOfInstructions := OrderedCollection new.
	
	aStringOfCommands asArray do: [ :aCommand |
		| correctInstruction |
		correctInstruction := MarsRoverCommand forIdentifier: aCommand asString.
		arrayOfInstructions add: correctInstruction.
	].

	^arrayOfInstructions.! !

!MarsRover methodsFor: 'command execution - private' stamp: 'FL 12/7/2020 17:53:34'!
position: aPosition 

	"Should only be used by command objects!!"
	position := aPosition.! !


!MarsRover methodsFor: 'testing' stamp: 'CC 12/3/2020 17:50:17'!
isInPosition: aPossibleLocation andIsFacing: aPossibleCardinalDirection

	^self position = aPossibleLocation and: [ self cardinalDirection = aPossibleCardinalDirection ]! !


!MarsRover methodsFor: 'testing - private' stamp: 'CC 12/3/2020 17:49:28'!
cardinalDirection
	
	^cardinalDirection! !

!MarsRover methodsFor: 'testing - private' stamp: 'FL 11/30/2020 21:53:42'!
position
	
	^position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'TDD-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FL 11/30/2020 21:50:10'!
inPosition: aStartingPosition andDirection: aStartingCardinalDirection 

	^self new initializeInPosition: aStartingPosition andDirection: aStartingCardinalDirection ! !


!classDefinition: #MarsRoverCommand category: 'TDD-MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!MarsRoverCommand methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:03:27'!
doInstructionWith: aMarsRover 

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'TDD-MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'FL 12/7/2020 17:01:56'!
forIdentifier: anIdentifier 

	| anInstructionClass |
	anInstructionClass := InvalidCommand.
	self allSubclassesDo: [ :aSubclass |
		(aSubclass isIdentifiedBy: anIdentifier) ifTrue: [ anInstructionClass := aSubclass ].
	].
	^anInstructionClass new.! !


!MarsRoverCommand class methodsFor: 'testing' stamp: 'FL 12/7/2020 17:44:25'!
isIdentifiedBy: anIdentifier
 
	self subclassResponsibility.! !


!classDefinition: #BackwardCommand category: 'TDD-MarsRover'!
MarsRoverCommand subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!BackwardCommand methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:38:18'!
doInstructionWith: aMarsRover 

	| currentPosition currentCardinalDirection |
	currentPosition := aMarsRover position.
	currentCardinalDirection := aMarsRover cardinalDirection.
	
	aMarsRover position: currentPosition + (self class backwardPositions at: currentCardinalDirection)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'TDD-MarsRover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'testing' stamp: 'FL 12/7/2020 16:47:01'!
isIdentifiedBy: anIdentifier
 
	^anIdentifier = 'b'! !


!BackwardCommand class methodsFor: 'command constants' stamp: 'FL 12/7/2020 17:42:18'!
backwardPositions

	^Dictionary new
		at: 'N' put: 0@-1;
		at: 'E' put: -1@0;
		at: 'S' put: 0@1;
		at: 'W' put: 1@0;
		yourself.! !


!classDefinition: #ForwardCommand category: 'TDD-MarsRover'!
MarsRoverCommand subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!ForwardCommand methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:38:29'!
doInstructionWith: aMarsRover 
	
	| currentPosition currentCardinalDirection |
	currentPosition := aMarsRover position.
	currentCardinalDirection := aMarsRover cardinalDirection.
	
	aMarsRover position: currentPosition + (self class forwardPositions at: currentCardinalDirection)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'TDD-MarsRover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'testing' stamp: 'FL 12/7/2020 16:46:47'!
isIdentifiedBy: anIdentifier
 
	^anIdentifier = 'f'! !


!ForwardCommand class methodsFor: 'command constants' stamp: 'FL 12/7/2020 17:39:43'!
forwardPositions
	^Dictionary new
		at: 'N' put: 0@1;
		at: 'E' put: 1@0;
		at: 'S' put: 0@-1;
		at: 'W' put: -1@0;
		yourself.! !


!classDefinition: #InvalidCommand category: 'TDD-MarsRover'!
MarsRoverCommand subclass: #InvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!InvalidCommand methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:38:40'!
doInstructionWith: aMarsRover 
	
	"An invalid instruction does nothing."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidCommand class' category: 'TDD-MarsRover'!
InvalidCommand class
	instanceVariableNames: ''!

!InvalidCommand class methodsFor: 'testing' stamp: 'FL 12/7/2020 16:49:45'!
isIdentifiedBy: anIdentifier
 
	^false! !


!classDefinition: #TurnLeftCommand category: 'TDD-MarsRover'!
MarsRoverCommand subclass: #TurnLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!TurnLeftCommand methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:38:59'!
doInstructionWith: aMarsRover 

	| currentCardinalDirection |
	currentCardinalDirection := aMarsRover cardinalDirection.
	
	aMarsRover cardinalDirection: (self class leftRotationDirections at: currentCardinalDirection)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnLeftCommand class' category: 'TDD-MarsRover'!
TurnLeftCommand class
	instanceVariableNames: ''!

!TurnLeftCommand class methodsFor: 'testing' stamp: 'FL 12/7/2020 16:47:46'!
isIdentifiedBy: anIdentifier
 
	^anIdentifier = 'l'! !


!TurnLeftCommand class methodsFor: 'command constants' stamp: 'FL 12/7/2020 17:41:10'!
leftRotationDirections

	^Dictionary new
		at: 'N' put: 'W';
		at: 'E' put: 'N';
		at: 'S' put: 'E';
		at: 'W' put: 'S';
		yourself! !


!classDefinition: #TurnRightCommand category: 'TDD-MarsRover'!
MarsRoverCommand subclass: #TurnRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!TurnRightCommand methodsFor: 'command execution' stamp: 'FL 12/7/2020 17:39:09'!
doInstructionWith: aMarsRover 

	| currentCardinalDirection |
	currentCardinalDirection := aMarsRover cardinalDirection.
	
	aMarsRover cardinalDirection: (self class rightRotationDirections at: currentCardinalDirection)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnRightCommand class' category: 'TDD-MarsRover'!
TurnRightCommand class
	instanceVariableNames: ''!

!TurnRightCommand class methodsFor: 'testing' stamp: 'FL 12/7/2020 16:47:11'!
isIdentifiedBy: anIdentifier
 
	^anIdentifier = 'r'! !


!TurnRightCommand class methodsFor: 'command constants' stamp: 'FL 12/7/2020 17:41:42'!
rightRotationDirections
	
	^Dictionary new
		at: 'N' put: 'E';
		at: 'E' put: 'S';
		at: 'S' put: 'W';
		at: 'W' put: 'N';
		yourself.! !
