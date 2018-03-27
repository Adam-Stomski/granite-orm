class Granite::ORM::AssociationCollection(Owner, Target)
  include Enumerable(Target)

  private getter target_loaded
  private getter target
  private getter owner

  def initialize(owner : Owner)
    @owner = owner
    @target_loaded = false
    @target = [] of Target
  end

  def each
    load_target! unless target_loaded
    target.each { |t| yield t }
  end

  private def load_target!
  end
end
