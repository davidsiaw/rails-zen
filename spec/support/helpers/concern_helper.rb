# frozen_string_literal: true

# helps us test concerns
module ConcernHelper
  def spec_dir
    File.dirname metadata[:file_path]
  end

  def it_has_concern(concern_name)
    require Rails.root.join "#{spec_dir}/concerns/#{concern_name.underscore}"
    it_behaves_like concern_name
  end
end
