!classDefinition: #CintaDeTransporteDos category: 'Factorio'!
DenotativeObject subclass: #CintaDeTransporteDos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaDeTransporteDos class' category: 'Factorio'!
CintaDeTransporteDos class
	instanceVariableNames: 'destino contenido'!

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:14'!
agregar: unMineral
	contenido add: unMineral.! !

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:14'!
agregarTodos: unContenido
	"Atajo para trasladar todo un contenido de uno a otro."
	contenido addAll: unContenido.! !

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:15'!
cantidadDeMenas
	^contenido size.! !

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:15'!
conectarA: unDestino
	destino := unDestino.! !

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:47:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaDeTransporteUno.
	contenido := ((OrderedCollection new)).! !

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:15'!
trasladarMinerales
	destino agregarTodos: contenido.
	self vaciar.! !

!CintaDeTransporteDos class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:15'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaDeTransporteUno category: 'Factorio'!
DenotativeObject subclass: #CintaDeTransporteUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaDeTransporteUno class' category: 'Factorio'!
CintaDeTransporteUno class
	instanceVariableNames: 'destino contenido'!

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:34:08'!
agregar: unMineral
	contenido add: unMineral.! !

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:42:50'!
agregarTodos: unContenido
	"Atajo para trasladar todo un contenido de uno a otro."
	contenido addAll: unContenido.! !

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:40:32'!
cantidadDeMenas
	^contenido size.! !

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:31:35'!
conectarA: unDestino
	destino := unDestino.! !

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:47:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := Contenedor.
	contenido := ((OrderedCollection new)).! !

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:44:44'!
trasladarMinerales
	destino agregarTodos: contenido.
	self vaciar.! !

!CintaDeTransporteUno class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:38:00'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #Contenedor category: 'Factorio'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'Factorio'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:04'!
agregar: unaMena
	contenido add: unaMena.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'FL 10/24/2020 16:44:20'!
agregarTodos: unContenido
	"Atajo para trasladar todo un contenido de uno a otro."
	contenido addAll: unContenido.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:20'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:47:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:51'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'Factorio'!
ExtractorDeCarbon class
	instanceVariableNames: 'destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:50'!
extraer
	destino agregar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:47:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaDeTransporteUno.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: 'destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:28'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:43:41'!
extraer
	destino agregar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'FL 10/27/2020 19:47:54'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaDeTransporteDos.! !


!classDefinition: #FactorioTest category: 'Factorio'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'Factorio'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 01:01:45'!
configurarCircuitoExtractorCaja.

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.	
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:55:32'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:53:55'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'FL 10/27/2020 19:43:00'!
configurarCircuitoExtractorCintaCaja
	Contenedor vaciar.
	"No se olviden de vaciar la cinta tambien!!"
	CintaDeTransporteUno vaciar.
	"Conectamos el extractor a la cinta, luego conectamos la cinta a la caja"
	ExtractorDeCarbon conectarA: CintaDeTransporteUno.
	CintaDeTransporteUno conectarA: Contenedor.
! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'FL 10/27/2020 19:43:00'!
hacerAndarCircuitoExtractorCintaCaja
	"Hacemos andar el extractor, asi deja un carbon en la cinta."
	ExtractorDeCarbon extraer.
	"Luego hacemos andar la cinta (con algun mensaje) y deberia dejar el carbon en la caja.	"
	CintaDeTransporteUno trasladarMinerales.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'FL 10/27/2020 19:43:00'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	"Tambien tenemos que chequear que en la cinta no haya nada. Cero carbon."
	Assert that: CintaDeTransporteUno cantidadDeMenas isEqualTo: 0.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'FL 10/27/2020 19:45:24'!
configurarCircuitoExtractorExtractorCintaCintaCaja
	Contenedor vaciar.
	"Además de vaciar el Contenedor (arriba) también vaciamos las dos cintas"
	CintaDeTransporteUno vaciar.
	CintaDeTransporteDos vaciar.
	"Conectamos el extractor de carbon a una de las cintas"
	ExtractorDeCarbon conectarA: CintaDeTransporteUno.
	"Conectamos el extractor de hierro a la otra cinta"
	ExtractorDeHierro conectarA: CintaDeTransporteDos.
	"Ahora conectamos la primer cinta al Contenedor"
	CintaDeTransporteUno conectarA: Contenedor.
	"Y conectamos la segunda cinta a la primer cinta"
	CintaDeTransporteDos conectarA: CintaDeTransporteUno.
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'FL 10/27/2020 19:46:21'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	"Hacemos andar el extractor, asi deja un carbon en la cinta.
	Lo mismo con el otro extractor, asi deja una mena de hierro en la otra cinta.
	Hacemos andar la cinta con la mena de hierro, asi la deposita en la cinta que tiene el carbon.
	Ahora podemos hacer andar la ultima cinta, la que recibió primero el carbon 
	y ahora tambien tiene el hierro y que deje todo en el Contenedor."
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	CintaDeTransporteDos trasladarMinerales.
	CintaDeTransporteUno trasladarMinerales.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'FL 10/27/2020 19:46:57'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	"Tambien tenemos que chequear que no haya nada en las cintas"
	Assert that: CintaDeTransporteUno cantidadDeMenas isEqualTo: 0.
	Assert that: CintaDeTransporteDos cantidadDeMenas isEqualTo: 0.! !

CintaDeTransporteDos initializeAfterFileIn!
CintaDeTransporteUno initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!