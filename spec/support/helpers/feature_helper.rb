module FeatureHelper
  def map_feature_to_targets(&block)
    current_targets.endpoints.each do |endpoint|
      if endpoint.features && !endpoint.features.empty?
        endpoint.features.each do |feature|
          if block.source_location[0].include? feature
            block.call(endpoint.url)
          end
        end
      else
        block.call(endpoint.url)
      end
    end
  end
end
