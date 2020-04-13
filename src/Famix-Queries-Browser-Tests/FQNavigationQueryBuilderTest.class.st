Class {
	#name : #FQNavigationQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #initialization }
FQNavigationQueryBuilderTest >> queryBuilderClass [
	^ FQNavigationQueryBuilder
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testAddAllAssociation [
	self
		flag: 'This test should be in FQNavigationQuery, not here';
		skip: ''.
	queryBuilder allPossibleAssociations
		do: [ :assoc | queryBuilder addAssociationToQuery: assoc ].
	self
		assert: queryBuilder query association class
		identicalTo: FQAllAssociationsNavigationQueryStrategy
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testAddAssociationToQuery [
	queryBuilder addAssociationToQuery: FamixTInheritance.
	self
		assert: (queryBuilder currentQueryAssociations includes: FamixTInheritance)
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testChangeQueryNavigationDirection [
	queryBuilder
		changeQueryNavigationDirection: FQIncomingNavigationQueryStrategy.
	self
		assert: queryBuilder query direction
		identicalTo: FQIncomingNavigationQueryStrategy
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testErrorOnInitializeQuery [
	self impossibleInitializationShouldRaiseAnError
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testRemoveAssociationFromQuery [
	queryBuilder removeAssociationFromQuery: FamixTInvocation.
	self
		deny: (queryBuilder currentQueryAssociations includes: FamixTInvocation)
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testinitializeQuery [
	self assert: queryBuilder query class identicalTo: FQNavigationQuery.
	self
		assert:
			(queryBuilder query direction
				inheritsFrom: FQAbstractDirectionNavigationQueryStrategy).
	self
		assert:
			(queryBuilder query association
				isKindOf: FQAbstractAssociationNavigationQueryStrategy).
	self
		assert:
			(queryBuilder availableAssociations
				includesAll: queryBuilder currentQueryAssociations)
]