ActiveRecord::Base.descendants.each do |klass|
	klass.cons_set('Vacina::PrivateAssociationRelation', Object)
  klass.const_set('PrivateAssociationRelation', Object)
  klass.const_set('PrivateAssociationRelationWhereChain', Object)
  klass.const_set('PrivateCollectionProxy', Object)
  klass.const_set('PrivateRelation', Object)
  klass.const_set('PrivateRelationWhereChain', Object)
end
