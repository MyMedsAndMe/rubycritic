# frozen_string_literal: true
module RubyCritic
  module ViewHelpers
    def timeago_tag(time)
      "<time class='js-timeago' datetime='#{time}'>#{time}</time>"
    end

    def javascript_tag(file)
      "<script src='" + asset_path("javascripts/#{file}.js").to_s + "'></script>"
    end

    def stylesheet_path(file)
      asset_path("stylesheets/#{file}.css")
    end

    def asset_path(file)
      relative_path("assets/#{file}")
    end

    def file_path(file)
      relative_path(file)
    end

    def smell_location_path(location)
      smell_location = "#{location.pathname.sub_ext('.html')}#L#{location.line}"
      if Config.mode == :compare_branches
        "file://#{File.expand_path(Config.feature_root_directory)}/#{smell_location}"
      else
        file_path("#{smell_location}.to_s")
      end
    end

    def code_index_path(root_directory)
      "file://#{File.expand_path(root_directory)}/code_index.html"
    end

    private

    def relative_path(file)
      (root_directory + file).relative_path_from(file_directory)
    end

    def file_directory
      raise NotImplementedError,
            "The #{self.class} class must implement the #{__method__} method."
    end

    def root_directory
      raise NotImplementedError,
            "The #{self.class} class must implement the #{__method__} method."
    end
  end
end
