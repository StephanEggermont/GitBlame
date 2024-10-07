Class {
	#name : #BlameModel,
	#superclass : #Object,
	#instVars : [
		'root',
		'files',
		'commits',
		'chunks'
	],
	#category : #'GitBlame-Model'
}

{ #category : #accessing }
BlameModel class >> on: rootDirectory [ 
	^self new
		root: rootDirectory;
		yourself
]

{ #category : #accessing }
BlameModel >> addFilesMatching: aString [ 
	files addAll: ((root allChildrenMatching: aString) collect: [: each| BlameFile on: each in: self])
]

{ #category : #'as yet unclassified' }
BlameModel >> commitAt: aCommitish [
	^commits at: aCommitish ifAbsentPut: [
		BlameCommit new
			model: self;
			commitish: aCommitish;
			yourself]
]

{ #category : #'as yet unclassified' }
BlameModel >> initialize [
	files := OrderedCollection new.
	commits := Dictionary new.
	
]

{ #category : #accessing }
BlameModel >> parseBlameFiles [
	files do: [:each | each parse]
]

{ #category : #accessing }
BlameModel >> root: rootDirectory [ 
	root := rootDirectory
]

{ #category : #accessing }
BlameModel >> runBlame [
	files do: [:each |
		each blame: 
			(GtSubprocessWithInMemoryOutput new
				workingDirectory: root;
				command: 'git';
				arguments: {'blame'. each fileReference fullName};
				runAndWait;
				stdout)]

]
