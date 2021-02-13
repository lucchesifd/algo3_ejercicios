!classDefinition: #BookStoreTests category: 'TusLibros'!
TestCase subclass: #BookStoreTests
	instanceVariableNames: 'currentStock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:25'!
test01CheckingIfAnAvailableItemIsInStockShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	self assert: (currentStore hasStockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:31'!
test02CheckingIfAnUnavailableItemIsInStockShouldAlsoWork

	| currentStore |
	currentStore := self makeStore.
	
	self deny: (currentStore hasStockOf: 54321).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:41'!
test03RetrievingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	self assert: 5 equals: (currentStore stockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:46'!
test04TheStockOfAnUnavailableItemShouldBeZero

	| currentStore |
	currentStore := self makeStore.
	
	self assert: 0 equals: (currentStore stockOf: 54321).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:56'!
test05ReducingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	currentStore reduceStockOf: 12345 by: 3.
	
	self assert: 2 equals: (currentStore stockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:29:02'!
test06ReducingTheStockOfAnUnavailableItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self should: [ currentStore reduceStockOf: 54321 by: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore noStockErrorMessageFor: 54321) equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:29:07'!
test07ReducingTheStockTooFarShouldAlsoRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self should: [ currentStore reduceStockOf: 12345 by: 7. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore insufficientStockErrorMessageFor: 12345 atQuantity: 7) equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:29:11'!
test08IncreasingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	currentStore addStockOf: 12345 by: 3.
	
	self assert: 8 equals: (currentStore stockOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:29:16'!
test09RetrievingThePriceOfAnExistingItemWorks

	| currentStore |
	currentStore := self makeStore.
	
	self assert: 250 equals: (currentStore priceOf: 12345).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:29:20'!
test10RetrievingThePriceOfAnUnexistingItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self
		should: [ currentStore priceOf: 54321 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore priceNotAvailableErrorFor: 54321) equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:01'!
test11UpdatingThePriceOfAnItemWorks

	| currentStore |
	currentStore := self makeStore.
	
	currentStore updatePriceOf: 12345 to: 500.
	self assert: 500 equals: (currentStore priceOf: 12345).
	
	currentStore updatePriceOf: 54321 to: 100.
	self assert: 100 equals: (currentStore priceOf: 54321).! !


!BookStoreTests methodsFor: 'tests - private' stamp: 'FL 2/11/2021 21:28:10'!
makeStore

	^BookStore withStockFor: (Dictionary with: 12345->5) withPrices: (Dictionary with: 12345->250).! !


!classDefinition: #ShoppingCartTests category: 'TusLibros'!
TestCase subclass: #ShoppingCartTests
	instanceVariableNames: 'testStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!ShoppingCartTests commentStamp: '<historical>' prior: 0!
Hacer tests de contenidos del carrito y tests de si un libro existe...?!


!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:01'!
makeCart

	^ ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:30:16'!
setUp
	
	"A sample store with some items used in the tests"
	testStore := BookStore
		withStockFor: (Dictionary with: 1933988274->999 with: 0321146530->999)
		withPrices: (Dictionary with: 1933988274->250 with: 0321146530->750).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:01'!
test01ANewShoppingCartShouldBeEmpty
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: currentCart isEmpty! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:16'!
test02AddingAnythingToAShoppingCartShouldNotLeaveItEmpty
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	
	self deny: currentCart isEmpty.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:23'!
test03ANewShoppingCartShouldNotHaveAnyContents
	
	| currentCart expectedContents |
	currentCart := self makeCart.
	expectedContents := Dictionary new.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:27'!
test04AShoppingCartShouldKeepTrackOfOneItem
	
	| currentCart expectedContents |
	currentCart := self makeCart.
	expectedContents := Dictionary with: 1933988274->1.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:33'!
test05AShoppingCartShouldKeepTrackOfMoreThanOneItem
	
	| currentCart expectedContents |
	currentCart := self makeCart.
	expectedContents := Dictionary with: 1933988274->1 with: 0321146530->1.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	currentCart addBook: 0321146530 thisManyTimes: 1.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:42'!
test06AddingTheSameItemTwiceToAShoppingCartShouldAddMoreOfThatItem
	
	| currentCart expectedContents |
	currentCart := self makeCart.
	expectedContents := Dictionary with: 1933988274->5.
	
	currentCart addBook: 1933988274 thisManyTimes: 2.
	currentCart addBook: 1933988274 thisManyTimes: 3.
	
	self assert: (currentCart contents = expectedContents).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:48'!
test07AShoppingCartShouldRaiseAnErrorOnInvalidQuantities
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: 1933988274 thisManyTimes: -1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidQuantityErrorMessage equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:54:54'!
test08AShoppingCartShouldRaiseAnErrorOnInvalidBookISBNs
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: 'invalid' thisManyTimes: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidBookISBNErrorMessage equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:00'!
test09AShoppingCartShouldRaiseAnErrorOnValidISBNsNotInStock
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: 12345 thisManyTimes: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: (BookStore noStockErrorMessageFor: 12345) equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:05'!
test10AddingBooksToTheCartShouldRemoveThemFromTheStore
	
	| currentCart expectedStock |
	currentCart := self makeCart.
	
	expectedStock := (testStore stockOf: 1933988274) - 3.
	currentCart addBook: 1933988274 thisManyTimes: 3.
	
	self assert: expectedStock equals: (testStore stockOf: 1933988274).
	self assert: (Dictionary with: 1933988274->3) equals: currentCart contents.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:11'!
test11ResettingAShoppingCartShouldClearContentsAndReturnStock
	
	| currentCart expectedStock originalStock |
	currentCart := self makeCart.
	originalStock := testStore stockOf: 1933988274.
	
	expectedStock := originalStock - 1.
	currentCart addBook: 1933988274 thisManyTimes: 1.
	self assert: expectedStock equals: (testStore stockOf: 1933988274).
	
	currentCart reset.
	self assert: originalStock equals: (testStore stockOf: 1933988274).
	self assert: Dictionary new equals: currentCart contents.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:19'!
test12ANewShoppingCartsTotalPriceShouldBeZero
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: 0 equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:25'!
test13AShoppingCartShouldKeepTrackOfThePriceOfOneItem
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	
	self assert: (testStore priceOf: 1933988274) equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:31'!
test14AShoppingCartShouldKeepTrackOfThePriceOfOneItemManyTimes
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: 1933988274 thisManyTimes: 5.
	
	self assert: (testStore priceOf: 1933988274) * 5 equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:55:36'!
test15AShoppingCartShouldKeepTrackOfThePriceOfMoreThanOneItem
	
	| currentCart expectedPrice |
	currentCart := self makeCart.
	expectedPrice := (testStore priceOf: 1933988274) * 3 + (testStore priceOf: 0321146530).
	
	currentCart addBook: 1933988274 thisManyTimes: 3.
	currentCart addBook: 0321146530 thisManyTimes: 1.
	
	self assert: expectedPrice equals: currentCart totalPrice.! !


!classDefinition: #BookStore category: 'TusLibros'!
Object subclass: #BookStore
	instanceVariableNames: 'currentStock stockDictionary priceDictionary itemPrices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookStore methodsFor: 'initialization' stamp: 'FL 2/11/2021 17:42:57'!
initializeWithStock: aStockDictionary 

	currentStock := aStockDictionary.! !

!BookStore methodsFor: 'initialization' stamp: 'FL 2/11/2021 21:15:10'!
initializeWithStock: aStockDictionary withPrices: aPriceDictionary 

	currentStock := aStockDictionary.
	itemPrices := aPriceDictionary.! !


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


!BookStore methodsFor: 'price' stamp: 'FL 2/11/2021 21:24:09'!
priceOf: aBookISBN 
	
	^itemPrices at: aBookISBN ifAbsent: [self error: (self class priceNotAvailableErrorFor: 54321)].! !

!BookStore methodsFor: 'price' stamp: 'FL 2/11/2021 21:26:56'!
updatePriceOf: aBookISBN to: aPrice
 
	itemPrices at: aBookISBN put: aPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookStore class' category: 'TusLibros'!
BookStore class
	instanceVariableNames: ''!

!BookStore class methodsFor: 'instance creation' stamp: 'FL 2/11/2021 21:14:36'!
withStockFor: aStockDictionary withPrices: aPriceDictionary 

	^self new initializeWithStock: aStockDictionary withPrices: aPriceDictionary.! !


!BookStore class methodsFor: 'error messages' stamp: 'FL 2/11/2021 18:13:12'!
insufficientStockErrorMessageFor: aBookISBN atQuantity: aQuantity 
	
	^'There is not enough stock to retrieve the book ', aBookISBN asString, ' ', aQuantity asString, ' time(s).' ! !

!BookStore class methodsFor: 'error messages' stamp: 'FL 2/11/2021 18:35:37'!
noStockErrorMessageFor: aBookISBN
 
	^'The book ', aBookISBN asString, ' is not in stock.'! !


!BookStore class methodsFor: 'as yet unclassified' stamp: 'FL 2/11/2021 21:21:11'!
priceNotAvailableErrorFor: aBookISBN 
	
	^'Price for book ', aBookISBN asString, ' not found.'! !


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


!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'FL 2/11/2021 21:05:45'!
reset
	
	books keysDo: [:aBookISBN | 
		associatedStore addStockOf: aBookISBN by: (books at: aBookISBN).
		books removeKey: aBookISBN.
	]! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'FL 2/11/2021 21:47:51'!
totalPrice
	
	| total |
	total := 0.
	books keysAndValuesDo: [:aBookISBN :aQuantity |
		total := total + ((associatedStore priceOf: aBookISBN) * aQuantity).
	].
	^total.! !

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
