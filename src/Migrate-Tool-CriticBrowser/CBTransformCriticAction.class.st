"
see superClass 's documentation
	my work is to fix auto detect change 
	example 
		if a method use a String concatenation  instead of Stream putOn: 
"
Class {
	#name : #CBTransformCriticAction,
	#superclass : #CBAbstractCriticAction,
	#category : #'Migrate-Tool-CriticBrowser-data-buttons'
}

{ #category : #accessing }
CBTransformCriticAction class >> groupPriority [
	^ 10
]

{ #category : #accessing }
CBTransformCriticAction class >> runOn: aCriticBrowser [
	aCriticBrowser selectedCritic 
		ifNotNil: [ :itemCritic | itemCritic change execute ]
		ifNil: [ self inform: 'i don ' , $' , 't known how  to active' ]
]

{ #category : #accessing }
CBTransformCriticAction class >> title [
	^ 'Transform'
]
