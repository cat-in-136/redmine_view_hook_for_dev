# frozen_string_literal: true

Redmine::Plugin.register :redmine_view_hook_for_dev do
  name 'Redmine View Hook for Dev plugin'
  author '@cat_in_136'
  description 'show view hook for development'
  version '0.0.0'
  url 'https://github.com/cat-in-136/redmine_view_hook_for_dev'
  author_url 'https://github.com/cat-in-136/'
end

class RedmineViewHookForDevHook < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context={})
    '<style type="text/css">.redmine_view_hook_for_dev { font-weight: bold; color: red; }</style>'
  end
end

module RedmineViewHookForDevPatch
  def self.included(base)
    base.singleton_class.send(:prepend, RedmineHookPatch)
  end

  module RedmineHookPatch
    def call_hook(hook, context={})
      [
        "<p class=\"redmine_view_hook_for_dev\">#{hook}</p>",
        *(super(hook, context)),
      ]
    end
  end
end

Redmine::Hook.send(:include, RedmineViewHookForDevPatch)
