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

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:24:12'!
test06ReducingTheStockOfAnUnavailableItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self should: [ currentStore reduceStockOf: 54321 by: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore noStockErrorMessage equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:24:20'!
test07ReducingTheStockTooFarShouldAlsoRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self should: [ currentStore reduceStockOf: 12345 by: 7. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore insufficientStockErrorMessage equals: anError messageText.
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

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:24:27'!
test10RetrievingThePriceOfAnUnexistingItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self
		should: [ currentStore priceOf: 54321 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore priceNotAvailableError equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/11/2021 21:28:01'!
test11UpdatingThePriceOfAnItemWorks

	| currentStore |
	currentStore := self makeStore.
	
	currentStore updatePriceOf: 12345 to: 500.
	self assert: 500 equals: (currentStore priceOf: 12345).
	
	currentStore updatePriceOf: 54321 to: 100.
	self assert: 100 equals: (currentStore priceOf: 54321).! !


!BookStoreTests methodsFor: 'tests - private' stamp: 'FL 2/16/2021 17:33:24'!
makeStore

	^BookStore forMerchant: MerchantFake withStockFor: (Dictionary with: 12345->5) withPrices: (Dictionary with: 12345->250).! !


!classDefinition: #MerchantAndCheckoutTests category: 'TusLibros'!
TestCase subclass: #MerchantAndCheckoutTests
	instanceVariableNames: 'bookPrice bookId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!MerchantAndCheckoutTests commentStamp: '<historical>' prior: 0!
TO-DO:
	- Añadir tests de verificacion de formateo de los numeros!


!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/16/2021 17:05:39'!
setUp

	bookPrice := 100.
	bookId := 365563.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 17:37:39'!
test01ABasicCheckoutShouldWork

	| currentCart currentStore expectedTransaction |
	currentStore := self makeStore.
	currentCart := ShoppingCart forStore: currentStore forClientId: 1 withPassword: 'TEST'.
	expectedTransaction := OrderedCollection with: bookPrice * 5.
	
	currentCart addBook: bookId thisManyTimes: 5.
	
	currentCart checkoutWithCardNumber: '1234123412341234' withExpirationDate: '122100' withCardOwner: 'TEST CARD'.
	
	self assert: expectedTransaction equals: currentStore transactionsMade.
	self assert: Dictionary new equals: currentCart contents.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:04:19'!
test02CheckingOutAnEmptyCartShouldRaiseAnError

	| currentCart currentStore |
	currentStore := self makeStore.
	currentCart := ShoppingCart forStore: currentStore forClientId: 1 withPassword: 'TEST'.
	
	self
		should: [currentCart checkoutWithCardNumber: '1234123412341234' withExpirationDate: '122100' withCardOwner: 'TEST CARD'.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: ShoppingCart emptyCartCheckoutErrorMessage equals: anError messageText.
		].
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:58'!
test03ATestTransactionTo0000000000000000ShouldFail
	
	self assertCharging: '100.00' toCardNumber: '0000000000000000' withExpirationDate: '122100' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake transactionFailedErrorMessage.! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:58'!
test04CreditCardNumbersThatArentSixteenDigitsAreInvalid

	self assertCharging: '100.00' toCardNumber: '123456789' withExpirationDate: '122100' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidCardNumberErrorMessage.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:57'!
test05CreditCardNumbersThatHaveNonNumericDigitsAreInvalid

	self assertCharging: '100.00' toCardNumber: '1234abcd1234abcd' withExpirationDate: '122100' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidCardNumberErrorMessage.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:58'!
test06ExpirationDatesThatArentSixDigitsAreInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '1234' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidExpirationDateErrorMessage.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:58'!
test07ExpirationDatesThatHaveNonNumericDigitsAreInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '12abcd' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidExpirationDateErrorMessage.! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:57'!
test08ExpirationMonthsThatAreAboveTwelveAreInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '232100' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidExpirationDateMonthErrorMessage.! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:57'!
test09ExpirationMonthZeroIsAlsoInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '002100' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidExpirationDateMonthErrorMessage.! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:57'!
test10ExpirationYearsBelow1900AreInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '111899' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake invalidExpirationDateYearErrorMessage.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:57'!
test11AnAlreadyExpiredCreditCardIsInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '052010' withCardOwner: 'TEST CARD'
		raisesTheErrorMessage: MerchantFake cardAlreadyExpiredErrorMessage.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:57'!
test12CardOwnerNamesThatAreEmptyAreInvalid

	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '122100' withCardOwner: ''
		raisesTheErrorMessage: MerchantFake invalidCardOwnerErrorMessage.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:33:58'!
test13CardOwnerNamesThatAreLongerThanThirtyCharactersAreAlsoInvalid
	
	| invalidLongName |
	invalidLongName := '1234567890123456789012345678901234567890'.
	
	self assertCharging: '100.00' toCardNumber: '1234123412341234' withExpirationDate: '122100' withCardOwner: invalidLongName
		raisesTheErrorMessage: MerchantFake invalidCardOwnerErrorMessage.
	! !


!MerchantAndCheckoutTests methodsFor: 'tests - private' stamp: 'FL 2/18/2021 18:33:57'!
assertCharging: anAmount toCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner raisesTheErrorMessage: anErrorMessage

	self
		should: [MerchantFake chargeAmount: anAmount toCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anErrorMessage equals: anError messageText.].
	! !

!MerchantAndCheckoutTests methodsFor: 'tests - private' stamp: 'FL 2/16/2021 17:32:57'!
makeStore

	^ BookStore forMerchant: MerchantFake withStockFor: (Dictionary with: bookId->100) withPrices: (Dictionary with: bookId->bookPrice).
	! !


!classDefinition: #ShoppingCartTests category: 'TusLibros'!
TestCase subclass: #ShoppingCartTests
	instanceVariableNames: 'testStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 17:32:24'!
setUp
	
	"A sample store with some items used in the tests"
	testStore := BookStore forMerchant: MerchantFake
		withStockFor: (Dictionary with: 1933988274->99999 with: 0321146530->99999)
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

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 18:24:34'!
test08AShoppingCartShouldRaiseAnErrorOnValidISBNsNotInStock
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: 12345 thisManyTimes: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore noStockErrorMessage equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 16:36:47'!
test09AddingBooksToTheCartShouldRemoveThemFromTheStore
	
	| currentCart expectedStock |
	currentCart := self makeCart.
	
	expectedStock := (testStore stockOf: 1933988274) - 3.
	currentCart addBook: 1933988274 thisManyTimes: 3.
	
	self assert: expectedStock equals: (testStore stockOf: 1933988274).
	self assert: (Dictionary with: 1933988274->3) equals: currentCart contents.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 16:40:03'!
test10TellingAShoppingCartToReturnItemsShouldReturnAllItemsToTheStore
	
	| currentCart expectedStock originalStock |
	currentCart := self makeCart.
	originalStock := testStore stockOf: 1933988274.
	
	expectedStock := originalStock - 1.
	currentCart addBook: 1933988274 thisManyTimes: 1.
	self assert: expectedStock equals: (testStore stockOf: 1933988274).
	
	currentCart returnItems.
	self assert: originalStock equals: (testStore stockOf: 1933988274).
	self assert: Dictionary new equals: currentCart contents.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 17:13:16'!
test11TellingAShoppingCartToClearItemsShouldRemoveAllItemsWithoutReturningThem
	
	| currentCart expectedStock |
	currentCart := self makeCart.
	expectedStock := (testStore stockOf: 1933988274) - 5.
	
	currentCart addBook: 1933988274 thisManyTimes: 5.
	self assert: expectedStock equals: (testStore stockOf: 1933988274).
	
	currentCart clearItems.
	self assert: expectedStock equals: (testStore stockOf: 1933988274).
	self assert: Dictionary new equals: currentCart contents.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 17:13:24'!
test12ANewShoppingCartsTotalPriceShouldBeZero
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: 0 equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 17:13:30'!
test13AShoppingCartShouldKeepTrackOfThePriceOfOneItem
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: 1933988274 thisManyTimes: 1.
	
	self assert: (testStore priceOf: 1933988274) equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 16:37:17'!
test14AShoppingCartShouldKeepTrackOfThePriceOfMoreThanOneItem
	
	| currentCart expectedPrice |
	currentCart := self makeCart.
	expectedPrice := (testStore priceOf: 1933988274) * 3 + (testStore priceOf: 0321146530).
	
	currentCart addBook: 1933988274 thisManyTimes: 3.
	currentCart addBook: 0321146530 thisManyTimes: 1.
	
	self assert: expectedPrice equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/16/2021 17:13:42'!
test15AShoppingCartShouldKeepTrackOfThePriceOfOneItemManyTimes
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: 1933988274 thisManyTimes: 5.
	
	self assert: (testStore priceOf: 1933988274) * 5 equals: currentCart totalPrice.! !


!ShoppingCartTests methodsFor: 'tests - private' stamp: 'FL 2/11/2021 21:54:01'!
makeCart

	^ ShoppingCart forStore: testStore forClientId: 1 withPassword: 'TEST'! !


!classDefinition: #BookStore category: 'TusLibros'!
Object subclass: #BookStore
	instanceVariableNames: 'associatedMerchant currentStock itemPrices transactionsMade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!BookStore commentStamp: '<historical>' prior: 0!
TO-DO:
	- Formatear numero para el merchant correctamente, en vez de simplemente convertirlo a String.!


!BookStore methodsFor: 'initialization' stamp: 'FL 2/16/2021 17:34:46'!
initializeForMerchant: aMerchant withStockFor: aStockDictionary withPrices: aPriceDictionary 

	associatedMerchant := aMerchant.
	currentStock := aStockDictionary.
	itemPrices := aPriceDictionary.
	transactionsMade := OrderedCollection new.! !


!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 18:16:31'!
addStockOf: aBookISBN by: aQuantity
 
	self reduceStockOf: aBookISBN by: aQuantity negated.! !

!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 17:59:18'!
hasStockOf: aBookISBN 
	
	^(self stockOf: aBookISBN) strictlyPositive.! !

!BookStore methodsFor: 'stock' stamp: 'FL 2/18/2021 18:25:08'!
reduceStockOf: aBookISBN by: aQuantity 
	
	| newStock |
	(self hasStockOf: aBookISBN) ifFalse: [self error: self class noStockErrorMessage].
	
	newStock := (self stockOf: aBookISBN) - aQuantity.
	newStock positive ifFalse: [self error: self class insufficientStockErrorMessage].
	
	currentStock at: aBookISBN put: newStock.! !

!BookStore methodsFor: 'stock' stamp: 'FL 2/11/2021 17:55:41'!
stockOf: aBookISBN 
	
	^currentStock at: aBookISBN ifAbsent: 0.! !


!BookStore methodsFor: 'money related' stamp: 'FL 2/18/2021 18:42:37'!
checkoutCart: aShoppingCartOfThisStore withCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner 
	
	| transactionAmount |
	transactionAmount := aShoppingCartOfThisStore totalPrice.
	associatedMerchant chargeAmount: transactionAmount asString toCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner.
	
	transactionsMade add: transactionAmount.! !

!BookStore methodsFor: 'money related' stamp: 'FL 2/18/2021 18:25:26'!
priceOf: aBookISBN 
	
	^itemPrices at: aBookISBN ifAbsent: [self error: self class priceNotAvailableError].! !

!BookStore methodsFor: 'money related' stamp: 'FL 2/16/2021 17:28:55'!
transactionsMade

	^transactionsMade! !

!BookStore methodsFor: 'money related' stamp: 'FL 2/11/2021 21:26:56'!
updatePriceOf: aBookISBN to: aPrice
 
	itemPrices at: aBookISBN put: aPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookStore class' category: 'TusLibros'!
BookStore class
	instanceVariableNames: ''!

!BookStore class methodsFor: 'instance creation' stamp: 'FL 2/16/2021 17:08:27'!
forMerchant: aMerchant withStockFor: aStockDictionary withPrices: aPriceDictionary 

	^self new initializeForMerchant: aMerchant withStockFor: aStockDictionary withPrices: aPriceDictionary.! !


!BookStore class methodsFor: 'error messages' stamp: 'FL 2/18/2021 18:22:56'!
insufficientStockErrorMessage
	
	^'There is not enough stock to retrieve the book asked.'! !

!BookStore class methodsFor: 'error messages' stamp: 'FL 2/18/2021 18:23:06'!
noStockErrorMessage
 
	^'The book asked for is not in stock.'! !

!BookStore class methodsFor: 'error messages' stamp: 'FL 2/18/2021 18:23:24'!
priceNotAvailableError
	
	^'Price for book asked not found.'! !


!classDefinition: #MerchantFake category: 'TusLibros'!
Object subclass: #MerchantFake
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!MerchantFake commentStamp: '<historical>' prior: 0!
The base of a merchant, as the name implies it does not realize any real credit card transactions.

As a special testing case, all transactions with valid details succeed except the ones to credit card number "0000000000000000".

---

La base de un Merchant, como el nombre implica no realiza ninguna transaccion con tarjetas de credito reales.

Como un caso especial de prueba, todas las transacciones con detalles validos son aceptadas excepto las realizadas al numero de tarjeta de credito "0000000000000000".!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantFake class' category: 'TusLibros'!
MerchantFake class
	instanceVariableNames: ''!

!MerchantFake class methodsFor: 'transactions' stamp: 'FL 2/18/2021 18:21:34'!
chargeAmount: aPrice toCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner 
	
	self validateCardNumber: aCardNumber.
	self validateExpirationDate: anExpirationDate.
	self validateCardOwner: aCardOwner.
	
	"Special testing case."
	(aCardNumber = '0000000000000000') ifTrue: [self error: self transactionFailedErrorMessage]! !


!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/18/2021 17:23:39'!
cardAlreadyExpiredErrorMessage

	^'The Credit Card given has already expired.'! !

!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/18/2021 16:52:02'!
invalidCardNumberErrorMessage

	^'Invalid Credit Card number.'! !

!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/18/2021 17:40:29'!
invalidCardOwnerErrorMessage

	^'Invalid Credit Card owner name.'! !

!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/18/2021 16:58:05'!
invalidExpirationDateErrorMessage
	
	^'Invalid Credit Card expiration date.'! !

!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/18/2021 18:20:33'!
invalidExpirationDateMonthErrorMessage
	
	^'Expiration month out of range.'! !

!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/18/2021 17:26:07'!
invalidExpirationDateYearErrorMessage

	^'Expiration year given should be after 1900.'! !

!MerchantFake class methodsFor: 'error messages' stamp: 'FL 2/16/2021 17:54:01'!
transactionFailedErrorMessage
	
	^'Transaction failed.'! !


!MerchantFake class methodsFor: 'detail validation' stamp: 'FL 2/18/2021 18:21:01'!
assertNumeric: aString

	^aString allSatisfy: [:aPotentialDigit | aPotentialDigit isDigit]! !

!MerchantFake class methodsFor: 'detail validation' stamp: 'FL 2/18/2021 18:13:02'!
validateCardNumber: aCardNumber

	(aCardNumber size = 16) ifFalse: [self error: self invalidCardNumberErrorMessage].
	(self assertNumeric: aCardNumber) ifFalse: [self error: self invalidCardNumberErrorMessage]! !

!MerchantFake class methodsFor: 'detail validation' stamp: 'FL 2/18/2021 18:21:30'!
validateCardOwner: aCardOwner

	^ (aCardOwner size between: 1 and: 30) ifFalse: [self error: self invalidCardOwnerErrorMessage]! !

!MerchantFake class methodsFor: 'detail validation' stamp: 'FL 2/18/2021 18:13:50'!
validateExpirationDate: anExpirationDate
	
	| expirationMonth expirationYear currentDate expirationDate |
	(anExpirationDate size = 6) ifFalse: [self error: self invalidExpirationDateErrorMessage].
	(self assertNumeric: anExpirationDate) ifFalse: [self error: self invalidExpirationDateErrorMessage].
	
	expirationMonth := (anExpirationDate copyFrom: 1 to: 2) asNumber.
	expirationYear := (anExpirationDate copyFrom: 3 to: 6) asNumber.
	(expirationMonth between: 1 and: 12) ifFalse: [self error: self invalidExpirationDateMonthErrorMessage.].
	(expirationYear >= 1900) ifFalse: [self error: self invalidExpirationDateYearErrorMessage.].
	
	currentDate := Date today.
	expirationDate := Date newDay: 1 month: expirationMonth year: expirationYear.
	(currentDate < expirationDate) ifFalse: [self error: self cardAlreadyExpiredErrorMessage].
	
	! !


!classDefinition: #ShoppingCart category: 'TusLibros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books associatedStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'FL 2/11/2021 17:45:19'!
initializeForStore: aStore

	books := Dictionary new.
	associatedStore := aStore.! !


!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/16/2021 16:37:52'!
addBook: aBookISBN thisManyTimes: aQuantity 
	
	| newQuantity |
	
	(aQuantity positive) ifFalse: [self error: self class invalidQuantityErrorMessage].
	
	associatedStore reduceStockOf: aBookISBN by: aQuantity.
	newQuantity := (books at: aBookISBN ifAbsent: 0) + aQuantity.
	
	books at: aBookISBN put: newQuantity.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/16/2021 17:14:19'!
clearItems
	
	books := Dictionary new.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/8/2021 22:00:25'!
contents
	
	^books! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/9/2021 16:21:55'!
isEmpty
	
	^books isEmpty! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/16/2021 16:39:08'!
returnItems
	
	books keysDo: [:aBookISBN | 
		associatedStore addStockOf: aBookISBN by: (books at: aBookISBN).
		books removeKey: aBookISBN.
	]! !


!ShoppingCart methodsFor: 'price' stamp: 'FL 2/11/2021 21:47:51'!
totalPrice
	
	| total |
	total := 0.
	books keysAndValuesDo: [:aBookISBN :aQuantity |
		total := total + ((associatedStore priceOf: aBookISBN) * aQuantity).
	].
	^total.! !


!ShoppingCart methodsFor: 'checkout' stamp: 'FL 2/16/2021 17:55:23'!
checkoutWithCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner 
	
	books ifEmpty: [self error: self class emptyCartCheckoutErrorMessage.].
	
	associatedStore checkoutCart: self withCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner.
	self clearItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'FL 2/16/2021 16:38:25'!
forStore: aStore forClientId: anId withPassword: aPassword

	"For now we're assuming all IDs and Passwords are valid, and that there's no limit to the amount of carts an ID can have."
	^self new initializeForStore: aStore.! !


!ShoppingCart class methodsFor: 'error messages' stamp: 'FL 2/16/2021 17:41:32'!
emptyCartCheckoutErrorMessage
	
	^'Cannot checkout an empty cart.'! !

!ShoppingCart class methodsFor: 'error messages' stamp: 'FL 2/9/2021 16:50:15'!
invalidQuantityErrorMessage
	
	^'Invalid quantity, should be 1 or greater.'! !
