!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 20:59:22'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	self theCode: [customerBook addCustomerNamed: 'John Lennon'] shouldRunInLessThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:01:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self theCode: [customerBook removeCustomerNamed: paulMcCartney] shouldRunInLessThan: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:29:25'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self theCode: [ customerBook addCustomerNamed: ''. self fail. ]
		shouldCause: Error
		withTheConditions: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:16:41'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self theCode: [ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ]
		shouldCause: NotFound
		withTheConditions: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:23:44'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self theCustomerBook: customerBook
		shouldHaveThisManyCustomers: 1
		andActiveCustomers: 0
		andSuspendedCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:24:51'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self theCustomerBookShouldHaveNoCustomers: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:36:33'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self verifyThat: 'Ringo Star' cannotBeSuspendedOn: customerBook andShouldInclude: johnLennon.
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'FL 11/2/2020 21:36:43'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self verifyThat: johnLennon cannotBeSuspendedOn: customerBook andShouldInclude: johnLennon.
! !


!CustomerBookTest methodsFor: 'test helpers' stamp: 'FL 11/2/2020 21:14:57'!
theCode: errorCausingCode shouldCause: aClassIdentifier withTheConditions: conditionCode

	errorCausingCode
		on: aClassIdentifier 
		do: conditionCode.! !

!CustomerBookTest methodsFor: 'test helpers' stamp: 'FL 11/2/2020 21:01:32'!
theCode: someCode shouldRunInLessThan: aTime

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	someCode value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTime.
	
! !

!CustomerBookTest methodsFor: 'test helpers' stamp: 'FL 11/2/2020 21:22:44'!
theCustomerBook: customerBook shouldHaveThisManyCustomers: totalCustomers andActiveCustomers: activeCustomers andSuspendedCustomers: suspendedCustomers
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.
	

	
! !

!CustomerBookTest methodsFor: 'test helpers' stamp: 'FL 11/2/2020 21:25:40'!
theCustomerBookShouldHaveNoCustomers: aCustomerBook 
	self theCustomerBook: aCustomerBook
		shouldHaveThisManyCustomers: 0
		andActiveCustomers: 0
		andSuspendedCustomers: 0.! !

!CustomerBookTest methodsFor: 'test helpers' stamp: 'FL 11/2/2020 21:36:12'!
verifyThat: aPerson cannotBeSuspendedOn: aCustomerBook andShouldInclude: anIncludedPerson
	self theCode: [ aCustomerBook suspendCustomerNamed: aPerson. self fail ]
		shouldCause: CantSuspend 
		withTheConditions: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: anIncludedPerson) ]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'FL 11/2/2020 21:40:54'!
initialize

	active := OrderedCollection new.
	suspended := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'FL 11/2/2020 21:40:13'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FL 11/2/2020 21:58:34'!
removeCustomerNamed: aName 
	
	^active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [
			NotFound signal. ]].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'FL 11/3/2020 18:21:00'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	active remove: aName.
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'FL 11/3/2020 18:19:52'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
