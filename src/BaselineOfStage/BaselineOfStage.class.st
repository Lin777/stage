Class {
	#name : #BaselineOfStage,
	#superclass : #BaselineOf,
	#category : #BaselineOfStage
}

{ #category : #baselines }
BaselineOfStage >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec package: 'Stage';
			package: 'Stage-Tests']
]
