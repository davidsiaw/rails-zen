# frozen_string_literal: true

# Api Generator
# rubocop:disable Metrics/ClassLength
class ApiGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)
  argument :resource_name, type: :string
  argument :member_list,
           type: :array,
           default: [],
           banner: 'field[:type] field[:type]'

  def generate_init
    generate_api
    generate_api_tests

    if behavior == :invoke
      mount_api
    elsif behavior == :revoke
      unmount_api
    end
  end

  def resource_name_singular
    resource_name.underscore.singularize
  end

  def resource_name_plural
    resource_name_singular.pluralize
  end

  def class_name
    resource_name_plural.camelize + 'Api'
  end

  def basic_types
    %w[string integer boolean]
  end

  def ptype_of(tokens)
    basic_types.include?(tokens[1]) ? tokens[1] : 'string'
  end

  def pname_of(tokens)
    basic_types.include?(tokens[1]) ? tokens[0] : "#{tokens[0]}_id"
  end

  def fields
    @fields ||= member_list.map do |member|
      tokens = member.split(':')
      [tokens[0], {
        param_name: pname_of(tokens),
        param_type: ptype_of(tokens),
        full_type: tokens[1]
      }]
    end.to_h
  end

  private

  def generate_api
    template 'api_template.rb.erb', "app/apis/v1/#{resource_name_plural}_api.rb"
  end

  def generate_api_tests
    template 'api_spec_template.rb.erb',
             "spec/apis/v1/#{resource_name_plural}_api_spec.rb"
  end

  def destination_path(path)
    File.join(destination_root, path)
  end

  def main_api_path
    @main_api_path ||= destination_path('app/apis/main_api.rb')
  end

  def idxof(array, pattern)
    idx = 0
    array.each do |line|
      return idx if line =~ pattern

      idx += 1
    end
  end

  def content_breakup
    @content_breakup ||= begin
      content_lines = File.read(main_api_path).split("\n")

      idx_start = idxof(content_lines, /^\s+mount V1::HealthApi$/)
      idx_end = idxof(content_lines[idx_start..-1], /^(\s+)end$/) + idx_start

      {
        start: content_lines[0...idx_start],
        list: content_lines[idx_start...idx_end],
        end: content_lines[idx_end..-1]
      }
    end
  end

  def mount_statement
    "mount V1::#{class_name}"
  end

  def mount_list
    content_breakup[:list]
  end

  def mount_list_sans_statement
    mount_list.filter { |x| x !~ /#{mount_statement}/ }
  end

  def mount_start
    content_breakup[:start]
  end

  def mount_end
    content_breakup[:end]
  end

  def mount_api
    return if mount_list.any? { |x| x =~ /#{mount_statement}/ }

    result = [mount_start,
              mount_list,
              "    #{mount_statement}",
              mount_end].join("\n") + "\n"

    File.open(main_api_path, 'wb') { |file| file.write(result) }
  end

  def unmount_api
    return unless mount_list.any? { |x| x =~ /#{mount_statement}/ }

    result = [mount_start,
              mount_list_sans_statement,
              mount_end].join("\n") + "\n"

    File.open(main_api_path, 'wb') { |file| file.write(result) }
  end
end
# rubocop:enable Metrics/ClassLength
