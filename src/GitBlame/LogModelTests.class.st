Class {
	#name : 'LogModelTests',
	#superclass : 'TestCase',
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'as yet unclassified' }
LogModelTests >> testAModelKnowsItsCommits [
	|model|
	model := LogModel new.
	self assert: model commits isEmpty
]

{ #category : 'as yet unclassified' }
LogModelTests >> testAModelKnowsItsCommitters [
	|model|
	model := LogModel new.
	self assert: model committers isEmpty
]

{ #category : 'as yet unclassified' }
LogModelTests >> testAModelKnowsItsRepositories [
	|model|
	model := LogModel new.
	self assert: model repositories isEmpty
]

{ #category : 'as yet unclassified' }
LogModelTests >> testModelCanAddARepository [
	|model|
	model := LogModel new.
	model root: (FileLocator home / 'nl-design-system').
	model addRepository: 'utrecht'.
	self assert: model repositories size equals: 1
]

{ #category : 'as yet unclassified' }
LogModelTests >> testModelKnowsItsRootDirectory [
	|model|
	model := LogModel new.
	self assert: model root isNil
]
