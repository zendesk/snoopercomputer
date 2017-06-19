module FeatureHelper
  # Filters list of defined endpoints down to endpoints applicable to the current spec.
  #
  # Assuming a targets file like the one in the example below, this method will return an array
  # containing the objects (as hashes) from the +endpoints+ array where the +features+ array
  # contains a string that fuzzy matches on the current spec filename.
  #
  # If the +features+ array is not present for a given endpoint, it will just run by default.
  # @example Example targets JSON file
  #   {
  #     "base_url": "https://example.com",
  #     "endpoints": [
  #       {
  #         "url": "/users/1",
  #         "features": [
  #           { "name": "clickjacking_defense" }
  #         ]
  #       }
  #     ]
  #   }
  # @return [Array<Hash{String => String}>]
  def applicable_endpoints
    current_targets.endpoints.select do |endpoint|
      if endpoint.features && !endpoint.features.empty?
        # Features list for endpoint exists, so determine if the current spec matches any of the entries
        endpoint.features.any? do |feature|
          should_run_for_endpoint?(feature.name)
        end
      else
        # Run for this endpoint because no features list exists to filter on
        true
      end
    end
  end

  private

  # Checks in the call stack for calls originating from a spec file with a filename
  # that matches +feature+. Returns true if a matching call is found.
  #
  # @api private
  # @param feature [String] Name of feature, read from targets file
  # @return [Boolean]
  def should_run_for_endpoint?(feature)
    caller.any? do |line|
      line.include?(feature)
    end
  end
end
