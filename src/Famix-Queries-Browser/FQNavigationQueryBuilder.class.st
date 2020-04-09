Class {
	#name : #FQNavigationQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> addAssociationToQuery: anAssociation [
	query addAssociation: anAssociation
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> allPossibleAssociations [
	^ query allPossibleAssociations
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> availableAssociations [
	^ query availableAssociationsFor: entities
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> availableDirections [
	^ query availableDirections
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> changeQueryNavigationDirection: aDirection [
	query direction: aDirection
]

{ #category : #accessing }
FQNavigationQueryBuilder >> currentQueryAssociations [
	^ query association associations
]

{ #category : #initialization }
FQNavigationQueryBuilder >> initializeQuery [
	super initializeQuery.
	query direction: self availableDirections first.
	query
		association:
			(FQAssociationNavigationQueryStrategy
				withAll: self availableAssociations)
]

{ #category : #accessing }
FQNavigationQueryBuilder >> queryClass [
	^ FQNavigationQuery
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> removeAssociationFromQuery: anAssociation [
	query removeAssociation: anAssociation
]