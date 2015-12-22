module Cachable
  CACHE_TIME = 120
  @timestamp = nil
  @cache_data = nil

  def get_cache
    @cache_data
  end

  def update_cache(data)
    @cache_data = data
    @timestamp = Time.now
  end

  def cache_expired?
    @timestamp.nil? || @timestamp + CACHE_TIME < Time.now
  end
end
