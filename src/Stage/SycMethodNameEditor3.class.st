Class {
	#name : #SycMethodNameEditor3,
	#superclass : #SycMethodNameEditor2,
	#instVars : [
		'editParameter',
		'okEdit',
		'editerArgumentList',
		'refactoring'
	],
	#category : #'Stage-things'
}

{ #category : #specs }
SycMethodNameEditor3 class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: 'Selector'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #selectorInput;
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Arguments'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #argumentsList;
				add:
					(SpecBoxLayout newVertical
						add: #upButton
							withConstraints: [ :aConstraints | aConstraints height: 30 ];
						add: #downButton
							withConstraints: [ :aConstraints | aConstraints height: 30 ];
						yourself)
					withConstraints: [ :aConstraints | aConstraints width: 30 ];
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Edit'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #editParameter; 
				add:
					(SpecBoxLayout newVertical
						add: #okEdit
							withConstraints: [ :aConstraints | aConstraints height: 20 ];
						yourself)
					withConstraints: [ :aConstraints | aConstraints width: 30 ];
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Preview'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #previewResult; yourself);
		yourself
]

{ #category : #specs }
SycMethodNameEditor3 class >> example2 [
	<script>
	self
		openOn:
			(RBMethodName
				selector: (UseOnlyForTest >> #a:b:) selector
				arguments: ((UseOnlyForTest >> #a:b:) ast arguments collect: #name))
]

{ #category : #specs }
SycMethodNameEditor3 class >> openOn: aMethod [
	|temp|
	temp := (self on: aMethod).
	temp initializeEditerArgumentList.
	^ temp openModalWithSpec
]

{ #category : #specs }
SycMethodNameEditor3 class >> openOn: aMethod withRefactoring: refactoring [
	|temp|
	temp := (self on: aMethod).
	temp refactoring: refactoring.
	temp initializeEditerArgumentList.
	^ temp openModalWithSpec
]

{ #category : #services }
SycMethodNameEditor3 >> alert: aString [
	"Display a message for the user to read and then dismiss."

	aString isEmptyOrNil
		ifFalse: [ UIManager default alert: aString ]
]

{ #category : #services }
SycMethodNameEditor3 >> editParameter [
	"Validate the change of name the parameters and update a argumentsList and label"
	| selected newName|
	newName := editParameter text asSymbol.
	selected := argumentsList items at: (argumentsList selection selectedIndex).
	newName = selected ifTrue: [ ^ self ].
	refactoring dictParameters: editerArgumentList;
		   		   validateRenameOf: selected to: newName.
	editerArgumentList at: (self getKeyOf: selected) put: newName.
	self updateItem: selected to: newName.
	self updateLabel
]

{ #category : #services }
SycMethodNameEditor3 >> getKeyOf: aValue [
	"Get a real parameter's name of extracted method given a new parameter's name"
	|keyOfValue|
	editerArgumentList keysAndValuesDo: [ :key :value | 
		aValue = value ifTrue: [ keyOfValue := key ] ].
	^ keyOfValue
]

{ #category : #services }
SycMethodNameEditor3 >> getParametersOrder [
	"Get the new parameters order with the old parameters names"
	^ argumentsList items collect: [ :each | self getKeyOf: each ]
	
]

{ #category : #services }
SycMethodNameEditor3 >> initializeEditerArgumentList [
	"Create a dictionary with old parameters name as key and value.
	It value can change after if you rename a parameter"
	editerArgumentList := Dictionary new.
	methodName arguments do: [ :each | 
		editerArgumentList at: each put: each ]
]

{ #category : #services }
SycMethodNameEditor3 >> initializePresenter [ 
	super initializePresenter .
	self updateEditTemp.
	argumentsList whenSelectionChangedDo: [ self updateEditTemp ].
	okEdit action: [ self validateEditParameter ]

]

{ #category : #services }
SycMethodNameEditor3 >> initializeWidgets [
	super initializeWidgets.
	editParameter := self newTextInput autoAccept: true.
	okEdit := self newButton.
	
	okEdit label: 'Ok'
	
]

{ #category : #services }
SycMethodNameEditor3 >> okEdit [
	^ okEdit
]

{ #category : #services }
SycMethodNameEditor3 >> refactoring: anObject [
	refactoring := anObject 
]

{ #category : #services }
SycMethodNameEditor3 >> renameMethodAndClose: presenter [
	^ self previewResult label = '(invalid)'
		ifTrue: [ self inform: 'Invalid method name' ]
		ifFalse: [
			refactoring dictParameters: editerArgumentList.
			methodName
				arguments: self getParametersOrder;
				selector: selectorInput text.
			presenter
				beOk;
				close ]
]

{ #category : #services }
SycMethodNameEditor3 >> updateEditTemp [
	| selectedIndex |
	selectedIndex := argumentsList selection selectedIndex.
	selectedIndex = 0 ifFalse: [ 
	editParameter text: (argumentsList items at: selectedIndex)]
]

{ #category : #services }
SycMethodNameEditor3 >> updateItem: selected to: newName [
	argumentsList items doWithIndex: [ :each :index | 
		each = selected ifTrue: [ argumentsList items at: index put: newName  ] ]
]

{ #category : #services }
SycMethodNameEditor3 >> validateEditParameter [
	"Validate the rename of a parameter, if exist an error show an alert"
	self previewResult label = '(invalid)'
		ifTrue: [ self alert: 'You can not rename parameters if you have an invalid method name' ]
		ifFalse: [ [ self editParameter  ]
 			on: RBRefactoringError 
			do: [:ex | self alert: ex messageText] 
	]
]
