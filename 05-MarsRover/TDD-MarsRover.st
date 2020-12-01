!classDefinition: #MarsRoverTests category: 'TDD-MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD-MarsRover'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FL 11/30/2020 21:53:42'!
test01

	"f: forward, b: backward, l: left, r: right"
	
	| marsRoverActual |
	marsRoverActual := MarsRover inPosition: 0@0 andDirection: 'N'.
	
	self assert: marsRoverActual position = (0@0).! !


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


!MarsRover methodsFor: 'as yet unclassified' stamp: 'FL 11/30/2020 21:53:42'!
position
	
	^position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'TDD-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FL 11/30/2020 21:50:10'!
inPosition: aStartingPosition andDirection: aStartingCardinalDirection 

	^self new initializeInPosition: aStartingPosition andDirection: aStartingCardinalDirection ! !
