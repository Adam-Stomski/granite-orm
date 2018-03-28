require "./collection"

class Granite::ORM::AssociationCollection(Owner, Target)
  include Enumerable(Target)

  @target : Collection(Target)

  private getter target_loaded
  private getter target
  private getter owner

  def initialize(owner : Owner)
    @owner = owner
    @target_loaded = false
    @target = Collection(Target).new
  end

  def each
    load_target!
    target.each { |t| yield t }
  end

  def destroy_all
    load_target!
    target.destroy_all
  end

  def find_each
    Target.find_each(clause, [owner.id]) do |t|
      yield t
    end
  end

  private def load_target!
    return if target_loaded || !owner.id?
    @target = Target.all(clause, owner.id)
    @target_loaded = true
  end

  private def foreign_key
    "#{Target.table_name}.#{Owner.table_name[0...-1]}_id"
  end

  private def clause
    "WHERE #{foreign_key} = ?"
  end
end
