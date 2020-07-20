class Hubspot::Page < Hubspot::Resource
  self.id_field = "id"
  self.update_method = "put"

  ALL_PATH     = '/content/api/v2/pages'
  UPDATE_PATH  = '/content/api/v2/pages/:id'
  DELETE_PATH  = '/content/api/v2/pages/:id'
  FIND_PATH    = '/content/api/v2/pages/:id'
  CLONE_PATH   = '/content/api/v2/pages/:id/clone'

  class << self

    def clone_page(id, opts)
      result = Hubspot::Connection.post_json(CLONE_PATH, params: { id: id }, body: opts.stringify_keys)
      Hubspot::Page.from_result(result)
    end

    def update!(id, properties = {})
      response = Hubspot::Connection.put_json(update_path, params: { id: id, no_parse: true }, body: properties)
      response.success?
    end
  end

  def save
    response = Hubspot::Connection.put_json(update_path, params: { id: @id }, body: @changes.stringify_keys)
    update_from_changes
    @persisted = true
    true
  end
end
