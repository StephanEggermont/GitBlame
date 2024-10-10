Class {
	#name : #BlameAuthor,
	#superclass : #Object,
	#instVars : [
		'model',
		'authorName',
		'email',
		'commits'
	],
	#category : #'GitBlame-Model'
}

{ #category : #accessing }
BlameAuthor >> authorName [
	^ authorName
]

{ #category : #accessing }
BlameAuthor >> authorName: anObject [
	authorName := anObject
]

{ #category : #accessing }
BlameAuthor >> commits [
	^ commits
]

{ #category : #accessing }
BlameAuthor >> commits: anObject [
	commits := anObject
]

{ #category : #accessing }
BlameAuthor >> email [
	^ email
]

{ #category : #accessing }
BlameAuthor >> email: anObject [
	email := anObject
]

{ #category : #'as yet unclassified' }
BlameAuthor >> initialize [
	commits := OrderedCollection new
]

{ #category : #accessing }
BlameAuthor >> model [
	^ model
]

{ #category : #accessing }
BlameAuthor >> model: anObject [
	model := anObject
]
