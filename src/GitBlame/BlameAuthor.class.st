Class {
	#name : #BlameAuthor,
	#superclass : #Object,
	#instVars : [
		'model',
		'authorName',
		'email',
		'commits',
		'color'
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
BlameAuthor >> color [
	^ color
]

{ #category : #accessing }
BlameAuthor >> color: anObject [
	color := anObject
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
	commits := IdentitySet new
]

{ #category : #accessing }
BlameAuthor >> model [
	^ model
]

{ #category : #accessing }
BlameAuthor >> model: anObject [
	model := anObject
]
