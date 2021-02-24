!classDefinition: #BookStoreTests category: 'TusLibros'!
TestCase subclass: #BookStoreTests
	instanceVariableNames: 'includedBook notIncludedBook includedBookPrice includedBookStock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:30:20'!
setUp

	includedBook := 12345.
	notIncludedBook := 54321.
	includedBookStock := 5.
	includedBookPrice := 250.! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:43:49'!
test01CheckingIfAnAvailableItemIsInStockShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	self assert: (currentStore hasStockOf: includedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:43:56'!
test02CheckingIfAnUnavailableItemIsInStockShouldAlsoWork

	| currentStore |
	currentStore := self makeStore.
	
	self deny: (currentStore hasStockOf: notIncludedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:30:12'!
test03RetrievingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	self assert: includedBookStock equals: (currentStore stockOf: includedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:44:55'!
test04TheStockOfAnUnavailableItemShouldBeZero

	| currentStore |
	currentStore := self makeStore.
	
	self assert: 0 equals: (currentStore stockOf: notIncludedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:30:12'!
test05ReducingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	currentStore reduceStockOf: includedBook by: 3.
	
	self assert: includedBookStock - 3 equals: (currentStore stockOf: includedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:45:48'!
test06ReducingTheStockOfAnUnavailableItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self should: [ currentStore reduceStockOf: notIncludedBook by: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore noStockErrorMessage equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:30:12'!
test07ReducingTheStockTooFarShouldAlsoRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self should: [ currentStore reduceStockOf: includedBook by: 7. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore insufficientStockErrorMessage equals: anError messageText.
			self assert: includedBookStock equals: (currentStore stockOf: includedBook).
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:30:12'!
test08IncreasingTheStockOfAnAvailableItemShouldWork

	| currentStore |
	currentStore := self makeStore.
	
	currentStore addStockOf: includedBook by: 3.
	
	self assert: includedBookStock + 3 equals: (currentStore stockOf: includedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:30:20'!
test09RetrievingThePriceOfAnExistingItemWorks

	| currentStore |
	currentStore := self makeStore.
	
	self assert: includedBookPrice equals: (currentStore priceOf: includedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:47:15'!
test10RetrievingThePriceOfAnUnexistingItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self
		should: [ currentStore priceOf: notIncludedBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore priceNotAvailableError equals: anError messageText.
		].! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:47:48'!
test11UpdatingThePriceOfAnItemWorks

	| currentStore |
	currentStore := self makeStore.
	
	currentStore updatePriceOf: includedBook to: 500.
	self assert: 500 equals: (currentStore priceOf: includedBook).! !

!BookStoreTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:48:36'!
test12UpdatingThePriceOfAnUnexistingItemShouldRaiseAnError

	| currentStore |
	currentStore := self makeStore.
	
	self
		should: [ currentStore updatePriceOf: notIncludedBook to: 100 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore notIncludedPriceChangeError equals: anError messageText.
		].! !


!BookStoreTests methodsFor: 'tests - private' stamp: 'FL 2/18/2021 23:30:20'!
makeStore
	
	^BookStore forMerchant: MerchantFake
		withStockFor: (Dictionary with: includedBook->includedBookStock)
		withPrices: (Dictionary with: includedBook->includedBookPrice).! !


!classDefinition: #FakeTimeTests category: 'TusLibros'!
TestCase subclass: #FakeTimeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeTimeTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 18:38:22'!
test01
	
	| expectedNow testTime |
	testTime := FakeTime hour: 12 minute: 30 second: 15.
	expectedNow := Time hour: 12 minute: 30 second: 15.
	
	self assert: expectedNow equals: testTime now.! !

!FakeTimeTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:35:53'!
test02
	
	| expectedNow testTime |
	testTime := FakeTime hour: 12 minute: 30 second: 15.
	expectedNow := Time hour: 13 minute: 00 second: 15.
	
	testTime advanceForwards: (Duration minutes: 30).
	
	self assert: expectedNow equals: testTime now.! !

!FakeTimeTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:38:49'!
test03
	
	| expectedNow testTime |
	testTime := FakeTime hour: 12 minute: 30 second: 15.
	expectedNow := Time hour: 12 minute: 00 second: 15.
	
	testTime advanceBackwards: (Duration minutes: 30).
	
	self assert: expectedNow equals: testTime now.! !


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

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:32:51'!
test01ABasicCheckoutShouldWork

	| currentCart currentStore expectedTransaction |
	currentStore := self makeStore.
	currentCart := ShoppingCart forStore: currentStore.
	expectedTransaction := OrderedCollection with: bookPrice * 5.
	
	currentCart addBook: bookId thisManyTimes: 5.
	
	currentCart checkoutWithCardNumber: '1234123412341234' withExpirationDate: '122100' withCardOwner: 'TEST CARD'.
	
	self assert: expectedTransaction equals: currentStore transactionsMade.
	self assert: currentCart allBooks isEmpty.
	! !

!MerchantAndCheckoutTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:32:57'!
test02CheckingOutAnEmptyCartShouldRaiseAnError

	| currentCart currentStore |
	currentStore := self makeStore.
	currentCart := ShoppingCart forStore: currentStore.
	
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
	instanceVariableNames: 'testStore includedBook1 includedBook1Price includedBook2 includedBook2Price notIncludedBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:20:08'!
setUp
	
	includedBook1 := 1933988274.
	includedBook1Price := 250.
	includedBook2 := 0321146530.
	includedBook2Price := 750.
	notIncludedBook := 12345.
	
	"A sample store with some items used in the tests"
	testStore := BookStore forMerchant: MerchantFake
		withStockFor: (Dictionary with: includedBook1->99999 with: includedBook2->99999)
		withPrices: (Dictionary with: includedBook1->includedBook1Price with: includedBook2->includedBook2Price).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:33:40'!
test01ANewShoppingCartIsEmpty
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: currentCart isEmpty! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:19:16'!
test02AddingAnythingToAShoppingCartShouldNotLeaveItEmpty
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: includedBook1 thisManyTimes: 1.
	
	self deny: currentCart isEmpty.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 22:18:11'!
test03ANewShoppingCartShouldNotHaveAnyContents
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: currentCart allBooks isEmpty.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:20:18'!
test04TheAmountOfAnItemNotInAShoppingCartShouldBeZero
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: 0 equals: (currentCart amountOf: notIncludedBook).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:21:33'!
test05AShoppingCartShouldKeepTrackOfOneItem
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: includedBook1 thisManyTimes: 1.
	
	self assert: (Array with: includedBook1) equals: currentCart allBooks.
	self assert: 1 equals: (currentCart amountOf: includedBook1).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:23:48'!
test06AShoppingCartShouldKeepTrackOfMoreThanOneItem
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: includedBook1 thisManyTimes: 1.
	currentCart addBook: includedBook2 thisManyTimes: 1.
	
	self assert: currentCart allBooks contains: (Array with: includedBook1 with: includedBook2).
	self assert: 1 equals: (currentCart amountOf: includedBook1).
	self assert: 1 equals: (currentCart amountOf: includedBook2).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:24:15'!
test07AddingTheSameItemTwiceToAShoppingCartShouldAddMoreOfThatItem
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: includedBook1 thisManyTimes: 2.
	currentCart addBook: includedBook1 thisManyTimes: 3.
	
	self assert: (Array with: includedBook1) equals: currentCart allBooks.
	self assert: 5 equals: (currentCart amountOf: includedBook1).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/18/2021 23:24:26'!
test08AShoppingCartShouldRaiseAnErrorOnInvalidQuantities
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: includedBook1 thisManyTimes: -1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidQuantityErrorMessage equals: anError messageText.
			self assert: currentCart allBooks isEmpty.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 20:57:58'!
test09AShoppingCartShouldRaiseAnErrorOnAddingABookZeroTimes
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: includedBook1 thisManyTimes: 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidQuantityErrorMessage equals: anError messageText.
			self assert: currentCart allBooks isEmpty.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 21:01:20'!
test10AShoppingCartShouldRaiseAnErrorOnNonIntegerQuantities
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: includedBook1 thisManyTimes: 3.7. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: ShoppingCart invalidQuantityErrorMessage equals: anError messageText.
			self assert: currentCart allBooks isEmpty.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 20:58:10'!
test11AShoppingCartShouldRaiseAnErrorOnValidISBNsNotInStock
	
	| currentCart |
	currentCart := self makeCart.
	
	self
		should: [ currentCart addBook: notIncludedBook thisManyTimes: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: BookStore noStockErrorMessage equals: anError messageText.
		].! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 20:58:18'!
test12AddingBooksToTheCartShouldRemoveThemFromTheStore
	
	| currentCart expectedStock |
	currentCart := self makeCart.
	
	expectedStock := (testStore stockOf: includedBook1) - 3.
	currentCart addBook: includedBook1 thisManyTimes: 3.
	
	self assert: expectedStock equals: (testStore stockOf: includedBook1).
	self assert: (Array with: includedBook1) equals: currentCart allBooks.
	self assert: 3 equals: (currentCart amountOf: includedBook1).! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 20:58:30'!
test13TellingAShoppingCartToReturnItemsShouldReturnAllItemsToTheStore
	
	| currentCart expectedStock originalStock |
	currentCart := self makeCart.
	originalStock := testStore stockOf: includedBook1.
	
	expectedStock := originalStock - 1.
	currentCart addBook: includedBook1 thisManyTimes: 1.
	self assert: expectedStock equals: (testStore stockOf: includedBook1).
	
	currentCart returnItems.
	self assert: originalStock equals: (testStore stockOf: includedBook1).
	self assert: currentCart allBooks isEmpty.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 20:58:39'!
test14TellingAShoppingCartToClearItemsShouldRemoveAllItemsWithoutReturningThem
	
	| currentCart expectedStock |
	currentCart := self makeCart.
	expectedStock := (testStore stockOf: includedBook1) - 5.
	
	currentCart addBook: includedBook1 thisManyTimes: 5.
	self assert: expectedStock equals: (testStore stockOf: includedBook1).
	
	currentCart clearItems.
	self assert: expectedStock equals: (testStore stockOf: includedBook1).
	self assert: currentCart allBooks isEmpty.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 20:59:05'!
test15ANewShoppingCartsTotalPriceShouldBeZero
	
	| currentCart |
	currentCart := self makeCart.
	
	self assert: 0 equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 21:00:23'!
test16AShoppingCartShouldKeepTrackOfThePriceOfOneItem
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: includedBook1 thisManyTimes: 1.
	
	self assert: includedBook1Price equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 21:00:35'!
test17AShoppingCartShouldKeepTrackOfThePriceOfMoreThanOneItem
	
	| currentCart expectedPrice |
	currentCart := self makeCart.
	expectedPrice := includedBook1Price * 3 + includedBook2Price .
	
	currentCart addBook: includedBook1 thisManyTimes: 3.
	currentCart addBook: includedBook2 thisManyTimes: 1.
	
	self assert: expectedPrice equals: currentCart totalPrice.! !

!ShoppingCartTests methodsFor: 'tests' stamp: 'FL 2/22/2021 21:00:44'!
test18AShoppingCartShouldKeepTrackOfThePriceOfOneItemManyTimes
	
	| currentCart |
	currentCart := self makeCart.
	
	currentCart addBook: includedBook1 thisManyTimes: 5.
	
	self assert: includedBook1Price * 5 equals: currentCart totalPrice.! !


!ShoppingCartTests methodsFor: 'tests - private' stamp: 'FL 2/18/2021 22:27:06'!
assert: aBaseArray contains: aTestArray 
	
	aTestArray do: [:anItem |
		self assert: (aBaseArray includes: anItem) description: aBaseArray asString, ' does not contain ', anItem asString.
	].! !

!ShoppingCartTests methodsFor: 'tests - private' stamp: 'FL 2/18/2021 22:32:06'!
makeCart

	^ ShoppingCart forStore: testStore.! !


!classDefinition: #StoreManagerTests category: 'TusLibros'!
TestCase subclass: #StoreManagerTests
	instanceVariableNames: 'includedBook notIncludedBook includedBookPrice includedBookStock includedBook1 includedBook1Price includedBook2 includedBook2Price testStore validUserID validPassword invalidUserID invalidPassword'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!StoreManagerTests commentStamp: '<historical>' prior: 0!
TO-DO:
	- /checkOutCart e /listPurchases
	- Hacer tests si un carrito es valido, si al avanzar tiempo sigue siendo valido, etc etc.
!


!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 18:59:54'!
makeManager
	
	^self makeManagerForTime: Time.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 18:59:39'!
makeManagerForTime: aTimeBase
	
	| currentAuthenticator |
	currentAuthenticator := Authenticator forUsers: (Dictionary with: validUserID->validPassword).
	^StoreManager forStore: testStore withAuthenticator: currentAuthenticator usingTime: aTimeBase.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:05:26'!
setUp

	includedBook1 := 1933988274. includedBook1Price := 250.
	includedBook2 := 0321146530. includedBook2Price := 750.
	
	"A sample store with some items used in the tests"
	testStore := BookStore forMerchant: MerchantFake
		withStockFor: (Dictionary with: includedBook1->99999 with: includedBook2->99999)
		withPrices: (Dictionary with: includedBook1->includedBook1Price with: includedBook2->includedBook2Price).
	
	validUserID := 12345. validPassword := 'ABCDE'.
	invalidUserID := 54321. invalidPassword := 'EDCBA'.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:04:06'!
test01
	
	| currentAuthenticator |
	currentAuthenticator := Authenticator forUsers: (Dictionary with: validUserID->validPassword).
	
	self assert: (currentAuthenticator validateId: validUserID withPassword: validPassword).! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:05:41'!
test02
	
	| currentAuthenticator |
	currentAuthenticator := Authenticator forUsers: (Dictionary with: validUserID->validPassword).
	
	self deny: (currentAuthenticator validateId: validUserID withPassword: invalidPassword).! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:05:03'!
test03
	
	| currentAuthenticator |
	currentAuthenticator := Authenticator forUsers: (Dictionary with: validUserID->validPassword).
	
	self deny: (currentAuthenticator validateId: invalidUserID withPassword: validPassword).! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 20:34:46'!
test04
	
	| currentManager createdCartId |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	self assert: 1 equals: createdCartId.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:08:05'!
test05
	
	| currentManager |
	currentManager := self makeManager.
	
	self
		should: [currentManager createCartForId: invalidUserID withPassword: invalidPassword.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: StoreManager invalidIdOrPasswordErrorMessage equals: anError messageText.
		].! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:20:38'!
test06
	
	| currentManager firstCreatedCartId secondCreatedCartId |
	currentManager := self makeManager.
	firstCreatedCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	secondCreatedCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	self assert: 1 equals: firstCreatedCartId.
	self assert: 2 equals: secondCreatedCartId.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 20:38:47'!
test07
	
	| currentManager createdCartId retrievedCart |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	retrievedCart := currentManager getCartAtId: createdCartId.
	
	self assert: (retrievedCart isKindOf: ShoppingCart).
	self assert: #() equals: retrievedCart allBooks.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 20:41:47'!
test08
	
	| currentManager |
	currentManager := self makeManager.
	
	self
		should: [currentManager getCartAtId: 50000.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: StoreManager cartIdDoesNotExistErrorMessage equals: anError messageText.
		].! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 20:49:53'!
test09
	
	| currentManager createdCartId retrievedCart |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	currentManager addToCartId: createdCartId theBookIsbn: includedBook1 forTheQuantity: 1.
	retrievedCart := currentManager getCartAtId: createdCartId.
	
	self assert: (Array with: includedBook1) equals: retrievedCart allBooks.
	self assert: 1 equals: (retrievedCart amountOf: includedBook1).! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 20:55:14'!
test10
	
	| currentManager createdCartId |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	self
		should: [currentManager addToCartId: createdCartId theBookIsbn: includedBook1 forTheQuantity: 0.]
		raise: Error - MessageNotUnderstood. "All errors are handled in ShoppingCartTests"! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 21:05:58'!
test11
	
	| currentManager |
	currentManager := self makeManager.
	
	self
		should: [currentManager addToCartId: 50000 theBookIsbn: includedBook1 forTheQuantity: 1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: StoreManager cartIdDoesNotExistErrorMessage equals: anError messageText.
		].! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 21:15:58'!
test12
	
	| currentManager createdCartId expectedCartList retrievedCartList |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	retrievedCartList := currentManager listCartId: createdCartId.
	expectedCartList := Dictionary new.
	self assert: expectedCartList equals: retrievedCartList.
	! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 21:11:38'!
test13
	
	| currentManager createdCartId expectedCartList retrievedCartList |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	currentManager addToCartId: createdCartId theBookIsbn: includedBook1 forTheQuantity: 1.
	
	retrievedCartList := currentManager listCartId: createdCartId.
	expectedCartList := Dictionary with: includedBook1->1.
	self assert: expectedCartList equals: retrievedCartList.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 21:14:40'!
test14
	
	| currentManager createdCartId expectedCartList retrievedCartList |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	currentManager addToCartId: createdCartId theBookIsbn: includedBook1 forTheQuantity: 3.
	currentManager addToCartId: createdCartId theBookIsbn: includedBook2 forTheQuantity: 5.
	
	retrievedCartList := currentManager listCartId: createdCartId.
	expectedCartList := Dictionary with: includedBook1->3 with: includedBook2->5.
	self assert: expectedCartList equals: retrievedCartList.! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 18:58:14'!
test15
	
	| currentManager createdCartId |
	currentManager := self makeManager.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	self assert: (currentManager isCartValid: createdCartId).! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:40:24'!
test16
	
	| createdCartId currentFakeTime currentManager |
	currentFakeTime := FakeTime hour: 12 minute: 20 second: 0.
	currentManager := self makeManagerForTime: currentFakeTime.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	self assert: (currentManager isCartValid: createdCartId).
	currentFakeTime advanceForwards: (Duration minutes: 45).
	self deny: (currentManager isCartValid: createdCartId).
	
	! !

!StoreManagerTests methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:52:28'!
test17
	
	| createdCartId currentFakeTime currentManager |
	currentFakeTime := FakeTime hour: 12 minute: 20 second: 0.
	currentManager := self makeManagerForTime: currentFakeTime.
	createdCartId := currentManager createCartForId: validUserID withPassword: validPassword.
	
	self assert: (currentManager isCartValid: createdCartId).
	
	currentFakeTime advanceForwards: (Duration minutes: 20).
	currentManager addToCartId: createdCartId theBookIsbn: includedBook1 forTheQuantity: 1.
	currentFakeTime advanceForwards: (Duration minutes: 20).
	
	self assert: (currentManager isCartValid: createdCartId).
	
	! !


!classDefinition: #Authenticator category: 'TusLibros'!
Object subclass: #Authenticator
	instanceVariableNames: 'users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Authenticator methodsFor: 'initialization' stamp: 'FL 2/22/2021 18:31:51'!
initializeForUsers: anUserCollection 

	users := anUserCollection.! !


!Authenticator methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:16:28'!
ifInvalidId: aCustomerId withPassword: aPassword do: aClosure

	(self validateId: aCustomerId withPassword: aPassword) ifFalse: aClosure. ! !

!Authenticator methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 18:36:15'!
validateId: anId withPassword: aPassword 

	| userPassword |
	userPassword := users at: anId ifAbsent: [^false].
	^userPassword = aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Authenticator class' category: 'TusLibros'!
Authenticator class
	instanceVariableNames: ''!

!Authenticator class methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 18:31:06'!
forUsers: anUserCollection 
	
	^self new initializeForUsers: anUserCollection.! !


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

!BookStore methodsFor: 'money related' stamp: 'FL 2/18/2021 22:37:52'!
priceOfCart: aShoppingCart 
	
	| total |
	total := 0.
	aShoppingCart allBooks do: [:aBookISBN | | bookPrice bookQuantity |
		bookPrice := self priceOf: aBookISBN.
		bookQuantity := aShoppingCart amountOf: aBookISBN.
		total := total + (bookPrice * bookQuantity).
	].
	^total.! !

!BookStore methodsFor: 'money related' stamp: 'FL 2/18/2021 23:31:15'!
transactionsMade

	^transactionsMade copy.! !

!BookStore methodsFor: 'money related' stamp: 'FL 2/18/2021 23:16:39'!
updatePriceOf: aBookISBN to: aPrice

	(itemPrices includesKey: aBookISBN) ifFalse: [self error: self class notIncludedPriceChangeError].
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

!BookStore class methodsFor: 'error messages' stamp: 'FL 2/18/2021 22:50:33'!
notIncludedPriceChangeError
	
	^'Attempt to update price of unexistant item.'! !

!BookStore class methodsFor: 'error messages' stamp: 'FL 2/18/2021 18:23:24'!
priceNotAvailableError
	
	^'Price for book asked not found.'! !


!classDefinition: #FakeTime category: 'TusLibros'!
Object subclass: #FakeTime
	instanceVariableNames: 'currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeTime methodsFor: 'initialization' stamp: 'FL 2/24/2021 18:33:36'!
initializeHour: anHour minute: aMinute second: aSecond 

	currentTime := Time hour: anHour minute: aMinute second: aSecond.! !


!FakeTime methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:38:04'!
addHours: anHour minutes: aMinute seconds: aSecond 
	
	currentTime := Time
		hour: currentTime hour24 + anHour
		minute: currentTime minute + aMinute
		second: currentTime second + aSecond.! !

!FakeTime methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:38:15'!
advanceBackwards: aDuration 
	
	self addHours: aDuration hours negated minutes: aDuration minutes negated seconds: aDuration seconds negated.! !

!FakeTime methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:38:24'!
advanceForwards: aDuration 
	
	self addHours: aDuration hours minutes: aDuration minutes seconds: aDuration seconds.! !

!FakeTime methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 18:33:50'!
now
	
	^currentTime copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FakeTime class' category: 'TusLibros'!
FakeTime class
	instanceVariableNames: ''!

!FakeTime class methodsFor: 'instance creation' stamp: 'FL 2/24/2021 18:30:37'!
hour: anHour minute: aMinute second: aSecond 

	^self new initializeHour: anHour minute: aMinute second: aSecond. ! !


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
	instanceVariableNames: 'containedBooks associatedStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'FL 2/18/2021 23:29:37'!
initializeForStore: aStore

	containedBooks := Dictionary new.
	associatedStore := aStore.! !


!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/22/2021 21:02:45'!
addBook: aBookISBN thisManyTimes: aQuantity 
	
	| newQuantity |
	
	(aQuantity strictlyPositive and: [aQuantity isInteger]) ifFalse: [self error: self class invalidQuantityErrorMessage].
	
	associatedStore reduceStockOf: aBookISBN by: aQuantity.
	newQuantity := (containedBooks at: aBookISBN ifAbsent: 0) + aQuantity.
	
	containedBooks at: aBookISBN put: newQuantity.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/18/2021 23:29:37'!
allBooks
	
	^containedBooks keys.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/18/2021 23:29:37'!
amountOf: aBookISBN
 
	^containedBooks at: aBookISBN ifAbsent: 0.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/18/2021 23:29:37'!
clearItems
	
	containedBooks := Dictionary new.! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/18/2021 23:29:37'!
isEmpty
	
	^containedBooks isEmpty! !

!ShoppingCart methodsFor: 'contents' stamp: 'FL 2/18/2021 23:29:38'!
returnItems
	
	containedBooks keysAndValuesDo: [:aBookISBN :aQuantity | 
		associatedStore addStockOf: aBookISBN by: aQuantity.
		containedBooks removeKey: aBookISBN.
	]! !


!ShoppingCart methodsFor: 'price' stamp: 'FL 2/18/2021 22:35:00'!
totalPrice
	
	^associatedStore priceOfCart: self.! !


!ShoppingCart methodsFor: 'checkout' stamp: 'FL 2/18/2021 23:29:37'!
checkoutWithCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner 
	
	containedBooks ifEmpty: [self error: self class emptyCartCheckoutErrorMessage.].
	
	associatedStore checkoutCart: self withCardNumber: aCardNumber withExpirationDate: anExpirationDate withCardOwner: aCardOwner.
	self clearItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'FL 2/18/2021 22:32:26'!
forStore: aStore

	^self new initializeForStore: aStore.! !


!ShoppingCart class methodsFor: 'error messages' stamp: 'FL 2/16/2021 17:41:32'!
emptyCartCheckoutErrorMessage
	
	^'Cannot checkout an empty cart.'! !

!ShoppingCart class methodsFor: 'error messages' stamp: 'FL 2/9/2021 16:50:15'!
invalidQuantityErrorMessage
	
	^'Invalid quantity, should be 1 or greater.'! !


!classDefinition: #StoreManager category: 'TusLibros'!
Object subclass: #StoreManager
	instanceVariableNames: 'associatedStore associatedAuthenticator allCarts bookStore authenticator timeBase cartTimeLimit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreManager methodsFor: 'initialization' stamp: 'FL 2/24/2021 19:29:25'!
initializeForStore: aBookStore withAuthenticator: anAuthenticator usingTime: aTimeClass 

	associatedStore := aBookStore.
	associatedAuthenticator := anAuthenticator.
	timeBase := aTimeClass.
	allCarts := OrderedCollection new.
	cartTimeLimit := Duration minutes: 30.
	! !


!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:53:24'!
addToCartId: aCartId theBookIsbn: aBookISBN forTheQuantity: aQuantity
 
	| appropiateCart |
	appropiateCart := self getCartAtId: aCartId.
	appropiateCart addBook: aBookISBN thisManyTimes: aQuantity.
	
	(self getCartInfo: aCartId) at: #lastTimeUsed put: timeBase now.! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 19:15:44'!
createCartForId: aCustomerId withPassword: aPassword

	associatedAuthenticator ifInvalidId: aCustomerId withPassword: aPassword do: [self error: self class invalidIdOrPasswordErrorMessage].
	
	allCarts add: (self newCartForId: aCustomerId).
	^allCarts size.! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:10:23'!
getCartAtId: aCartId

	^(self getCartInfo: aCartId) at: #cart.! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:10:05'!
getCartInfo: aCartId

	^allCarts at: aCartId ifAbsent: [self error: self class cartIdDoesNotExistErrorMessage.].! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:10:34'!
invalidateCartId: aCartId

	(self getCartInfo: aCartId) at: #valid put: false.! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:41:10'!
isCartValid: aCartId

	self updateCartValidness.
	^(self getCartInfo: aCartId) at: #valid.! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 21:18:39'!
listCartId: aCartId 
	
	| cartContents currentCart |
	currentCart := self getCartAtId: aCartId.
	
	cartContents := Dictionary new.
	currentCart allBooks do: [:aBookISBN |
		cartContents at: aBookISBN put: (currentCart amountOf: aBookISBN).
	].

	^cartContents.
	! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:26:05'!
newCartForId: aCustomerID
 
	^Dictionary new
		add: #cart->(ShoppingCart forStore: associatedStore);
		add: #valid->true;
		add: #lastTimeUsed->timeBase now;
		yourself.! !

!StoreManager methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 19:49:46'!
updateCartValidness

	| cartsToInvalidate |
	cartsToInvalidate := allCarts reject: [:aCartInfo |
		| cartTime |
		cartTime := aCartInfo at: #lastTimeUsed.
		(aCartInfo at: #valid) and: [timeBase now - cartTime < cartTimeLimit].
	].

	cartsToInvalidate do: [:aCartInfo | aCartInfo at: #valid put: false].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreManager class' category: 'TusLibros'!
StoreManager class
	instanceVariableNames: ''!

!StoreManager class methodsFor: 'instance creation' stamp: 'FL 2/22/2021 21:28:43'!
forStore: aBookStore withAuthenticator: anAuthenticator usingTime: aTimeClass 

	^self new initializeForStore: aBookStore withAuthenticator: anAuthenticator usingTime: aTimeClass.! !


!StoreManager class methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 20:42:12'!
cartIdDoesNotExistErrorMessage
	
	^'Cart ID does not exist.'! !

!StoreManager class methodsFor: 'as yet unclassified' stamp: 'FL 2/24/2021 18:16:57'!
forStore: aBookStore withAuthenticator: anAuthenticator 
	
	^self forStore: aBookStore withAuthenticator: anAuthenticator usingTime: Time.! !

!StoreManager class methodsFor: 'as yet unclassified' stamp: 'FL 2/22/2021 18:50:39'!
invalidIdOrPasswordErrorMessage
	
	^'Invalid ID or password.'! !
