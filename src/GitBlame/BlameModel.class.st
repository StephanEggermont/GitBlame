Class {
	#name : #BlameModel,
	#superclass : #Object,
	#instVars : [
		'root',
		'files',
		'commits',
		'chunks',
		'authors'
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

{ #category : #accessing }
BlameModel >> authors [
	^ authors
]

{ #category : #accessing }
BlameModel >> authors: anObject [
	authors := anObject
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
BlameModel >> gtOverview: aView [
	<gtView>
	^(aView mondrian)
			title: 'Overview';
		priority: 20;
		painting: [ :aMondrian |
			aMondrian nodes
				stencil: [ :f | 
					BlElement new 
						constraintsDo: [:c |
							c horizontal fitContent.
							c vertical fitContent];
						zIndex: 10;
							border: (BlBorder paint: (Color black alpha: 0.5) width: 2)];
				with: files forEach: [:file |
					aMondrian nodes
						stencil: [ :c | 
							BlElement new 
							height: (c chunks size min: 20);
							width: 5;
							zIndex: 10;
							border: (BlBorder paint: (Color green alpha: 0.5) width: 1)];
					with: file commits.
					aMondrian layout grid].

					
			aMondrian layout grid.
		]

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
	| doneNr|
	doneNr := 0.
	files do: [:each |
		[each blame: 
			(GtSubprocessWithInMemoryOutput new
				workingDirectory: root;
				command: 'git';
				arguments: {'blame'. '-c'. each fileReference fullName};
				runAndWait;
				stdout)] asAsyncPromise then: [doneNr := doneNr+1]].
 	[0.1 seconds wait] doWhileTrue: [doneNr < files size].
				
]
