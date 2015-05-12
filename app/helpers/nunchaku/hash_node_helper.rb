module Nunchaku
  module HashNodeHelper

    def leaf_or_branch(node, key, type)
      node[key].kind_of?(Hash) || node[key].kind_of?(Array) ? branch(node, key, type) : leaf(node, key, type)
    end

    protected

    def leaf(node, key, type)
      content_tag(:div, :class => 'tree-item') do
        content_tag(:div, :class => 'tree-item-name') do
          "#{leaf_tip(node, key, type)}: #{node[key]}".html_safe
        end
      end
    end

    def branch(node, key, type)
      v = node[key]

      content_tag(:div, :class => 'tree-folder') do
        [
          content_tag(:div, :class => 'tree-folder-header') do
            content_tag(:div, :class => 'tree-folder-name') do
              tooltip("data-original-title" => branch_title_description(node, key)) do
                key.to_s
              end
            end
          end,

          content_tag(:div,:class => 'tree-folder-content') do
            content_tag(:div, :class => 'tree-folder-name') do
              if v.kind_of?(Hash)
                render :partial => 'hash_node', :object => v, :locals => {:type => type}
               else
                render :partial => 'hash_node', :collection => v, :locals => {:type => type}
               end
            end
          end
        ].join.html_safe
      end
    end

    def leaf_tip(node, key, type)
      tooltip(:title => leaf_title(node, key, type)) do
        "#{[key.to_s, ('*' if resource.api_required_attributes.include?(key.to_s))].compact.join}".html_safe
      end
    end

    def leaf_title(node, key, type)
      [
        leaf_title_type(node, key),
        leaf_title_description(node, key, type)
      ].compact.join(', ')
    end

    def leaf_title_type(node, key)
      t = node[key].class.name.underscore.humanize
      if t == 'Nil class'
        ch = node[:type].safe_constantize.columns_hash
        t = ch[key].try(:type) if ch.present?
        t ||= node[key]
      elsif t == 'Big decimal'
        t = 'Big decimal 19,4'
      end
      t ||= 'string'
    end

    def leaf_title_description(node, key, type)
      ltd = t("tooltip.#{type.underscore}.#{key}.description", :default => '')
      ltd unless ltd.empty?
    end

    def branch_title_description(node, key)
      case
        when node[key].kind_of?(Array)
          t("tooltip.datatype.array")
        when node[key].kind_of?(Hash)
          t("tooltip.datatype.hash")
        else
          nil
      end
    end
  end
end
