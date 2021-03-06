"
see superClass 's documentation
my action is :
	to log all critics
"
Class {
	#name : #CBLogRuleAction,
	#superclass : #CBAbstractRuleAction,
	#category : #'Migrate-Tool-CriticBrowser-data-buttons'
}

{ #category : #accessing }
CBLogRuleAction class >> groupPriority [ 
	^ 20
]

{ #category : #testing }
CBLogRuleAction class >> runOn: aCriticBrowser [
self flag: #mustDie.
	(UIManager default
		confirm:
			'Do you want to save all false positive and toDo in the Manifests ?
(this action may generate new manifest classes and make dirty your package)')
		ifTrue: [ aCriticBrowser  logInManifest ]
]

{ #category : #accessing }
CBLogRuleAction class >> title [ 
	^ 'Save Critics' 
]
