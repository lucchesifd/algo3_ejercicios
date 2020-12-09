!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:32'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:38'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:45'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:51'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:09:57'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:10:03'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:07:21'!
test07BalanceOfAPortfolioWithANewAccountShouldBeZero

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self assert: portfolio balance equals: 0 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:08:28'!
test08BalanceOfAPortfolioWithOneAccountWithBalanceShouldBeThatBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	Deposit register: 100 * peso on: account.
	
	self assert: portfolio balance equals: 100 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:09:08'!
test09BalanceOfAPortfolioWithMultipleAccountsShouldBeTheSumOfTheirBalances

	| account portfolio anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: account with: anotherAccount.
	
	Deposit register: 100 * peso on: account.
	Deposit register: 100 * peso on: anotherAccount.
	
	self assert: portfolio balance equals: 200 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:09:38'!
test10BalanceShouldConsiderComposedPortfolios

	| account portfolio anotherAccount anotherPortfolio |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: account.
	anotherPortfolio := Portfolio with: anotherAccount with: portfolio.
	
	Deposit register: 100 * peso on: account.
	Deposit register: 100 * peso on: anotherAccount.
	
	self assert: anotherPortfolio balance equals: 200 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:10:25'!
test11APortfolioWithANewAccountShouldNotHaveAnyRegisters

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self deny: (portfolio hasRegistered: Deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:11:22'!
test12APortfolioWithOneAccountShouldHaveTheRegistersOfThatAccount

	| account portfolio aDeposit |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	aDeposit := Deposit register: 100 * peso on: account.
	
	self assert: (portfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:11:48'!
test13APortfolioWithMultipleAccountsShouldHaveAllTheRegistersOfAllAccounts

	| account portfolio aDeposit anotherAccount aTransferDeposit aTransferWithdraw |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account with: anotherAccount.
	
	aDeposit := Deposit register: 100 * peso on: account.
	aTransferWithdraw := TransferWithdraw register: 50 * peso on: account.
	aTransferDeposit := TransferDeposit register: aTransferWithdraw on: anotherAccount.
	
	self assert: (portfolio hasRegistered: aDeposit).
	self assert: (portfolio hasRegistered: aTransferWithdraw).
	self assert: (portfolio hasRegistered: aTransferDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 12/9/2020 20:12:39'!
test14HasRegistersShouldConsiderComposedPortfolios

	| account portfolio anotherAccount anotherPortfolio aDeposit aTransferDeposit aTransferWithdraw |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: account.
	anotherPortfolio := Portfolio with: anotherAccount with: portfolio.
	
	aDeposit := Deposit register: 100 * peso on: account.
	aTransferWithdraw := TransferWithdraw register: 50 * peso on: account.
	aTransferDeposit := TransferDeposit register: aTransferWithdraw on: anotherAccount.
	
	self assert: (anotherPortfolio hasRegistered: aDeposit).
	self assert: (anotherPortfolio hasRegistered: aTransferWithdraw).
	self assert: (anotherPortfolio hasRegistered: aTransferDeposit).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:48'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:13:44'!
test01ATransferShouldUpdateTheBalanceOfBothAccounts

	| senderAccount recipientAccount aWithdrawal |
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 200 * peso on: senderAccount.
	Deposit register: 50 * peso on: recipientAccount.

	aWithdrawal := TransferWithdraw register: 150 * peso on: senderAccount.
	TransferDeposit register: aWithdrawal on: recipientAccount. 

	self assert: senderAccount balance equals: 50 * peso.
	self assert: recipientAccount balance equals: 200 * peso.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:23'!
test02TheDepositLegShouldBeAbleToObtainItsRespectiveWithdraw

	| senderAccount recipientAccount aWithdrawal aDeposit |
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 200 * peso on: senderAccount.
	Deposit register: 50 * peso on: recipientAccount.

	aWithdrawal := TransferWithdraw register: 150 * peso on: senderAccount.
	aDeposit := TransferDeposit register: aWithdrawal on: recipientAccount. 

	self assert: aDeposit associatedWithdraw equals: aWithdrawal.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:51'!
test03TheWithdrawLegShouldBeAbleToObtainItsRespectiveDeposit

	| senderAccount recipientAccount aWithdrawal aDeposit |
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 200 * peso on: senderAccount.
	Deposit register: 50 * peso on: recipientAccount.

	aWithdrawal := TransferWithdraw register: 150 * peso on: senderAccount.
	aDeposit := TransferDeposit register: aWithdrawal on: recipientAccount. 

	self assert: aWithdrawal associatedDeposit equals: aDeposit.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:51'!
test04WithdrawAndDepositShouldBeAbleToObtainThemselves

	| senderAccount recipientAccount aWithdrawal aDeposit |
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 200 * peso on: senderAccount.
	Deposit register: 50 * peso on: recipientAccount.

	aWithdrawal := TransferWithdraw register: 150 * peso on: senderAccount.
	aDeposit := TransferDeposit register: aWithdrawal on: recipientAccount. 

	self assert: aWithdrawal associatedWithdraw equals: aWithdrawal.
	self assert: aDeposit associatedDeposit equals: aDeposit.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:16:18'!
test05AWithdrawLegCannotBeAssociatedToMoreThanOneAccount

	| senderAccount recipientAccount aWithdrawal anotherRecipientAccount |
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	anotherRecipientAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.

	aWithdrawal := TransferWithdraw register: 50 * peso on: senderAccount.
	TransferDeposit register: aWithdrawal on: recipientAccount.
	
	self should: [TransferDeposit register: aWithdrawal on: anotherRecipientAccount.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TransferWithdraw alreadyAssociatedErrorMessage.]! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'FL 12/9/2020 18:29:10'!
for: aValue

	self subclassResponsibility.! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'FL 12/3/2020 21:14:35'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'FL 12/9/2020 18:50:32'!
balanceValue

	^ self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'associatedWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'FL 12/9/2020 19:02:40'!
initializeFor: aWithdrawal 

	associatedWithdraw := aWithdrawal.
	aWithdrawal associateTo: self.! !


!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:51'!
associatedDeposit
	^self.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:23'!
associatedWithdraw
	
	^associatedWithdraw.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 18:50:39'!
balanceValue

	^ self value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 18:45:22'!
value
	
	^ associatedWithdraw value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 18:40:36'!
for: aDeposit

	^ self new initializeFor: aDeposit ! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'value associatedDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'FL 12/9/2020 18:50:57'!
balanceValue

	^ self value negated.! !

!TransferWithdraw methodsFor: 'initialization' stamp: 'FL 12/9/2020 18:48:38'!
initializeFor: aValue 

	value := aValue.! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 19:14:59'!
associateTo: aDeposit 
	
	associatedDeposit isNil ifFalse: [self error: self class alreadyAssociatedErrorMessage].
	associatedDeposit := aDeposit.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:50'!
associatedDeposit
	
	^associatedDeposit! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:17:23'!
associatedWithdraw
	^self! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 18:52:08'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 19:17:01'!
alreadyAssociatedErrorMessage
	
	^'Withdrawal was already deposited on another account'! !

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 18:51:47'!
for: aValue
 
	^self new initializeFor: aValue.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'FL 12/9/2020 18:51:10'!
balanceValue

	^ self value negated! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'FL 12/3/2020 21:08:51'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !


!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 19:36:22'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance. ] ifEmpty: [0 * peso].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'FL 12/9/2020 20:01:04'!
hasRegistered: aRegister 
	
	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aRegister ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FL 12/9/2020 18:49:50'!
balance

	^transactions sum: [:aTransaction | aTransaction balanceValue. ] ifEmpty: [ 0 * peso ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !
