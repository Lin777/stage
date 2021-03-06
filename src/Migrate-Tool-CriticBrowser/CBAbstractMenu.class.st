"
actionsGroup
	^ self subclassResponsibility 
"
Class {
	#name : #CBAbstractMenu,
	#superclass : #Object,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBAbstractMenu class >> actionsGroup [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractMenu class >> actionsMenu [
	^ self subclasses sorted: #priorityGroup ascending.
]

{ #category : #accessing }
CBAbstractMenu class >> groupPriority [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractMenu class >> icon [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
CBAbstractMenu class >> isAbstract [ 
	^ self = CBAbstractMenu
]

{ #category : #accessing }
CBAbstractMenu class >> itemPriority [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractMenu class >> runOn: aCriticBrowser [
	^ self subclassResponsibility.
]

{ #category : #accessing }
CBAbstractMenu class >> title [ 
	^ self subclassResponsibility 
]
