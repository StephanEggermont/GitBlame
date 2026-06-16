Class {
	#name : 'LogModelExamples',
	#superclass : 'Object',
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'as yet unclassified' }
LogModelExamples >> calculatedLog [
	<gtExample>
	|repo log|
	repo := self exampleRepository.
	log := repo log.
	self assert: log isEmpty not.
	^log
]

{ #category : 'as yet unclassified' }
LogModelExamples >> exampleModel [
	<gtExample>
	|model|
	model := LogModel new.
	model root: self rootLocation.
	self assert: model repositories size = 0.
	^model
]

{ #category : 'as yet unclassified' }
LogModelExamples >> exampleRepository [
	<gtExample>
	|model repo|
	model := self exampleModel.
	repo := model addRepository: 'utrecht'.
	self assert: repo model = model.
	^repo
]

{ #category : 'as yet unclassified' }
LogModelExamples >> rootLocation [
	<gtExample>
	^FileLocator home / 'nl-design-system'
]
