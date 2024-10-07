Class {
	#name : #BaselineOfGitBlame,
	#superclass : #BaselineOf,
	#category : #BaselineOfGitBlame
}

{ #category : #loading }
BaselineOfGitBlame class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'GitBlame' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGitBlame >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GitBlame'
		]
]
