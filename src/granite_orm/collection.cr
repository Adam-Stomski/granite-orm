class Granite::ORM::Collection(Model)
  include Enumerable(Model)

  private getter data
  private getter data_loaded
  private getter load_block

  def initialize
    @load_block = -> { [] of Model }
    @data = [] of Model
    @data_loaded = false
  end

  def initialize(&block : -> Array(Model))
    @load_block = block
    @data = [] of Model
    @data_loaded = false
  end

  def each
    load_data! unless data_loaded
    data.each { |e| yield e }
  end

  def destroy_all
    each(&.destroy)
  end

  private def load_data!
    @data = load_block.call
    @data_loaded = true
  end
end
