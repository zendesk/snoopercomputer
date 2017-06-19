module FeatureHelper
  def applicable_endpoints
    current_targets.endpoints.select do |endpoint|
      if endpoint.features && !endpoint.features.empty?
        # Features list for endpoint exists, so determine if the current spec matches any of the entries
        endpoint.features.any? do |feature|
          should_run_for_endpoint?(feature.name)
        end
      else
        # Run for the current endpoint because no features list exists to filter on
        true
      end
    end
  end

  private

  def should_run_for_endpoint?(feature)
    # Check for spec that matches feature name in call stack to determine if the current spec
    # should be run against the current endpoint
    caller.any? do |line|
      line.include?(feature)
    end
  end
end
