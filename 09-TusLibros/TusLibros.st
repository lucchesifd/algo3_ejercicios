!classDefinition: #BookStoreTests category: 'TusLibros'!
TestCase subclass: #BookStoreTests
	instanceVariableNames: 'currentStock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:30:40'!
test01CheckingIfAnAvailableItemIsInStockShouldWork

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->1).
	
	self assert: (currentStore hasStockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:31:01'!
test02CheckingIfAnUnavailableItemIsInStockShouldAlsoWork

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->1).
	
	self deny: (currentStore hasStockOf: 54321).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:31:39'!
test03RetrievingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->1).
	
	self assert: 1 equals: (currentStore stockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:32:03'!
test04TheStockOfAnUnavailableItemShouldBeZero

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->1).
	
	self assert: 0 equals: (currentStore stockOf: 54321).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:32:28'!
test05ReducingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->5).
	
	currentStore reduceStockOf: 12345 by: 3.
	
	self assert: 2 equals: (currentStore stockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:35:55'!
test06ReducingTheStockOfAnUnavailableItemShouldRaiseAnError

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->5).
	
	self should: [ currentStore reduceStockOf: 54321 by: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore noStockErrorMessageFor: 54321) equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:41:40'!
test07ReducingTheStockTooFarShouldAlsoRaiseAnError

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->5).
	
	self should: [ currentStore reduceStockOf: 12345 by: 7. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore insufficientStockErrorMessageFor: 12345 atQuantity: 7) equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:34:03'!
test08IncreasingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := BookStore withStockFor: (Dictionary with: 12345->5).
	
	currentStore addStockOf: 12345 by: 3.
	
	self assert: 8 equals: (currentStore stockOf: 12345).! !


!classDefinition: #ShoppingCartTests category: 'TusLibros'!
TestCase subclass: #ShoppingCartTests
	instanceVariableNames: 'testStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!ShoppingCartTests commentStamp: '<historical>' prior: 0!
Hacer tests de contenidos del carrito y tests de si un libro existe...?!


!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:20:53'!
setUp
	
	"A sample store with some items used in the tests"
	testStore := BookStore withStockFor: (Dictionary with: 1933988274->999 with: 0321146530->999).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:47:32'!
test01ANewShoppingCartShouldBeEmpty
	
	| currentCart |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	
	self assert: currentCart isEmpty! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:47:40'!
test02AddingAnythingToAShoppingCartShouldNotLeaveItEmpty
	
	| currentCart |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	
	self deny: currentCart isEmpty.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:47:53'!
test03ANewShoppingCartShouldNotHaveAnyContents
	
	| currentCart expectedContents |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	expectedContents := Dictionary new.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:48:05'!
test04AShoppingCartShouldKeepTrackOfOneItem
	
	| currentCart expectedContents |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	expectedContents := Dictionary with: 1933988274->1.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:48:11'!
test05AShoppingCartShouldKeepTrackOfMoreThanOneItem
	
	| currentCart expectedContents |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	expectedContents := Dictionary with: 1933988274->1 with: 0321146530->1.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	currentCart addBook: 0321146530 thisManyTimes: 1.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:48:18'!
test06AddingTheSameItemTwiceToAShoppingCartShouldAddMoreOfThatItem
	
	| currentCart expectedContents |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	expectedContents := Dictionary with: 1933988274->5.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	currentCart addBook: 1933988274 thisManyTimes: 4.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:48:25'!
test07AShoppingCartShouldRaiseAnErrorOnInvalidQuantities
	
	| currentCart |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	
	self
		should: [ currentCart addBook: 1933988274 thisManyTimes: -1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidQuantityErrorMessage equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 17:48:30'!
test08AShoppingCartShouldRaiseAnErrorOnInvalidBookISBNs
	
	| currentCart |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	
	self
		should: [ currentCart addBook: 'invalid' thisManyTimes: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidBookISBNErrorMessage equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:38:52'!
test09AShoppingCartShouldRaiseAnErrorOnValidISBNsNotInStock
	
	| currentCart |
	currentCart := ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'.
	
	self
		should: [ currentCart addBook: 12345 thisManyTimes: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore noStockErrorMessageFor: 12345) equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 18:40:22'!
test10AddingBooksToTheCartShouldRemoveThemFromTheStore
	
	| currentCart separateTestStore |
	separateTestStore := BookStore withStockFor: (Dictionary with: 12345->5).
	currentCart := ShoppingCart forStore: separateTestStore forClientId: 1 withPassword: 'TEST'.
	
	currentCart addBook: 12345 thisManyTimes: 3.
	self assert: 2 equals: (separateTestStore stockOf: 12345).
	self assert: (Dictionary with: 12345->3) equals: currentCart contents.! !


!classDefinition: #BookStore category: 'TusLibros'!
Object subclass: #BookStore
	instanceVariableNames: 'currentStock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookStore methodsFor: 'initialization' stamp: 'FL 2/11/2021 17:42:57'!
initializeWithStock: aStockDictionary 

	currentStock := aStockDictionary.! !


!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 18:16:31'!
addStockOf: aBookISBN by: aQuantity
 
	self reduceStockOf: aBookISBN by: aQuantity negated.! !

!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 17:59:18'!
hasStockOf: aBookISBN 
	
	^(self stockOf: aBookISBN) strictlyPositive.! !

!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 18:38:15'!
reduceStockOf: aBookISBN by: aQuantity 
	
	| newStock |
	(self hasStockOf: aBookISBN) ifFalse: [self error: (self class noStockErrorMessageFor: aBookISBN)].
	
	newStock := (self stockOf: aBookISBN) - aQuantity.
	newStock positive ifFalse: [self error: (self class insufficientStockErrorMessageFor: aBookISBN atQuantity: aQuantity)].
	
	currentStock at: aBookISBN put: newStock.! !

!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 17:55:41'!
stockOf: aBookISBN 
	
	^currentStock at: aBookISBN ifAbsent: 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookStore class' category: 'TusLibros'!
BookStore class
	instanceVariableNames: ''!

!BookStore class methodsFor: 'instance creation' stamp: 'FL 2/11/2021 17:41:18'!
withStockFor: aStockDictionary 

	^self new initializeWithStock: aStockDictionary ! !


!BookStore class methodsFor: 'error messages' stamp: 'FL 2/11/2021 18:13:12'!
insufficientStockErrorMessageFor: aBookISBN atQuantity: aQuantity 
	
	^'There is not enough stock to retrieve the book ', aBookISBN asString, ' ', aQuantity asString, ' time(s).' ! !

!BookStore class methodsFor: 'error messages' stamp: 'FL 2/11/2021 18:35:37'!
noStockErrorMessageFor: aBookISBN
 
	^'The book ', aBookISBN asString, ' is not in stock.'! !


!classDefinition: #ShoppingCart category: 'TusLibros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books associatedStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!ShoppingCart commentStamp: '<historical>' prior: 0!
Nota: modelo los ISBN como numeros, por ahora.!


!ShoppingCart methodsFor: 'initialization' stamp: 'FL 2/11/2021 17:45:19'!
initializeForStore: aStore

	books := Dictionary new.
	associatedStore := aStore.! !


!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/11/2021 18:22:25'!
addBook: aBookISBN thisManyTimes: aQuantity 
	
	| newQuantity |
	
	(aQuantity positive) ifFalse: [self error: self class invalidQuantityErrorMessage].
	(aBookISBN isKindOf: Integer) ifFalse: [self error: self class invalidBookISBNErrorMessage].
	
	associatedStore reduceStockOf: aBookISBN by: aQuantity.
	newQuantity := (books at: aBookISBN ifAbsent: 0) + aQuantity.
	
	books at: aBookISBN put: newQuantity.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/8/2021 22:00:25'!
contents
	
	^books! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/9/2021 16:21:55'!
isEmpty
	
	^books isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'FL 2/11/2021 17:44:33'!
forStore: aStore forClientId: anId withPassword: aPassword

	"For now we're assuming all IDs and Passwords are valid."
	^self new initializeForStore: aStore.! !


!ShoppingCart class methodsFor: 'error messages' stamp: 'FL 2/9/2021 16:51:25'!
invalidBookISBNErrorMessage
	
	^'Invalid Book ISBN.'! !

!ShoppingCart class methodsFor: 'error messages' stamp: 'FL 2/9/2021 16:50:15'!
invalidQuantityErrorMessage
	
	^'Invalid quantity, should be 1 or greater.'! !
