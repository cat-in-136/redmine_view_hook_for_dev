# frozen_string_literal: true

Redmine::Plugin.register :redmine_view_hook_for_dev do
  name 'Redmine View Hook for Dev plugin'
  author '@cat_in_136'
  description 'show view hook for development'
  version '0.0.0'
  url 'https://github.com/cat-in-136/redmine_view_hook_for_dev'
  author_url 'https://github.com/cat-in-136/'
end

module RedmineViewHookForDev
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

Redmine::Hook.send(:include, RedmineViewHookForDev)
