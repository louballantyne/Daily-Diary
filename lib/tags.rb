class Tags
  attr_accessor :tag, :entry_id, :id

  def initialize(tag, entry_id, id)
    @tag = tag
    @entry_id = entry_id
    @id = id
  end

end
