"
my actions is to: 
	to reset the CritcBrowser and run SelectPackageBrowser (who ask you wich package you want to check his rules)
"
Class {
	#name : #CBResetRuleAction,
	#superclass : #CBAbstractRuleAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #accessing }
CBResetRuleAction class >> priority [ 
	^ 1 
]

{ #category : #testing }
CBResetRuleAction class >> runOn: aCriticBrowser [
	self flag: #mustDie.
	(UIManager default
		confirm:
			'Do you want to delete the current configuration
 and create a new configuration ?') ifFalse: [ ^ self ].

	aCriticBrowser delete.
	SelectPackageBrowser open
]

{ #category : #accessing }
CBResetRuleAction class >> title [ 
	^ 'Run new confuration'
]