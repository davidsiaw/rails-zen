# frozen_string_literal: true

# ------------------------------------------------------------------------------
# Has any changes happened inside the actual library code?
# ------------------------------------------------------------------------------
has_app_changes = !git.modified_files.grep(/app/).empty?
has_spec_changes = !git.modified_files.grep(/spec/).empty?

# ------------------------------------------------------------------------------
# You've made changes to lib, but didn't write any tests?
# ------------------------------------------------------------------------------
if has_app_changes && !has_spec_changes
  warn(<<~WARNING, sticky: false)
    There're library changes, but not tests.
    That's OK as long as you're refactoring existing code.
  WARNING
end

# ------------------------------------------------------------------------------
# Mainly to encourage writing up some reasoning about the PR, rather than
# just leaving a title
# ------------------------------------------------------------------------------
if github.pr_body.length < 5
  fail 'Please provide a summary in the Pull Request description'
end

# ------------------------------------------------------------------------------
# You've made changes to specs, but no library code has changed?
# ------------------------------------------------------------------------------
if !has_app_changes && has_spec_changes
  warn(<<~WARNING, sticky: false)
    We really appreciate pull requests that demonstrate issues, even without a fix.
    That said, the next step is to try and fix the failing tests!
  WARNING
end

# ------------------------------------------------------------------------------
# Don't let testing shortcuts get into master by accident,
# ensuring that we don't get green builds based on a subset of tests.
# ------------------------------------------------------------------------------

(git.modified_files + git.added_files - %w[Dangerfile]).each do |file|
  next unless File.file?(file)

  contents = File.read(file)
  if file.start_with?('spec')
    fail("`xit` or `fit` left in tests (#{file})") if contents =~ /^\w*[xf]it/
    fail("`fdescribe` left in tests (#{file})") if contents =~ /^\w*fdescribe/
  end
end

# ------------------------------------------------------------------------------
# Make a note about contributors not in the organization
# ------------------------------------------------------------------------------
unless github.api.organization_member?('bunnylabs', github.pr_author)
  # Pay extra attention if they modify stuff
  important_files = %w[Gemfile Dangerfile]
  modified_important_files = git.modified_files & important_files
  unless modified_important_files.empty?
    warn <<~WARNING
      External contributor has edited these files: #{modified_important_files.to_a.inspect}"
    WARNING
  end
end

# ------------------------------------------------------------------------------
# Thanks other people!
# ------------------------------------------------------------------------------
message(':tada:') if github.pr_author != 'davidsiaw'

# ------------------------------------------------------------------------------
# Ensure a clean commits history
# ------------------------------------------------------------------------------
branch = github.branch_for_base
if git.commits.any? { |c| c.message =~ /^Merge branch '#{branch}'/ }
  fail('Please rebase to get rid of the merge commits in this PR')
end
