Class {
	#name : #FQBooleanPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #initialization }
FQBooleanPropertyQueryBuilderTest >> queryBuilderClass [
	^ FQBooleanPropertyQueryBuilder
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testChangeQueryProperty [
	queryBuilder changeQueryProperty: #isAbstract.
	self assert: queryBuilder query property equals: #isAbstract
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQBooleanQuery.
	self
		assert:
			(queryBuilder availableProperties
				includes: queryBuilder query property)
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryProperty: #isAbstract.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
]