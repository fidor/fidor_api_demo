module EnvConfig
  extend self

  REQUIRED_KEYS = %w(
    FIDOR_API_CALLBACK
    FIDOR_API_CLIENT_ID
    FIDOR_API_CLIENT_SECRET
    FIDOR_API_LOGGING
    FIDOR_API_URL
    FIDOR_OAUTH_URL
  ).freeze

  UNDEFINED_VALUES = ["changeme", "undefined", "", nil].freeze

  def incomplete?
    missing_keys.any?
  end

  def present?(key)
    !get(key).in? UNDEFINED_VALUES
  end

  def get(key)
    hash[key]
  end

  private

  def missing_keys
    hash.to_a.select { |key, value| value.in? UNDEFINED_VALUES }
  end

  def hash
    REQUIRED_KEYS.each_with_object({}) do |key, object|
      object[key] = ENV[key] || "undefined"
    end
  end
end
