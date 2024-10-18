Class {
	#name : #BlameModel,
	#superclass : #Object,
	#instVars : [
		'root',
		'files',
		'commits',
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
BlameModel >> assignColors [
	|colors|
	colors := Color wheel: (50 min: authors size).
	authors do: [:author | author color: Color white].
	((authors sorted: [:a :b | a commits size > b commits size]) first: (50 min: authors size))
		withIndexDo: [:author :index|
			author color: (colors at: index)]
]

{ #category : #'as yet unclassified' }
BlameModel >> authorAt: anAuthorName [
	^authors at: anAuthorName ifAbsentPut: [
		BlameAuthor new
			model: self;
			authorName: anAuthorName;
			yourself]
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
BlameModel >> gtHundredLargest: aView [
	<gtView>
	^(aView mondrian)
			title: '100 largest';
		priority: 30;
		painting: [ :aMondrian |
			aMondrian nodes
				stencil: [ :f | 
					BlElement new 
						constraintsDo: [:c |
							c horizontal fitContent.
							c vertical fitContent];
						zIndex: 10;
							border: (BlBorder paint: (Color black alpha: 0.5) width: 1)];
				with: (self largestFilesFirst first: (100 min: files size))
					forEach: [:file |
					aMondrian nodes
						stencil: [ :c | 
							BlElement new 
							height: (((c chunkFor: file fileReference) lines size * 2 ln min: 20) max: 2);
							width: ((c chunks size * 2 ln min: 20) max: 2);
							zIndex: 10;
							background: (c author color)];
					with: file newestCommitsFirst.
					aMondrian layout grid].

					
			aMondrian layout rectanglePack.
		]
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
							border: (BlBorder paint: (Color black alpha: 0.5) width: 1)];
				with: self largestFilesFirst forEach: [:file |
					aMondrian nodes
						stencil: [ :c | 
							BlElement new 
							height: 2;
							width: 2;
							zIndex: 10;
							border: (BlBorder paint: (c author color) width: 1)];
					with: file newestCommitsFirst.
					aMondrian layout grid].

					
			aMondrian layout rectanglePack.
		]

]

{ #category : #'as yet unclassified' }
BlameModel >> gtTopAuthors: aView [
	<gtView>
	^(aView mondrian)
			title: '50 authors';
		priority: 40;
		painting: [ :aMondrian |
			aMondrian nodes
				stencil: [ :author | 
					BlElement new 
						constraintsDo: [:c |
							c horizontal fitContent.
							c vertical fitContent];
						zIndex: 10;
							border: (BlBorder paint: author color width: 1)];
				with: (self topAuthors)
					forEach: [:author |
					aMondrian nodes
						stencil: [ :commit | 
							BlElement new 
							height: (((commit chunks sum: [:c | c lines size]) ln min: 20) max: 2);
							width: ((commit chunks size * 2 ln min: 20) max: 2);
							zIndex: 10;
							background: commit commitColor];
					with: author newestCommitsFirst.
					aMondrian layout grid].
			aMondrian layout rectanglePack.
		]
]

{ #category : #'as yet unclassified' }
BlameModel >> initialize [
	files := OrderedCollection new.
	commits := Dictionary new.
	authors := Dictionary new
	
]

{ #category : #'as yet unclassified' }
BlameModel >> largestFilesFirst [
	^files sorted: [:a :b | 
		a blame lines size > b blame lines size]
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

{ #category : #'as yet unclassified' }
BlameModel >> topAuthors [
	^authors select: [:each | each color  ~= Color white]
]
